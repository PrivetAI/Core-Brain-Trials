import Foundation

struct ScoreEntry: Codable, Identifiable {
    let id: UUID
    let score: Int
    let level: Int
    let date: Date
    
    init(score: Int, level: Int) {
        self.id = UUID()
        self.score = score
        self.level = level
        self.date = Date()
    }
}

// MARK: - Achievement System

struct Achievement: Identifiable {
    let id: String
    let title: String
    let detail: String
    let check: (AchievementStats) -> Bool
}

struct AchievementStats {
    var highestLevel: Int
    var bestScore: Int
    var totalGames: Int
    var perfectStreak: Int
    var totalCorrect: Int
    var categoriesPlayed: Set<String>
}

class ScoreStore: ObservableObject {
    @Published var highScores: [ScoreEntry] = []
    @Published var bestScore: Int = 0
    @Published var highestLevel: Int = 0
    @Published var totalGames: Int = 0
    @Published var bestPerfectStreak: Int = 0
    @Published var totalCorrect: Int = 0
    @Published var categoriesPlayed: Set<String> = []
    @Published var unlockedAchievements: Set<String> = []
    
    private let scoresKey = "pb_high_scores"
    private let bestKey = "pb_best_score"
    private let levelKey = "pb_highest_level"
    private let gamesKey = "pb_total_games"
    private let streakKey = "pb_best_streak"
    private let correctKey = "pb_total_correct"
    private let catsKey = "pb_categories"
    private let achieveKey = "pb_achievements"
    
    static let allAchievements: [Achievement] = [
        Achievement(id: "first_game", title: "INIT", detail: "Complete your first game") { $0.totalGames >= 1 },
        Achievement(id: "level_10", title: "WARM UP", detail: "Reach level 10") { $0.highestLevel >= 10 },
        Achievement(id: "level_25", title: "GETTING SHARP", detail: "Reach level 25") { $0.highestLevel >= 25 },
        Achievement(id: "level_50", title: "HALF CENTURY", detail: "Reach level 50") { $0.highestLevel >= 50 },
        Achievement(id: "level_75", title: "ELITE TRIALS", detail: "Reach level 75") { $0.highestLevel >= 75 },
        Achievement(id: "level_100", title: "CENTURION", detail: "Reach level 100") { $0.highestLevel >= 100 },
        Achievement(id: "level_150", title: "BEYOND LIMITS", detail: "Reach level 150") { $0.highestLevel >= 150 },
        Achievement(id: "level_200", title: "CORE LORD", detail: "Reach level 200") { $0.highestLevel >= 200 },
        Achievement(id: "streak_5", title: "ON FIRE", detail: "Perfect streak of 5") { $0.perfectStreak >= 5 },
        Achievement(id: "streak_10", title: "UNSTOPPABLE", detail: "Perfect streak of 10") { $0.perfectStreak >= 10 },
        Achievement(id: "streak_20", title: "MACHINE", detail: "Perfect streak of 20") { $0.perfectStreak >= 20 },
        Achievement(id: "streak_50", title: "FLAWLESS", detail: "Perfect streak of 50") { $0.perfectStreak >= 50 },
        Achievement(id: "score_5k", title: "5K CLUB", detail: "Score 5,000 points") { $0.bestScore >= 5000 },
        Achievement(id: "score_10k", title: "10K CLUB", detail: "Score 10,000 points") { $0.bestScore >= 10000 },
        Achievement(id: "score_25k", title: "25K CLUB", detail: "Score 25,000 points") { $0.bestScore >= 25000 },
        Achievement(id: "score_50k", title: "50K CLUB", detail: "Score 50,000 points") { $0.bestScore >= 50000 },
        Achievement(id: "games_10", title: "REGULAR", detail: "Play 10 games") { $0.totalGames >= 10 },
        Achievement(id: "games_50", title: "DEDICATED", detail: "Play 50 games") { $0.totalGames >= 50 },
        Achievement(id: "games_100", title: "OBSESSED", detail: "Play 100 games") { $0.totalGames >= 100 },
        Achievement(id: "correct_100", title: "100 CORRECT", detail: "Answer 100 puzzles correctly") { $0.totalCorrect >= 100 },
        Achievement(id: "correct_500", title: "500 CORRECT", detail: "Answer 500 puzzles correctly") { $0.totalCorrect >= 500 },
        Achievement(id: "correct_1000", title: "THOUSAND", detail: "Answer 1000 puzzles correctly") { $0.totalCorrect >= 1000 },
        Achievement(id: "cats_3", title: "EXPLORER", detail: "Play 3 different categories") { $0.categoriesPlayed.count >= 3 },
        Achievement(id: "cats_5", title: "VERSATILE", detail: "Play 5 different categories") { $0.categoriesPlayed.count >= 5 },
        Achievement(id: "cats_7", title: "POLYMATH", detail: "Play all 7 categories") { $0.categoriesPlayed.count >= 7 },
    ]
    
