import Foundation
import Combine

class GameEngine: ObservableObject {
    @Published var currentLevel: Int = 1
    @Published var score: Int = 0
    @Published var timeRemaining: Double = 30.0
    @Published var currentPuzzle: Puzzle?
    @Published var gameState: GameState = .menu
    @Published var showCorrectFlash: Bool = false
    @Published var showWrongFlash: Bool = false
    @Published var powerUpFreezeAvailable: Int = 1
    @Published var powerUpHintAvailable: Int = 1
    @Published var powerUpSkipAvailable: Int = 1
    @Published var currentStreak: Int = 0
    @Published var lives: Int = 3
    @Published var lostLife: Bool = false
    @Published var gainedLife: Bool = false
    var maxLives: Int = 3
    var absoluteMaxLives: Int = 5
    var deathByLives: Bool = false
    
    enum GameState {
        case menu, playing, gameOver
    }
    
    private var timer: Timer?
    
    var baseTime: Double {
        max(8.0, 30.0 - Double(currentLevel - 1) * 0.3)
    }
    
    func startGame() {
        currentLevel = 1
        score = 0
        timeRemaining = 30.0
        currentStreak = 0
        lives = 3
        maxLives = 3
        deathByLives = false
        gameState = .playing
        powerUpFreezeAvailable = 1
        powerUpHintAvailable = 1
        powerUpSkipAvailable = 1
        generateNextPuzzle()
        startTimer()
    }
    
    func generateNextPuzzle() {
        currentPuzzle = PuzzleFactory.generate(level: currentLevel)
    }
    
    func submitAnswer(_ choiceIndex: Int, scoreStore: ScoreStore) {
        guard let puzzle = currentPuzzle, gameState == .playing else { return }
        
        if choiceIndex == puzzle.correctIndex {
            let levelBonus = currentLevel * 10
            let streakBonus = currentStreak * 5
            score += 100 + levelBonus + streakBonus
            currentStreak += 1
            scoreStore.recordCorrectAnswer(category: puzzle.category)
            scoreStore.recordPerfectStreak(currentStreak)
            
            showCorrectFlash = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.showCorrectFlash = false
            }
            
            let previousLevel = currentLevel
            currentLevel += 1
            
            // Award life every 5 levels
            if currentLevel % 5 == 0 && currentLevel != previousLevel && lives < absoluteMaxLives {
                lives += 1
                if maxLives < absoluteMaxLives {
                    maxLives += 1
                }
                gainedLife = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.gainedLife = false
                }
            }
            
            // Award power-ups through gameplay milestones
            if currentLevel % 10 == 0 {
                powerUpFreezeAvailable += 1
                powerUpHintAvailable += 1
                powerUpSkipAvailable += 1
            }
            if currentStreak % 15 == 0 && currentStreak > 0 {
                powerUpHintAvailable += 1
            }
            
            timeRemaining = baseTime
            generateNextPuzzle()
        } else {
            currentStreak = 0
            
            // Lose a life
            lives -= 1
            lostLife = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.lostLife = false
            }
            
            // Check for game over by lives
            if lives <= 0 {
                deathByLives = true
                endGame()
                return
            }
            
            timeRemaining = max(0, timeRemaining - 5)
            showWrongFlash = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.showWrongFlash = false
            }
            if timeRemaining <= 0 {
                deathByLives = false
                endGame()
            }
        }
    }
    
    func useFreezeTime() {
        guard powerUpFreezeAvailable > 0, gameState == .playing else { return }
        powerUpFreezeAvailable -= 1
        timeRemaining = min(timeRemaining + 10, 60)
    }
    
    func useHint() -> Int? {
        guard powerUpHintAvailable > 0, let puzzle = currentPuzzle, gameState == .playing else { return nil }
        powerUpHintAvailable -= 1
        let wrongIndices = (0..<puzzle.choices.count).filter { $0 != puzzle.correctIndex }
        return wrongIndices.randomElement()
    }
    
    func useSkip() {
        guard powerUpSkipAvailable > 0, gameState == .playing else { return }
        powerUpSkipAvailable -= 1
        score += 50
        currentLevel += 1
        timeRemaining = baseTime
        generateNextPuzzle()
    }
    
    func endGame() {
        gameState = .gameOver
        stopTimer()
    }
    
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.gameState == .playing {
                self.timeRemaining -= 0.1
                if self.timeRemaining <= 0 {
                    self.timeRemaining = 0
                    self.endGame()
                }
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
