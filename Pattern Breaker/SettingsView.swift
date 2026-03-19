import SwiftUI

struct SettingsView: View {
    @ObservedObject var scoreStore: ScoreStore
    @ObservedObject var storeManager: StoreManager
    @ObservedObject var themeManager: ThemeManager
    @State private var showWebView = false
    @State private var showResetAlert = false
    @State private var showExportAlert = false
    @State private var showingPremiumModal = false
    
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
                        // Premium Section
                        GlowCard(glowColor: BrandColors.purple) {
                            VStack(spacing: 12) {
                                Text("PREMIUM PACK")
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                                    .foregroundColor(BrandColors.purple)
                                
                                if themeManager.premiumUnlocked {
                                    Text("UNLOCKED")
                                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                                        .foregroundColor(BrandColors.neonGreen)
                                } else {
                                    Text("2 bonus color themes + stats export")
                                        .font(.system(size: 11, design: .monospaced))
                                        .foregroundColor(BrandColors.textWhite.opacity(0.7))
                                        .multilineTextAlignment(.center)
                                    
                                    Button(action: { showingPremiumModal = true }) {
                                        Text("UNLOCK - $2.99")
                                            .font(.system(size: 14, weight: .bold, design: .monospaced))
                                            .foregroundColor(BrandColors.base)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, 12)
                                            .background(BrandColors.purple)
                                            .cornerRadius(8)
                                    }
                                }
                            }
                            .padding(20)
                        }
                        
                        // Theme Selection
                        GlowCard(glowColor: BrandColors.purple) {
                            VStack(spacing: 12) {
                                Text("COLOR THEME")
                                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                                    .foregroundColor(BrandColors.purple)
                                
                                ForEach(AppTheme.allCases, id: \.rawValue) { theme in
                                    let isSelected = themeManager.currentTheme == theme
                                    let isLocked = theme.isPremium && !themeManager.premiumUnlocked
                                    
                                    Button(action: {
                                        if !isLocked {
                                            themeManager.setTheme(theme)
                                        }
                                    }) {
                                        HStack {
                                            Circle()
                                                .fill(theme.accent)
                                                .frame(width: 20, height: 20)
                                            Circle()
                                                .fill(theme.secondary)
                                                .frame(width: 20, height: 20)
                                            
                                            Text(theme.rawValue.uppercased())
                                                .font(.system(size: 13, weight: .bold, design: .monospaced))
                                                .foregroundColor(isLocked ? BrandColors.textWhite.opacity(0.3) : BrandColors.textWhite)
                                            
                                            Spacer()
                                            
                                            if isLocked {
                                                Text("PREMIUM")
                                                    .font(.system(size: 9, weight: .bold, design: .monospaced))
                                                    .foregroundColor(BrandColors.purple.opacity(0.5))
                                            } else if isSelected {
                                                Circle()
                                                    .fill(BrandColors.neonGreen)
                                                    .frame(width: 10, height: 10)
                                            }
                                        }
                                        .padding(.vertical, 6)
                                    }
                                    .disabled(isLocked)
                                }
                            }
                            .padding(20)
                        }
                        
                        // Stats Export (premium)
                        if themeManager.premiumUnlocked {
                            GlowCard(glowColor: BrandColors.neonGreen) {
                                Button(action: {
                                    showExportAlert = true
                                }) {
                                    HStack {
                                        Text("Export Stats")
                                            .font(.system(size: 13, weight: .bold, design: .monospaced))
                                            .foregroundColor(BrandColors.neonGreen)
                                        Spacer()
                                        Text(">")
                                            .font(.system(size: 13, design: .monospaced))
                                            .foregroundColor(BrandColors.textWhite.opacity(0.4))
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 14)
                                }
                            }
                        }
                        
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
                            Text("Pattern Breaker v2.0")
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
                    BreakerWebPanel(urlString: "https://example.com")
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
        .alert(isPresented: $showExportAlert) {
            Alert(
                title: Text("Stats Export"),
                message: Text("Best Score: \(scoreStore.bestScore)\nBest Level: \(scoreStore.highestLevel)\nGames: \(scoreStore.totalGames)\nStreak: \(scoreStore.bestPerfectStreak)\nCorrect: \(scoreStore.totalCorrect)"),
                dismissButton: .default(Text("OK"))
            )
        }
        .sheet(isPresented: $showingPremiumModal) {
            PremiumModalView(storeManager: storeManager, themeManager: themeManager)
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
