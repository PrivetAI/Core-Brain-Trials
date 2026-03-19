import SwiftUI

struct AchievementsView: View {
    @ObservedObject var scoreStore: ScoreStore
    
    var body: some View {
        ZStack {
            BrandColors.base.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                Text("ACHIEVEMENTS")
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
                .padding(.bottom, 8)
                
                let unlocked = scoreStore.unlockedAchievements.count
                let total = ScoreStore.allAchievements.count
                Text("\(unlocked) / \(total) UNLOCKED")
                    .font(.system(size: 13, weight: .bold, design: .monospaced))
                    .foregroundColor(BrandColors.purple)
                    .padding(.bottom, 16)
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(ScoreStore.allAchievements) { ach in
                            let isUnlocked = scoreStore.unlockedAchievements.contains(ach.id)
                            
                            GlowCard(glowColor: isUnlocked ? BrandColors.neonGreen : BrandColors.darkGray) {
                                HStack(spacing: 12) {
                                    // Status indicator
                                    ZStack {
                                        Circle()
                                            .fill(isUnlocked ? BrandColors.neonGreen.opacity(0.2) : BrandColors.darkGray)
                                            .frame(width: 36, height: 36)
                                        
                                        if isUnlocked {
                                            // Checkmark shape
                                            Path { p in
                                                p.move(to: CGPoint(x: 8, y: 18))
                                                p.addLine(to: CGPoint(x: 15, y: 25))
                                                p.addLine(to: CGPoint(x: 28, y: 10))
                                            }
                                            .stroke(BrandColors.neonGreen, lineWidth: 3)
                                            .frame(width: 36, height: 36)
                                        } else {
                                            // Lock shape
                                            VStack(spacing: 1) {
                                                RoundedRectangle(cornerRadius: 4)
                                                    .stroke(BrandColors.textWhite.opacity(0.3), lineWidth: 1.5)
                                                    .frame(width: 12, height: 10)
                                                RoundedRectangle(cornerRadius: 2)
                                                    .fill(BrandColors.textWhite.opacity(0.3))
                                                    .frame(width: 16, height: 10)
                                            }
                                        }
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(ach.title)
                                            .font(.system(size: 14, weight: .bold, design: .monospaced))
                                            .foregroundColor(isUnlocked ? BrandColors.neonGreen : BrandColors.textWhite.opacity(0.5))
                                        
                                        Text(ach.detail)
                                            .font(.system(size: 11, design: .monospaced))
                                            .foregroundColor(isUnlocked ? BrandColors.textWhite.opacity(0.7) : BrandColors.textWhite.opacity(0.3))
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
    }
}
