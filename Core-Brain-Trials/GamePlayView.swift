import SwiftUI

struct GamePlayView: View {
    @ObservedObject var engine: GameEngine
    @ObservedObject var scoreStore: ScoreStore
    @State private var eliminatedIndex: Int? = nil
    @State private var selectedIndex: Int? = nil
    @State private var shakeOffset: CGFloat = 0
    
    var timerColor: Color {
        if engine.timeRemaining > 15 { return BrandColors.neonGreen }
        else if engine.timeRemaining > 7 { return Color(red: 1, green: 0.8, blue: 0) }
        else { return Color.red }
    }
    
    var body: some View {
        ZStack {
            BrandColors.base.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                topBar
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .offset(x: shakeOffset)
                    .onChange(of: engine.showWrongFlash) { newValue in
                        if newValue {
                            withAnimation(.linear(duration: 0.05).repeatCount(4, autoreverses: true)) {
                                shakeOffset = 8
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                shakeOffset = 0
                            }
                        }
                    }
                
                timerBar
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                
                // Streak indicator
                if engine.currentStreak > 0 {
                    HStack(spacing: 4) {
                        Text("STREAK")
                            .font(.system(size: 9, weight: .medium, design: .monospaced))
                            .foregroundColor(Color(red: 1, green: 0.6, blue: 0))
                        Text("x\(engine.currentStreak)")
                            .font(.system(size: 11, weight: .bold, design: .monospaced))
                            .foregroundColor(Color(red: 1, green: 0.6, blue: 0))
                    }
                    .padding(.top, 6)
                }
                
                Spacer()
                
                if let puzzle = engine.currentPuzzle {
                    Text(puzzle.category.uppercased())
                        .font(.system(size: 11, weight: .medium, design: .monospaced))
                        .foregroundColor(BrandColors.purple)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(BrandColors.purple.opacity(0.15))
                        .cornerRadius(6)
                        .padding(.bottom, 8)
                }
                
                challengeCard
                    .padding(.horizontal, 20)
                
                Spacer()
                
                choicesGrid
                    .padding(.horizontal, 20)
                
                powerUpBar
                    .padding(.top, 16)
                    .padding(.horizontal, 20)
                
                Spacer().frame(height: 20)
            }
            
            FlashOverlay(color: BrandColors.neonGreen, isVisible: engine.showCorrectFlash)
            FlashOverlay(color: Color.red, isVisible: engine.showWrongFlash)
        }
    }
    
    var topBar: some View {
        VStack(spacing: 8) {
            // Hearts display
            HStack(spacing: 6) {
                ForEach(0..<engine.maxLives, id: \.self) { index in
                    HeartShape()
                        .fill(index < engine.lives ? BrandColors.neonGreen : BrandColors.darkGray)
                        .frame(width: 24, height: 24)
                        .shadow(color: index < engine.lives ? BrandColors.neonGreen.opacity(0.6) : Color.clear, radius: 4)
                        .scaleEffect(engine.gainedLife && index == engine.lives - 1 ? 1.3 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: engine.gainedLife)
                        .opacity(engine.lostLife && index == engine.lives ? 0 : 1)
                        .animation(.easeOut(duration: 0.3), value: engine.lostLife)
                }
            }
            .padding(.top, 4)
            
            HStack {
                GlowCard(glowColor: BrandColors.purple) {
                    VStack(spacing: 2) {
                        Text("LEVEL")
                            .font(.system(size: 9, weight: .medium, design: .monospaced))
                            .foregroundColor(BrandColors.purple)
                        Text("\(engine.currentLevel)")
                            .font(.system(size: 22, weight: .bold, design: .monospaced))
                            .foregroundColor(BrandColors.textWhite)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
                
                Spacer()
                
                GlowCard(glowColor: BrandColors.neonGreen) {
                    VStack(spacing: 2) {
                        Text("SCORE")
                            .font(.system(size: 9, weight: .medium, design: .monospaced))
                            .foregroundColor(BrandColors.neonGreen)
                        Text("\(engine.score)")
                            .font(.system(size: 22, weight: .bold, design: .monospaced))
                            .foregroundColor(BrandColors.textWhite)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
                
                Spacer()
                
                GlowCard(glowColor: timerColor) {
                    VStack(spacing: 2) {
                        Text("TIME")
                            .font(.system(size: 9, weight: .medium, design: .monospaced))
                            .foregroundColor(timerColor)
                        Text(String(format: "%.1f", engine.timeRemaining))
                            .font(.system(size: 22, weight: .bold, design: .monospaced))
                            .foregroundColor(timerColor)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
            }
        }
    }
    
    var timerBar: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 3)
                    .fill(BrandColors.darkGray)
                    .frame(height: 6)
                
                RoundedRectangle(cornerRadius: 3)
                    .fill(timerColor)
                    .frame(width: max(0, geo.size.width * CGFloat(engine.timeRemaining / engine.baseTime)), height: 6)
                    .shadow(color: timerColor.opacity(0.5), radius: 4)
            }
        }
        .frame(height: 6)
    }
    
    var challengeCard: some View {
        GlowCard(glowColor: BrandColors.neonGreen) {
            VStack(spacing: 12) {
                if let puzzle = engine.currentPuzzle {
                    Text(puzzle.question)
                        .font(.system(size: 20, weight: .bold, design: .monospaced))
                        .foregroundColor(BrandColors.textWhite)
                        .multilineTextAlignment(.center)
                        .lineLimit(4)
                        .minimumScaleFactor(0.6)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.vertical, 28)
        }
    }
    
    var choicesGrid: some View {
        VStack(spacing: 12) {
            if let puzzle = engine.currentPuzzle {
                ForEach(0..<puzzle.choices.count, id: \.self) { idx in
                    let isEliminated = eliminatedIndex == idx
                    
                    Button(action: {
                        guard !isEliminated else { return }
                        selectedIndex = idx
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            engine.submitAnswer(idx, scoreStore: scoreStore)
                            selectedIndex = nil
                            eliminatedIndex = nil
                        }
                    }) {
                        Text(puzzle.choices[idx])
                            .font(.system(size: 18, weight: .bold, design: .monospaced))
                            .foregroundColor(isEliminated ? BrandColors.darkGray : (selectedIndex == idx ? BrandColors.base : BrandColors.textWhite))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                isEliminated ? BrandColors.darkGray.opacity(0.3) :
                                (selectedIndex == idx ? BrandColors.neonGreen : BrandColors.cardBg)
                            )
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(
                                        isEliminated ? BrandColors.darkGray.opacity(0.2) : BrandColors.neonGreen.opacity(0.3),
                                        lineWidth: 1
                                    )
                            )
                    }
                    .disabled(isEliminated)
                }
            }
        }
    }
    
    var powerUpBar: some View {
        HStack(spacing: 12) {
            powerUpButton(title: "FREEZE", count: engine.powerUpFreezeAvailable, color: Color(red: 0.3, green: 0.7, blue: 1)) {
                engine.useFreezeTime()
            }
            
            powerUpButton(title: "HINT", count: engine.powerUpHintAvailable, color: BrandColors.purple) {
                if let idx = engine.useHint() {
                    eliminatedIndex = idx
                }
            }
            
            powerUpButton(title: "SKIP", count: engine.powerUpSkipAvailable, color: Color(red: 1, green: 0.6, blue: 0)) {
                engine.useSkip()
                eliminatedIndex = nil
            }
        }
    }
    
    func powerUpButton(title: String, count: Int, color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 2) {
                Text(title)
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(count > 0 ? color : BrandColors.darkGray)
                Text("x\(count)")
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                    .foregroundColor(count > 0 ? BrandColors.textWhite : BrandColors.darkGray)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(BrandColors.cardBg)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(count > 0 ? color.opacity(0.4) : BrandColors.darkGray.opacity(0.2), lineWidth: 1)
            )
        }
        .disabled(count <= 0)
    }
}

struct HeartShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: width/2, y: height))
        path.addCurve(
            to: CGPoint(x: 0, y: height/3),
            control1: CGPoint(x: width/2, y: height * 0.75),
            control2: CGPoint(x: 0, y: height/2)
        )
        path.addArc(
            center: CGPoint(x: width/4, y: height/4),
            radius: width/4,
            startAngle: .degrees(135),
            endAngle: .degrees(315),
            clockwise: false
        )
        path.addLine(to: CGPoint(x: width/2, y: height/3))
        path.addArc(
            center: CGPoint(x: width * 0.75, y: height/4),
            radius: width/4,
            startAngle: .degrees(225),
            endAngle: .degrees(45),
            clockwise: false
        )
        path.addCurve(
            to: CGPoint(x: width/2, y: height),
            control1: CGPoint(x: width, y: height/2),
            control2: CGPoint(x: width/2, y: height * 0.75)
        )
        
        return path
    }
}
