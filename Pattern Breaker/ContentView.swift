import SwiftUI

struct ContentView: View {
    @ObservedObject var engine: GameEngine
    @ObservedObject var scoreStore: ScoreStore
    @ObservedObject var storeManager: StoreManager
    @ObservedObject var themeManager: ThemeManager
    @State private var selectedTab: Int = 0
    
    var body: some View {
        ZStack {
            BrandColors.base.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                Group {
                    switch selectedTab {
                    case 0:
                        gameTab
                    case 1:
                        LeaderboardView(scoreStore: scoreStore)
                    case 2:
                        AchievementsView(scoreStore: scoreStore)
                    case 3:
                        SettingsView(scoreStore: scoreStore, storeManager: storeManager, themeManager: themeManager)
                    default:
                        gameTab
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if engine.gameState != .playing {
                    customTabBar
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    var gameTab: some View {
        Group {
            switch engine.gameState {
            case .menu:
                MainMenuView(engine: engine, scoreStore: scoreStore)
            case .playing:
                GamePlayView(engine: engine, scoreStore: scoreStore)
            case .gameOver:
                GameOverView(engine: engine, scoreStore: scoreStore)
            }
        }
    }
    
    var customTabBar: some View {
        HStack {
            Spacer()
            Button(action: { selectedTab = 0 }) {
                TabIcon(type: "play", isSelected: selectedTab == 0)
            }
            .frame(width: 80, height: 50)
            .contentShape(Rectangle())
            Spacer()
            Button(action: { selectedTab = 1 }) {
                TabIcon(type: "trophy", isSelected: selectedTab == 1)
            }
            .frame(width: 80, height: 50)
            .contentShape(Rectangle())
            Spacer()
            Button(action: { selectedTab = 2 }) {
                TabIcon(type: "star", isSelected: selectedTab == 2)
            }
            .frame(width: 80, height: 50)
            .contentShape(Rectangle())
            Spacer()
            Button(action: { selectedTab = 3 }) {
                TabIcon(type: "gear", isSelected: selectedTab == 3)
            }
            .frame(width: 80, height: 50)
            .contentShape(Rectangle())
            Spacer()
        }
        .padding(.vertical, 10)
        .background(
            BrandColors.cardBg
                .overlay(
                    Rectangle()
                        .fill(BrandColors.neonGreen.opacity(0.15))
                        .frame(height: 1),
                    alignment: .top
                )
        )
    }
}
