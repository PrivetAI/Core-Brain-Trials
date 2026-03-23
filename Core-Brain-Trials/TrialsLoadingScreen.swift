import SwiftUI

struct TrialsLoadingScreen: View {
    @State private var pulse = false
    @State private var codeText = "0x00FF"
    
    var body: some View {
        ZStack {
            BrandColors.base.edgesIgnoringSafeArea(.all)
            
            MatrixRainView()
                .opacity(0.1)
            
            VStack(spacing: 20) {
                // Pulsing icon
                ZStack {
                    Circle()
                        .stroke(BrandColors.neonGreen.opacity(0.3), lineWidth: 2)
                        .frame(width: 80, height: 80)
                        .scaleEffect(pulse ? 1.3 : 0.9)
                    
                    Circle()
                        .fill(BrandColors.neonGreen.opacity(0.15))
                        .frame(width: 60, height: 60)
                    
                    // Code symbol
                    VStack(spacing: 2) {
                        Rectangle()
                            .fill(BrandColors.neonGreen)
                            .frame(width: 20, height: 3)
                        Rectangle()
                            .fill(BrandColors.neonGreen)
                            .frame(width: 14, height: 3)
                        Rectangle()
                            .fill(BrandColors.neonGreen)
                            .frame(width: 20, height: 3)
                    }
                }
                
                Text("CORE: BRAIN TRIALS")
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                    .foregroundColor(BrandColors.neonGreen)
                    .shadow(color: BrandColors.neonGreen.opacity(0.5), radius: 6)
                
                Text(codeText)
                    .font(.system(size: 11, design: .monospaced))
                    .foregroundColor(BrandColors.purple.opacity(0.6))
            }
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                pulse = true
            }
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
                let hex = String(format: "0x%04X", Int.random(in: 0...65535))
                codeText = hex
            }
        }
    }
}
