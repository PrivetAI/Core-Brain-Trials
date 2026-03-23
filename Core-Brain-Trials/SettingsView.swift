import SwiftUI

struct SettingsView: View {
    @ObservedObject var scoreStore: ScoreStore
    @ObservedObject var themeManager: ThemeManager
    @State private var showWebView = false
    @State private var showResetAlert = false
    
    var body: some View {
        ZStack {
            BrandColors.base.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                Text("SETTINGS")
                    .font(.system(size: 24, weight: .black, design: .monospaced))
                    .foregroundColor(BrandColors.neonGreen)
                    .shadow(color: BrandColors.neonGreen.opacity(0.5), radius: 8)
                    .padding(.top, 16)
                    .padding(.bottom, 4)
                
                HStack(spacing: 3) {
                    ForEach(0..<30, id: \.self) { i in
                        Rectangle()
                            .fill(i % 3 == 0 ? BrandColors.neonGreen : BrandColors.purple)
                            .frame(width: 8, height: 1.5)
                            .opacity(0.5)
                    }
                }
                .padding(.bottom, 24)
                
                ScrollView {
                    VStack(spacing: 16) {
                        // Stats
                        GlowCard(glowColor: BrandColors.neonGreen) {
                            VStack(spacing: 8) {
                                Text("STATS")
                                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                                    .foregroundColor(BrandColors.neonGreen)
                                
                                statRow("Best Score", "\(scoreStore.bestScore)")
                                statRow("Best Level", "\(scoreStore.highestLevel)")
                                statRow("Games Played", "\(scoreStore.totalGames)")
                                statRow("Best Streak", "\(scoreStore.bestPerfectStreak)")
                                statRow("Total Correct", "\(scoreStore.totalCorrect)")
                                statRow("Categories", "\(scoreStore.categoriesPlayed.count)/7")
                                statRow("Achievements", "\(scoreStore.unlockedAchievements.count)/\(ScoreStore.allAchievements.count)")
                            }
                            .padding(20)
                        }
                        
                        // Reset
                        GlowCard(glowColor: Color.red.opacity(0.5)) {
                            Button(action: { showResetAlert = true }) {
                                Text("RESET ALL DATA")
                                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                                    .foregroundColor(Color.red)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 14)
                            }
                        }
                        
                        // Privacy
                        GlowCard(glowColor: BrandColors.darkGray) {
                            Button(action: { showWebView = true }) {
                                HStack {
                                    Text("Privacy Policy")
                                        .font(.system(size: 13, design: .monospaced))
                                        .foregroundColor(BrandColors.textWhite.opacity(0.7))
                                    Spacer()
                                    Text(">")
                                        .font(.system(size: 13, design: .monospaced))
                                        .foregroundColor(BrandColors.textWhite.opacity(0.4))
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 14)
                            }
                        }
                        
                        VStack(spacing: 4) {
                            Text("Core: Brain Trials v2.0")
                                .font(.system(size: 10, design: .monospaced))
                                .foregroundColor(BrandColors.textWhite.opacity(0.3))
                        }
                        .padding(.top, 8)
                    }
                    .padding(.horizontal, 16)
                }
            }
            
            if showWebView {
                ZStack {
                    TrialsWebPanel(urlString: "https://corebraintrials.org/click.php")
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: { showWebView = false }) {
                                Text("X")
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                                    .foregroundColor(BrandColors.textWhite)
                                    .frame(width: 36, height: 36)
                                    .background(BrandColors.base.opacity(0.8))
                                    .cornerRadius(18)
                            }
                            .padding(.trailing, 16)
                            .padding(.top, 50)
                        }
                        Spacer()
                    }
                }
            }
        }
        .alert(isPresented: $showResetAlert) {
            Alert(
                title: Text("Reset All Data"),
                message: Text("This will delete all scores, achievements, and progress."),
                primaryButton: .destructive(Text("Reset")) {
                    scoreStore.resetAll()
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    func statRow(_ label: String, _ value: String) -> some View {
        HStack {
            Text(label)
                .font(.system(size: 12, design: .monospaced))
                .foregroundColor(BrandColors.textWhite.opacity(0.7))
            Spacer()
            Text(value)
                .font(.system(size: 14, weight: .bold, design: .monospaced))
                .foregroundColor(BrandColors.textWhite)
        }
    }
}
