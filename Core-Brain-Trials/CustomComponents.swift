import SwiftUI

// MARK: - Theme System

enum AppTheme: String, CaseIterable, Codable {
    case defaultGreen = "Matrix"
    case cyberBlue = "Cyber"
    case infraRed = "Infra"
    
    var accent: Color {
        switch self {
        case .defaultGreen: return Color(red: 0, green: 230.0/255, blue: 118.0/255)
        case .cyberBlue: return Color(red: 0, green: 180.0/255, blue: 255.0/255)
        case .infraRed: return Color(red: 255.0/255, green: 60.0/255, blue: 80.0/255)
        }
    }
    
    var secondary: Color {
        switch self {
        case .defaultGreen: return Color(red: 157.0/255, green: 78.0/255, blue: 221.0/255)
        case .cyberBlue: return Color(red: 0, green: 255.0/255, blue: 200.0/255)
        case .infraRed: return Color(red: 255.0/255, green: 150.0/255, blue: 50.0/255)
        }
    }
}

class ThemeManager: ObservableObject {
    @Published var currentTheme: AppTheme = .defaultGreen
    
    private let themeKey = "pb_theme"
    
    init() {
        if let raw = UserDefaults.standard.string(forKey: themeKey),
           let theme = AppTheme(rawValue: raw) {
            currentTheme = theme
        }
    }
    
    func setTheme(_ theme: AppTheme) {
        currentTheme = theme
        UserDefaults.standard.set(theme.rawValue, forKey: themeKey)
    }
}

struct BrandColors {
    static let base = Color(red: 10.0/255, green: 10.0/255, blue: 10.0/255)
    static let neonGreen = Color(red: 0, green: 230.0/255, blue: 118.0/255)
    static let purple = Color(red: 157.0/255, green: 78.0/255, blue: 221.0/255)
    static let textWhite = Color.white
    static let cardBg = Color(red: 18.0/255, green: 18.0/255, blue: 18.0/255)
    static let darkGray = Color(red: 30.0/255, green: 30.0/255, blue: 30.0/255)
}

struct GlowCard<Content: View>: View {
    let glowColor: Color
    let content: Content
    
    init(glowColor: Color = BrandColors.neonGreen, @ViewBuilder content: () -> Content) {
        self.glowColor = glowColor
        self.content = content()
    }
    
    var body: some View {
        content
            .background(BrandColors.cardBg)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(glowColor.opacity(0.4), lineWidth: 1)
            )
            .shadow(color: glowColor.opacity(0.2), radius: 8, x: 0, y: 0)
    }
}

struct NeonButton: View {
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 18, weight: .bold, design: .monospaced))
                .foregroundColor(BrandColors.base)
                .padding(.horizontal, 32)
                .padding(.vertical, 14)
                .background(color)
                .cornerRadius(10)
                .shadow(color: color.opacity(0.6), radius: 10, x: 0, y: 0)
        }
    }
}

struct MatrixRainView: View {
    @State private var offsets: [CGFloat] = Array(repeating: 0, count: 20)
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(0..<20, id: \.self) { i in
                    MatrixColumn(
                        xPos: CGFloat(i) * (geo.size.width / 20),
                        height: geo.size.height,
                        offset: offsets[i]
                    )
                }
            }
            .onAppear {
                for i in 0..<20 {
                    offsets[i] = CGFloat.random(in: -200...0)
                }
            }
        }
        .allowsHitTesting(false)
    }
}

struct MatrixColumn: View {
    let xPos: CGFloat
    let height: CGFloat
    let offset: CGFloat
    @State private var animOffset: CGFloat = 0
    
    private let chars = "01234567890ABCDEF"
    
    var body: some View {
        VStack(spacing: 4) {
            ForEach(0..<15, id: \.self) { row in
                Text(String(chars.randomElement() ?? "0"))
                    .font(.system(size: 10, design: .monospaced))
                    .foregroundColor(BrandColors.neonGreen.opacity(Double(15 - row) / 20.0))
            }
        }
        .position(x: xPos, y: animOffset)
        .onAppear {
            withAnimation(
                Animation.linear(duration: Double.random(in: 4...8))
                    .repeatForever(autoreverses: false)
            ) {
                animOffset = height + 100
            }
        }
    }
}

struct PlayIcon: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 4, y: 0))
            path.addLine(to: CGPoint(x: 20, y: 10))
            path.addLine(to: CGPoint(x: 4, y: 20))
            path.closeSubpath()
        }
        .fill(BrandColors.neonGreen)
        .frame(width: 20, height: 20)
    }
}

struct TrophyIcon: View {
    var body: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 3)
                .fill(BrandColors.purple)
                .frame(width: 16, height: 12)
            Rectangle()
                .fill(BrandColors.purple)
                .frame(width: 4, height: 6)
            RoundedRectangle(cornerRadius: 1)
                .fill(BrandColors.purple)
                .frame(width: 12, height: 3)
        }
        .frame(width: 20, height: 22)
    }
}

struct GearIcon: View {
    var body: some View {
        ZStack {
            Circle()
                .stroke(BrandColors.textWhite, lineWidth: 2)
                .frame(width: 12, height: 12)
            ForEach(0..<6, id: \.self) { i in
                Rectangle()
                    .fill(BrandColors.textWhite)
                    .frame(width: 3, height: 6)
                    .offset(y: -10)
                    .rotationEffect(.degrees(Double(i) * 60))
            }
        }
        .frame(width: 24, height: 24)
    }
}

struct StarIcon: View {
    var body: some View {
        ZStack {
            ForEach(0..<5, id: \.self) { i in
                Rectangle()
                    .fill(Color(red: 1, green: 0.8, blue: 0))
                    .frame(width: 3, height: 10)
                    .offset(y: -6)
                    .rotationEffect(.degrees(Double(i) * 72))
            }
        }
        .frame(width: 22, height: 22)
    }
}

struct TabIcon: View {
    let type: String
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            Group {
                switch type {
                case "play":
                    PlayIcon()
                case "trophy":
                    TrophyIcon()
                case "star":
                    StarIcon()
                case "gear":
                    GearIcon()
                default:
                    Circle().fill(BrandColors.neonGreen).frame(width: 20, height: 20)
                }
            }
            .opacity(isSelected ? 1.0 : 0.5)
            
            Text(type == "play" ? "GAME" : type == "trophy" ? "SCORES" : type == "star" ? "FEATS" : "SETTINGS")
                .font(.system(size: 9, weight: .medium, design: .monospaced))
                .foregroundColor(isSelected ? BrandColors.neonGreen : BrandColors.textWhite.opacity(0.5))
        }
    }
}

struct FlashOverlay: View {
    let color: Color
    let isVisible: Bool
    
    var body: some View {
        color
            .opacity(isVisible ? 0.3 : 0)
            .edgesIgnoringSafeArea(.all)
            .allowsHitTesting(false)
    }
}