    init() {
        loadScores()
        bestScore = UserDefaults.standard.integer(forKey: bestKey)
        highestLevel = UserDefaults.standard.integer(forKey: levelKey)
        totalGames = UserDefaults.standard.integer(forKey: gamesKey)
        bestPerfectStreak = UserDefaults.standard.integer(forKey: streakKey)
        totalCorrect = UserDefaults.standard.integer(forKey: correctKey)
        if let cats = UserDefaults.standard.stringArray(forKey: catsKey) {
            categoriesPlayed = Set(cats)
        }
        if let achs = UserDefaults.standard.stringArray(forKey: achieveKey) {
            unlockedAchievements = Set(achs)
        }
    }
    
    func addScore(_ score: Int, level: Int) {
        let entry = ScoreEntry(score: score, level: level)
        highScores.append(entry)
        highScores.sort { $0.score > $1.score }
        if highScores.count > 20 {
            highScores = Array(highScores.prefix(20))
        }
        if score > bestScore {
            bestScore = score
            UserDefaults.standard.set(bestScore, forKey: bestKey)
        }
        if level > highestLevel {
            highestLevel = level
            UserDefaults.standard.set(highestLevel, forKey: levelKey)
        }
        totalGames += 1
        UserDefaults.standard.set(totalGames, forKey: gamesKey)
        saveScores()
        checkAchievements()
    }
    
    func recordCorrectAnswer(category: String) {
        totalCorrect += 1
        UserDefaults.standard.set(totalCorrect, forKey: correctKey)
        categoriesPlayed.insert(category)
        UserDefaults.standard.set(Array(categoriesPlayed), forKey: catsKey)
    }
    
    func recordPerfectStreak(_ streak: Int) {
        if streak > bestPerfectStreak {
            bestPerfectStreak = streak
            UserDefaults.standard.set(bestPerfectStreak, forKey: streakKey)
        }
    }
    
    func checkAchievements() {
        let stats = AchievementStats(
            highestLevel: highestLevel,
            bestScore: bestScore,
            totalGames: totalGames,
            perfectStreak: bestPerfectStreak,
            totalCorrect: totalCorrect,
            categoriesPlayed: categoriesPlayed
        )
        for ach in ScoreStore.allAchievements {
            if !unlockedAchievements.contains(ach.id) && ach.check(stats) {
                unlockedAchievements.insert(ach.id)
            }
        }
        UserDefaults.standard.set(Array(unlockedAchievements), forKey: achieveKey)
    }
    
    func resetAll() {
        highScores = []
        bestScore = 0
        highestLevel = 0
        totalGames = 0
        bestPerfectStreak = 0
        totalCorrect = 0
        categoriesPlayed = []
        unlockedAchievements = []
        UserDefaults.standard.removeObject(forKey: scoresKey)
        UserDefaults.standard.removeObject(forKey: bestKey)
        UserDefaults.standard.removeObject(forKey: levelKey)
        UserDefaults.standard.removeObject(forKey: gamesKey)
        UserDefaults.standard.removeObject(forKey: streakKey)
        UserDefaults.standard.removeObject(forKey: correctKey)
        UserDefaults.standard.removeObject(forKey: catsKey)
        UserDefaults.standard.removeObject(forKey: achieveKey)
    }
    
    private func loadScores() {
        if let data = UserDefaults.standard.data(forKey: scoresKey),
           let decoded = try? JSONDecoder().decode([ScoreEntry].self, from: data) {
            highScores = decoded
        }
    }
    
    private func saveScores() {
        if let data = try? JSONEncoder().encode(highScores) {
            UserDefaults.standard.set(data, forKey: scoresKey)
        }
    }
}
