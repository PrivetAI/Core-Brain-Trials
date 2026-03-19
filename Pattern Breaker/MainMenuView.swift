import SwiftUI

struct MainMenuView: View {
    @ObservedObject var engine: GameEngine
    @ObservedObject var scoreStore: ScoreStore
    @State private var glowPulse = false
    @State private var titleGlitch = false
    @State private var matrixOpacity: Double = 0.15
    
    var body: some View {
        ZStack {
            BrandColors.base.edgesIgnoringSafeArea(.all)
            
            MatrixRainView()
                .opacity(matrixOpacity)
            
            VStack(spacing: 0) {
                Spacer()
                
                VStack(spacing: 8) {
                    Text("PATTERN")
                        .font(.system(size: 42, weight: .black, design: .monospaced))
                        .foregroundColor(BrandColors.neonGreen)
                        .shadow(color: BrandColors.neonGreen.opacity(0.8), radius: glowPulse ? 20 : 8)
                        .offset(x: titleGlitch ? 2 : 0)
                    
                    Text("BREAKER")
                        .font(.system(size: 42, weight: .black, design: .monospaced))
                        .foregroundColor(BrandColors.purple)
                        .shadow(color: BrandColors.purple.opacity(0.8), radius: glowPulse ? 20 : 8)
                        .offset(x: titleGlitch ? -2 : 0)
                }
                .padding(.bottom, 16)
                
                HStack(spacing: 4) {
                    ForEach(0..<20, id: \.self) { i in
                        Rectangle()
                            .fill(i % 2 == 0 ? BrandColors.neonGreen : BrandColors.purple)
                            .frame(width: 12, height: 2)
                            .opacity(0.6)
                    }
                }
                .padding(.bottom, 32)
                
                // Stats row
                HStack(spacing: 16) {
                    GlowCard(glowColor: BrandColors.purple) {
                        VStack(spacing: 6) {
                            Text("HIGH SCORE")
                                .font(.system(size: 10, weight: .medium, design: .monospaced))
                                .foregroundColor(BrandColors.purple)
                            Text("\(scoreStore.bestScore)")
                                .font(.system(size: 28, weight: .bold, design: .monospaced))
                                .foregroundColor(BrandColors.neonGreen)
                                .shadow(color: BrandColors.neonGreen.opacity(0.5), radius: 8)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                    }
                    
                    GlowCard(glowColor: BrandColors.neonGreen) {
                        VStack(spacing: 6) {
                            Text("BEST LEVEL")
                                .font(.system(size: 10, weight: .medium, design: .monospaced))
                                .foregroundColor(BrandColors.neonGreen)
                            Text("\(scoreStore.highestLevel)")
                                .font(.system(size: 28, weight: .bold, design: .monospaced))
                                .foregroundColor(BrandColors.textWhite)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
                
                // START Button
                Button(action: {
                    engine.startGame()
                }) {
                    Text("S T A R T")
                        .font(.system(size: 24, weight: .black, design: .monospaced))
                        .foregroundColor(BrandColors.base)
                        .frame(width: 260, height: 64)
                        .background(BrandColors.neonGreen)
                        .cornerRadius(12)
                        .shadow(color: BrandColors.neonGreen.opacity(glowPulse ? 0.8 : 0.4), radius: glowPulse ? 20 : 10)
                }
                .padding(.bottom, 12)
                
                // Achievement count
                let achieveCount = scoreStore.unlockedAchievements.count
                let totalAchieve = ScoreStore.allAchievements.count
                Text("\(achieveCount)/\(totalAchieve) ACHIEVEMENTS")
                    .font(.system(size: 11, weight: .medium, design: .monospaced))
                    .foregroundColor(BrandColors.purple.opacity(0.7))
                
                Spacer()
                
                Text("v2.0")
                    .font(.system(size: 10, design: .monospaced))
                    .foregroundColor(BrandColors.textWhite.opacity(0.3))
                    .padding(.bottom, 8)
            }
            .padding()
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                glowPulse = true
            }
            Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
                titleGlitch = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    titleGlitch = false
                }
            }
        }
    }
}
