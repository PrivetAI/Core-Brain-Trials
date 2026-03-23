import SwiftUI

struct GameOverView: View {
    @ObservedObject var engine: GameEngine
    @ObservedObject var scoreStore: ScoreStore
    @State private var showAnimation = false
    @State private var glitchOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            BrandColors.base.edgesIgnoringSafeArea(.all)
            
            MatrixRainView()
                .opacity(0.08)
            
            VStack(spacing: 0) {
                Spacer()
                
                VStack(spacing: 8) {
                    Text("GAME OVER")
                        .font(.system(size: 36, weight: .black, design: .monospaced))
                        .foregroundColor(Color.red)
                        .shadow(color: Color.red.opacity(0.6), radius: 12)
                        .offset(x: glitchOffset)
                        .opacity(showAnimation ? 1 : 0)
                    
                    if engine.deathByLives {
                        Text("LIVES: 0")
                            .font(.system(size: 14, weight: .bold, design: .monospaced))
                            .foregroundColor(Color.red.opacity(0.8))
                            .opacity(showAnimation ? 1 : 0)
                    } else {
                        Text("TIME: 0")
                            .font(.system(size: 14, weight: .bold, design: .monospaced))
                            .foregroundColor(Color.red.opacity(0.8))
                            .opacity(showAnimation ? 1 : 0)
                    }
                }
                .padding(.bottom, 32)
                
                HStack(spacing: 16) {
                    GlowCard(glowColor: BrandColors.purple) {
                        VStack(spacing: 6) {
                            Text("LEVEL")
                                .font(.system(size: 11, weight: .medium, design: .monospaced))
                                .foregroundColor(BrandColors.purple)
                            Text("\(engine.currentLevel)")
                                .font(.system(size: 28, weight: .bold, design: .monospaced))
                                .foregroundColor(BrandColors.textWhite)
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 16)
                    }
                    .opacity(showAnimation ? 1 : 0)
                    
                    GlowCard(glowColor: BrandColors.neonGreen) {
                        VStack(spacing: 6) {
                            Text("SCORE")
                                .font(.system(size: 11, weight: .medium, design: .monospaced))
                                .foregroundColor(BrandColors.neonGreen)
                            Text("\(engine.score)")
                                .font(.system(size: 28, weight: .bold, design: .monospaced))
                                .foregroundColor(BrandColors.neonGreen)
                                .shadow(color: BrandColors.neonGreen.opacity(0.5), radius: 6)
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 16)
                    }
                    .opacity(showAnimation ? 1 : 0)
                }
                .padding(.bottom, 16)
                
                // Streak info
                if engine.currentStreak > 0 {
                    Text("BEST STREAK: \(engine.currentStreak)")
                        .font(.system(size: 12, weight: .bold, design: .monospaced))
                        .foregroundColor(Color(red: 1, green: 0.6, blue: 0))
                        .padding(.bottom, 8)
                }
                
                if engine.score > scoreStore.bestScore {
                    Text("NEW HIGH SCORE!")
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundColor(BrandColors.neonGreen)
                        .shadow(color: BrandColors.neonGreen.opacity(0.8), radius: 10)
                        .padding(.bottom, 24)
                }
                
                Spacer()
                
                Button(action: {
                    scoreStore.addScore(engine.score, level: engine.currentLevel)
                    engine.startGame()
                }) {
                    Text("PLAY AGAIN")
                        .font(.system(size: 20, weight: .black, design: .monospaced))
                        .foregroundColor(BrandColors.base)
                        .frame(width: 260, height: 56)
                        .background(BrandColors.neonGreen)
                        .cornerRadius(12)
                        .shadow(color: BrandColors.neonGreen.opacity(0.5), radius: 10)
                }
                .padding(.bottom, 16)
                
                Button(action: {
                    scoreStore.addScore(engine.score, level: engine.currentLevel)
                    engine.gameState = .menu
                }) {
                    Text("MAIN MENU")
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                        .foregroundColor(BrandColors.textWhite.opacity(0.7))
                        .frame(width: 260, height: 44)
                        .background(BrandColors.darkGray)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(BrandColors.textWhite.opacity(0.2), lineWidth: 1)
                        )
                }
                
                Spacer().frame(height: 40)
            }
            .padding()
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) {
                showAnimation = true
            }
            Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { _ in
                glitchOffset = CGFloat.random(in: -3...3)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    glitchOffset = 0
                }
            }
        }
    }
}
