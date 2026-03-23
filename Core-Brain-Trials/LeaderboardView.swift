import SwiftUI

struct LeaderboardView: View {
    @ObservedObject var scoreStore: ScoreStore
    
    var body: some View {
        ZStack {
            BrandColors.base.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                Text("HIGH SCORES")
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
                
                Text("TOP 20")
                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                    .foregroundColor(BrandColors.purple)
                    .padding(.bottom, 12)
                
                HStack {
                    Text("RANK")
                        .frame(width: 50, alignment: .leading)
                    Text("SCORE")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("LEVEL")
                        .frame(width: 60, alignment: .trailing)
                }
                .font(.system(size: 11, weight: .medium, design: .monospaced))
                .foregroundColor(BrandColors.purple)
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
                
                if scoreStore.highScores.isEmpty {
                    Spacer()
                    VStack(spacing: 12) {
                        Text("NO SCORES YET")
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                            .foregroundColor(BrandColors.textWhite.opacity(0.4))
                        Text("Play a game to set a record")
                            .font(.system(size: 12, design: .monospaced))
                            .foregroundColor(BrandColors.textWhite.opacity(0.3))
                    }
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 8) {
                            ForEach(Array(scoreStore.highScores.enumerated()), id: \.element.id) { index, entry in
                                leaderboardRow(rank: index + 1, entry: entry)
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
        }
    }
    
    func leaderboardRow(rank: Int, entry: ScoreEntry) -> some View {
        let glowColor: Color = rank == 1 ? BrandColors.neonGreen : (rank <= 3 ? BrandColors.purple : BrandColors.darkGray)
        
        return GlowCard(glowColor: glowColor) {
            HStack {
                Text("#\(rank)")
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .foregroundColor(rank == 1 ? BrandColors.neonGreen : (rank <= 3 ? BrandColors.purple : BrandColors.textWhite.opacity(0.6)))
                    .frame(width: 44, alignment: .leading)
                
                Text("\(entry.score)")
                    .font(.system(size: 18, weight: .bold, design: .monospaced))
                    .foregroundColor(BrandColors.textWhite)
                
                Spacer()
                
                Text("LVL \(entry.level)")
                    .font(.system(size: 13, weight: .medium, design: .monospaced))
                    .foregroundColor(BrandColors.purple)
                    .frame(width: 70, alignment: .trailing)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
    }
}
