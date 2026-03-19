import Foundation

struct Puzzle {
    let question: String
    let choices: [String]
    let correctIndex: Int
    let category: String
}

class PuzzleFactory {
    
    static func generate(level: Int) -> Puzzle {
        let difficulty = min(level, 60)
        let typeIndex = Int.random(in: 0..<105)
        
        switch typeIndex {
        // Math: 0-24
        case 0: return additionPuzzle(difficulty)
        case 1: return subtractionPuzzle(difficulty)
        case 2: return multiplicationPuzzle(difficulty)
        case 3: return divisionPuzzle(difficulty)
        case 4: return sumToTarget(difficulty)
        case 5: return productPuzzle(difficulty)
        case 6: return squareNumbers(difficulty)
        case 7: return cubeNumbers(difficulty)
        case 8: return moduloPuzzle(difficulty)
        case 9: return gcdPuzzle(difficulty)
        case 10: return powerOfTwo(difficulty)
        case 11: return percentagePuzzle(difficulty)
        case 12: return factorialPuzzle(difficulty)
        case 13: return triangularNumber(difficulty)
        case 14: return arithmeticMean(difficulty)
        case 15: return medianPuzzle(difficulty)
        case 16: return rangePuzzle(difficulty)
        case 17: return absoluteDifference(difficulty)
        case 18: return lcmPuzzle(difficulty)
        case 19: return digitSum(difficulty)
        case 20: return productOfDigits(difficulty)
        case 21: return complementTo100(difficulty)
        case 22: return halfPuzzle(difficulty)
        case 23: return weightedSum(difficulty)
        case 24: return maxMinDiff(difficulty)
        // Math extended: 25-39
        case 25: return ratioPuzzle(difficulty)
        case 26: return squareRootPuzzle(difficulty)
        case 27: return divisibilityPuzzle(difficulty)
        case 28: return differencePuzzle(difficulty)
        case 29: return doubleNumberPuzzle(difficulty)
        case 30: return tripleNumberPuzzle(difficulty)
        case 31: return remainderPuzzle(difficulty)
        case 32: return sumOfEvensPuzzle(difficulty)
        case 33: return sumOfOddsPuzzle(difficulty)
        case 34: return averageTwoPuzzle(difficulty)
        case 35: return percentIncPuzzle(difficulty)
        case 36: return fractionPuzzle(difficulty)
        case 37: return countDivisors(difficulty)
        case 38: return powerOfThree(difficulty)
        case 39: return nearestTenPuzzle(difficulty)
        // Sequences: 40-59
        case 40: return sequenceNext(difficulty)
        case 41: return fibonacciNext(difficulty)
        case 42: return primeNext(difficulty)
        case 43: return doubleSequence(difficulty)
        case 44: return tripleSequence(difficulty)
        case 45: return geometricNext(difficulty)
        case 46: return skipCountPuzzle(difficulty)
        case 47: return doubleAndAdd(difficulty)
        case 48: return powersOfTwoSeq(difficulty)
        case 49: return factorialSeq(difficulty)
        case 50: return squareSeq(difficulty)
        case 51: return cubeSeq(difficulty)
        case 52: return triangularSeq(difficulty)
        case 53: return alternatingSeq(difficulty)
        case 54: return decreasingSeq(difficulty)
        case 55: return addIncreasingSeq(difficulty)
        case 56: return multiplyIncSeq(difficulty)
        case 57: return primeGapSeq(difficulty)
        case 58: return pentagonalSeq(difficulty)
        case 59: return halfSeq(difficulty)
        // Logic: 60-74
        case 60: return oddOneOutNumber(difficulty)
        case 61: return patternCompletion(difficulty)
        case 62: return missingOperator(difficulty)
        case 63: return compareExpressions(difficulty)
        case 64: return binaryConvert(difficulty)
        case 65: return hexConvert(difficulty)
        case 66: return isPrimePuzzle(difficulty)
        case 67: return nextEvenPuzzle(difficulty)
        case 68: return nextOddPuzzle(difficulty)
        case 69: return reverseNumber(difficulty)
        case 70: return multipleOfPuzzle(difficulty)
        case 71: return sortAscending(difficulty)
        case 72: return sortDescending(difficulty)
        case 73: return closestTo100(difficulty)
        case 74: return furthestFrom50(difficulty)
        // Logic extended: 75-84
        case 75: return analogyPuzzle(difficulty)
        case 76: return evenOddCount(difficulty)
        case 77: return palindromePuzzle(difficulty)
        case 78: return logicNotPuzzle(difficulty)
        case 79: return countVowelsPuzzle(difficulty)
        case 80: return countConsonantsPuzzle(difficulty)
        case 81: return whichIsBiggerPuzzle(difficulty)
        case 82: return twoAwayPuzzle(difficulty)
        case 83: return betweenPuzzle(difficulty)
        case 84: return sumOrProductPuzzle(difficulty)
        // Word: 85-94
        case 85: return anagramPuzzle(difficulty)
        case 86: return letterCountPuzzle(difficulty)
        case 87: return firstLetterPuzzle(difficulty)
        case 88: return lastLetterPuzzle(difficulty)
        case 89: return rhymePuzzle(difficulty)
        case 90: return vowelCountWordPuzzle(difficulty)
        case 91: return reverseWordPuzzle(difficulty)
        case 92: return longestWordPuzzle(difficulty)
        case 93: return shortestWordPuzzle(difficulty)
        case 94: return alphabetOrderPuzzle(difficulty)
        // Visual/Counting: 95-99
        case 95: return countSymbolsPuzzle(difficulty)
        case 96: return symmetryPuzzle(difficulty)
        case 97: return patternRowPuzzle(difficulty)
        case 98: return countPairsPuzzle(difficulty)
        case 99: return missingSymbolPuzzle(difficulty)
        // Mixed: 100-104
        case 100: return mathWordPuzzle(difficulty)
        case 101: return codePatternPuzzle(difficulty)
        case 102: return digitPositionPuzzle(difficulty)
        case 103: return combinedOpsPuzzle(difficulty)
        default: return chainCalcPuzzle(difficulty)
        }
    }
    
    // MARK: - Math Puzzles (0-24 original)
    
    static func additionPuzzle(_ d: Int) -> Puzzle {
        let a = Int.random(in: 1...(10 + d * 2))
        let b = Int.random(in: 1...(10 + d * 2))
        return makeChoices(q: "\(a) + \(b) = ?", answer: a + b, cat: "Math")
    }
    
    static func subtractionPuzzle(_ d: Int) -> Puzzle {
        let b = Int.random(in: 1...(10 + d))
        let a = b + Int.random(in: 1...(10 + d))
        return makeChoices(q: "\(a) - \(b) = ?", answer: a - b, cat: "Math")
    }
    
    static func multiplicationPuzzle(_ d: Int) -> Puzzle {
        let a = Int.random(in: 2...(5 + d / 3))
        let b = Int.random(in: 2...(5 + d / 3))
        return makeChoices(q: "\(a) x \(b) = ?", answer: a * b, cat: "Math")
    }
    
    static func divisionPuzzle(_ d: Int) -> Puzzle {
        let b = Int.random(in: 2...(5 + d / 4))
        let answer = Int.random(in: 1...(10 + d / 2))
        let a = b * answer
        return makeChoices(q: "\(a) / \(b) = ?", answer: answer, cat: "Math")
    }
    
    static func sumToTarget(_ d: Int) -> Puzzle {
        let target = Int.random(in: 10...(20 + d * 2))
        let a = Int.random(in: 1..<target)
        return makeChoices(q: "\(a) + ? = \(target)", answer: target - a, cat: "Math")
    }
    
    static func productPuzzle(_ d: Int) -> Puzzle {
        let answer = Int.random(in: 2...(6 + d / 5))
        let b = Int.random(in: 2...(6 + d / 5))
        return makeChoices(q: "? x \(b) = \(answer * b)", answer: answer, cat: "Math")
    }
    
    static func squareNumbers(_ d: Int) -> Puzzle {
        let n = Int.random(in: 2...(8 + d / 5))
        return makeChoices(q: "\(n) squared = ?", answer: n * n, cat: "Math")
    }
    
    static func cubeNumbers(_ d: Int) -> Puzzle {
        let n = Int.random(in: 2...(5 + d / 10))
        return makeChoices(q: "\(n) cubed = ?", answer: n * n * n, cat: "Math")
    }
    
    static func moduloPuzzle(_ d: Int) -> Puzzle {
        let a = Int.random(in: 10...(20 + d * 2))
        let b = Int.random(in: 2...(7 + d / 5))
        return makeChoices(q: "\(a) mod \(b) = ?", answer: a % b, cat: "Math")
    }
    
    static func gcdPuzzle(_ d: Int) -> Puzzle {
        let a = Int.random(in: 4...(20 + d))
        let b = Int.random(in: 4...(20 + d))
        return makeChoices(q: "GCD(\(a), \(b)) = ?", answer: gcd(a, b), cat: "Math")
    }
    
    static func powerOfTwo(_ d: Int) -> Puzzle {
        let n = Int.random(in: 1...(7 + d / 8))
        return makeChoices(q: "2 to the power of \(n) = ?", answer: Int(pow(2.0, Double(n))), cat: "Math")
    }
    
    static func percentagePuzzle(_ d: Int) -> Puzzle {
        let pcts = [10, 20, 25, 50]
        let pct = pcts.randomElement()!
        let base = Int.random(in: 2...(10 + d / 2)) * (100 / pct)
        return makeChoices(q: "\(pct)% of \(base) = ?", answer: base * pct / 100, cat: "Math")
    }
    
    static func factorialPuzzle(_ d: Int) -> Puzzle {
        let n = Int.random(in: 3...min(7, 3 + d / 8))
        var answer = 1
        for i in 1...n { answer *= i }
        return makeChoices(q: "\(n)! = ?", answer: answer, cat: "Math")
    }
    
    static func triangularNumber(_ d: Int) -> Puzzle {
        let n = Int.random(in: 3...(8 + d / 5))
        return makeChoices(q: "T(\(n)) = 1+2+...+\(n) = ?", answer: n * (n + 1) / 2, cat: "Math")
    }
    
    static func arithmeticMean(_ d: Int) -> Puzzle {
        let count = 3
        let mean = Int.random(in: 2...(10 + d / 2))
        let a = Int.random(in: max(1, mean - 5)...mean)
        let b = Int.random(in: max(1, mean - 5)...mean)
        let c = mean * count - a - b
        let shown = [a, b, c].map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Mean of \(shown) = ?", answer: mean, cat: "Math")
    }
    
    static func medianPuzzle(_ d: Int) -> Puzzle {
        var nums = (0..<5).map { _ in Int.random(in: 1...(20 + d)) }
        nums.sort()
        let answer = nums[2]
        let shown = nums.shuffled().map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Median of \(shown) = ?", answer: answer, cat: "Math")
    }
    
    static func rangePuzzle(_ d: Int) -> Puzzle {
        let nums = (0..<5).map { _ in Int.random(in: 1...(30 + d)) }
        let answer = (nums.max() ?? 0) - (nums.min() ?? 0)
        let shown = nums.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Range of \(shown) = ?", answer: answer, cat: "Math")
    }
    
    static func absoluteDifference(_ d: Int) -> Puzzle {
        let a = Int.random(in: 1...(20 + d))
        let b = Int.random(in: 1...(20 + d))
        return makeChoices(q: "|\(a) - \(b)| = ?", answer: abs(a - b), cat: "Math")
    }
    
    static func lcmPuzzle(_ d: Int) -> Puzzle {
        let a = Int.random(in: 2...(8 + d / 5))
        let b = Int.random(in: 2...(8 + d / 5))
        return makeChoices(q: "LCM(\(a), \(b)) = ?", answer: a * b / gcd(a, b), cat: "Math")
    }
    
    static func digitSum(_ d: Int) -> Puzzle {
        let n = Int.random(in: 10...(100 + d * 10))
        let answer = String(n).compactMap { $0.wholeNumberValue }.reduce(0, +)
        return makeChoices(q: "Sum of digits of \(n) = ?", answer: answer, cat: "Math")
    }
    
    static func productOfDigits(_ d: Int) -> Puzzle {
        let n = Int.random(in: 11...(99 + d * 5))
        let answer = String(n).compactMap { $0.wholeNumberValue }.reduce(1, *)
        return makeChoices(q: "Product of digits of \(n) = ?", answer: answer, cat: "Math")
    }
    
    static func complementTo100(_ d: Int) -> Puzzle {
        let n = Int.random(in: 1...99)
        return makeChoices(q: "\(n) + ? = 100", answer: 100 - n, cat: "Math")
    }
    
    static func halfPuzzle(_ d: Int) -> Puzzle {
        let answer = Int.random(in: 1...(50 + d))
        return makeChoices(q: "Half of \(answer * 2) = ?", answer: answer, cat: "Math")
    }
    
    static func weightedSum(_ d: Int) -> Puzzle {
        let a = Int.random(in: 1...(10 + d / 3))
        let b = Int.random(in: 1...(10 + d / 3))
        return makeChoices(q: "2x\(a) + 3x\(b) = ?", answer: a * 2 + b * 3, cat: "Math")
    }
    
    static func maxMinDiff(_ d: Int) -> Puzzle {
        let nums = (0..<5).map { _ in Int.random(in: 1...(50 + d)) }
        let shown = nums.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Max - Min of \(shown) = ?", answer: (nums.max()! - nums.min()!), cat: "Math")
    }
    
    // MARK: - Math Extended (25-39)
    
    static func ratioPuzzle(_ d: Int) -> Puzzle {
        let r = Int.random(in: 2...(5 + d / 10))
        let a = r * Int.random(in: 1...(5 + d / 8))
        return makeChoices(q: "\(a) / \(r) = ?", answer: a / r, cat: "Math")
    }
    
    static func squareRootPuzzle(_ d: Int) -> Puzzle {
        let answer = Int.random(in: 2...(10 + d / 5))
        let n = answer * answer
        return makeChoices(q: "Square root of \(n) = ?", answer: answer, cat: "Math")
    }
    
    static func divisibilityPuzzle(_ d: Int) -> Puzzle {
        let div = Int.random(in: 2...(9))
        let mult = div * Int.random(in: 1...(10 + d / 3))
        let wrong1 = mult + 1
        let wrong2 = mult + Int.random(in: 2...div)
        let wrong3 = mult - 1
        var choices = [String(mult), String(wrong1), String(wrong2), String(wrong3)]
        choices.shuffle()
        let idx = choices.firstIndex(of: String(mult))!
        return Puzzle(question: "Which is divisible by \(div)?", choices: choices, correctIndex: idx, category: "Math")
    }
    
    static func differencePuzzle(_ d: Int) -> Puzzle {
        let a = Int.random(in: 10...(50 + d * 2))
        let b = Int.random(in: 1..<a)
        return makeChoices(q: "Difference: \(a) and \(b) = ?", answer: a - b, cat: "Math")
    }
    
    static func doubleNumberPuzzle(_ d: Int) -> Puzzle {
        let n = Int.random(in: 1...(50 + d))
        return makeChoices(q: "Double \(n) = ?", answer: n * 2, cat: "Math")
    }
    
    static func tripleNumberPuzzle(_ d: Int) -> Puzzle {
        let n = Int.random(in: 1...(30 + d))
        return makeChoices(q: "Triple \(n) = ?", answer: n * 3, cat: "Math")
    }
    
    static func remainderPuzzle(_ d: Int) -> Puzzle {
        let a = Int.random(in: 10...(30 + d))
        let b = Int.random(in: 3...(8 + d / 5))
        return makeChoices(q: "Remainder of \(a) / \(b) = ?", answer: a % b, cat: "Math")
    }
    
    static func sumOfEvensPuzzle(_ d: Int) -> Puzzle {
        let n = Int.random(in: 3...(6 + d / 10))
        var sum = 0
        for i in 1...n { sum += i * 2 }
        return makeChoices(q: "Sum of first \(n) even numbers = ?", answer: sum, cat: "Math")
    }
    
    static func sumOfOddsPuzzle(_ d: Int) -> Puzzle {
        let n = Int.random(in: 3...(6 + d / 10))
        let answer = n * n
        return makeChoices(q: "Sum of first \(n) odd numbers = ?", answer: answer, cat: "Math")
    }
    
    static func averageTwoPuzzle(_ d: Int) -> Puzzle {
        let answer = Int.random(in: 2...(20 + d / 2))
        let a = answer - Int.random(in: 1...min(answer - 1, 10))
        let b = 2 * answer - a
        return makeChoices(q: "Average of \(a) and \(b) = ?", answer: answer, cat: "Math")
    }
    
    static func percentIncPuzzle(_ d: Int) -> Puzzle {
        let base = Int.random(in: 2...(10 + d / 4)) * 10
        let pct = [10, 20, 50].randomElement()!
        let answer = base + base * pct / 100
        return makeChoices(q: "\(base) increased by \(pct)% = ?", answer: answer, cat: "Math")
    }
    
    static func fractionPuzzle(_ d: Int) -> Puzzle {
        let denoms = [2, 3, 4, 5]
        let den = denoms.randomElement()!
        let n = den * Int.random(in: 1...(5 + d / 5))
        return makeChoices(q: "\(n) / \(den) = ?", answer: n / den, cat: "Math")
    }
    
    static func countDivisors(_ d: Int) -> Puzzle {
        let n = Int.random(in: 6...(20 + d / 2))
        var count = 0
        for i in 1...n { if n % i == 0 { count += 1 } }
        return makeChoices(q: "How many divisors has \(n)?", answer: count, cat: "Math")
    }
    
    static func powerOfThree(_ d: Int) -> Puzzle {
        let n = Int.random(in: 1...(5 + d / 10))
        return makeChoices(q: "3 to the power of \(n) = ?", answer: Int(pow(3.0, Double(n))), cat: "Math")
    }
    
    static func nearestTenPuzzle(_ d: Int) -> Puzzle {
        let n = Int.random(in: 1...(100 + d * 2))
        let answer = ((n + 5) / 10) * 10
        return makeChoices(q: "Round \(n) to nearest 10 = ?", answer: answer, cat: "Math")
    }
    
    // MARK: - Sequences (40-59)
    
    static func sequenceNext(_ d: Int) -> Puzzle {
        let step = Int.random(in: 2...(4 + d / 5))
        let start = Int.random(in: 1...(10 + d))
        let seq = (0..<4).map { start + step * $0 }
        let shown = seq.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Next: \(shown), ?", answer: start + step * 4, cat: "Sequence")
    }
    
    static func fibonacciNext(_ d: Int) -> Puzzle {
        var a = Int.random(in: 1...(3 + d / 10))
        var b = Int.random(in: 1...(3 + d / 10))
        var seq = [a, b]
        for _ in 0..<3 { let c = a + b; seq.append(c); a = b; b = c }
        let answer = a + b
        let shown = seq.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Next: \(shown), ?", answer: answer, cat: "Sequence")
    }
    
    static func primeNext(_ d: Int) -> Puzzle {
        let primes = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97]
        let maxIdx = min(primes.count - 2, 4 + d / 5)
        let startIdx = Int.random(in: 0..<max(1, maxIdx - 3))
        let endIdx = min(startIdx + 4, primes.count - 2)
        let seq = Array(primes[startIdx...endIdx])
        let shown = seq.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Next prime: \(shown), ?", answer: primes[endIdx + 1], cat: "Sequence")
    }
    
    static func doubleSequence(_ d: Int) -> Puzzle {
        let start = Int.random(in: 1...(5 + d / 5))
        let seq = (0..<4).map { start * Int(pow(2.0, Double($0))) }
        let shown = seq.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Next: \(shown), ?", answer: start * Int(pow(2.0, 4.0)), cat: "Sequence")
    }
    
    static func tripleSequence(_ d: Int) -> Puzzle {
        let start = Int.random(in: 1...(3 + d / 10))
        let seq = (0..<3).map { start * Int(pow(3.0, Double($0))) }
        let shown = seq.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Next: \(shown), ?", answer: start * Int(pow(3.0, 3.0)), cat: "Sequence")
    }
    
    static func geometricNext(_ d: Int) -> Puzzle {
        let r = Int.random(in: 2...3)
        let start = Int.random(in: 1...(3 + d / 10))
        let seq = (0..<4).map { start * Int(pow(Double(r), Double($0))) }
        let shown = seq.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Next: \(shown), ?", answer: start * Int(pow(Double(r), 4.0)), cat: "Sequence")
    }
    
    static func skipCountPuzzle(_ d: Int) -> Puzzle {
        let skip = Int.random(in: 3...(7 + d / 5))
        let start = Int.random(in: 0...(10 + d))
        let seq = (0..<4).map { start + skip * $0 }
        let shown = seq.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Skip count: \(shown), ?", answer: start + skip * 4, cat: "Sequence")
    }
    
    static func doubleAndAdd(_ d: Int) -> Puzzle {
        let start = Int.random(in: 1...(5 + d / 5))
        let add = Int.random(in: 1...(3 + d / 10))
        var seq = [start]
        for _ in 0..<3 { seq.append(seq.last! * 2 + add) }
        let answer = seq.last! * 2 + add
        let shown = seq.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Next: \(shown), ?", answer: answer, cat: "Sequence")
    }
    
    static func powersOfTwoSeq(_ d: Int) -> Puzzle {
        let startExp = Int.random(in: 0...(3 + d / 15))
        let seq = (0..<4).map { Int(pow(2.0, Double(startExp + $0))) }
        let answer = Int(pow(2.0, Double(startExp + 4)))
        let shown = seq.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Next: \(shown), ?", answer: answer, cat: "Sequence")
    }
    
    static func factorialSeq(_ d: Int) -> Puzzle {
        let vals = [1, 1, 2, 6, 24, 120, 720]
        let startIdx = Int.random(in: 0...min(3, vals.count - 4))
        let seq = Array(vals[startIdx..<(startIdx + 4)])
        let answer = startIdx + 4 < vals.count ? vals[startIdx + 4] : vals.last! * (startIdx + 5)
        let shown = seq.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Next: \(shown), ?", answer: answer, cat: "Sequence")
    }
    
    static func squareSeq(_ d: Int) -> Puzzle {
        let start = Int.random(in: 1...(5 + d / 10))
        let seq = (0..<4).map { (start + $0) * (start + $0) }
        let answer = (start + 4) * (start + 4)
        let shown = seq.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Next square: \(shown), ?", answer: answer, cat: "Sequence")
    }
    
    static func cubeSeq(_ d: Int) -> Puzzle {
        let start = Int.random(in: 1...(3 + d / 15))
        let seq = (0..<3).map { (start + $0) * (start + $0) * (start + $0) }
        let answer = (start + 3) * (start + 3) * (start + 3)
        let shown = seq.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Next cube: \(shown), ?", answer: answer, cat: "Sequence")
    }
    
    static func triangularSeq(_ d: Int) -> Puzzle {
        let start = Int.random(in: 1...(4 + d / 10))
        let tri: (Int) -> Int = { n in n * (n + 1) / 2 }
        let seq = (0..<4).map { tri(start + $0) }
        let answer = tri(start + 4)
        let shown = seq.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Next: \(shown), ?", answer: answer, cat: "Sequence")
    }
    
    static func alternatingSeq(_ d: Int) -> Puzzle {
        let a = Int.random(in: 1...(10 + d / 3))
        let b = Int.random(in: 1...(10 + d / 3))
        // a, b, a, b, a, ?
        return makeChoices(q: "Pattern: \(a), \(b), \(a), \(b), \(a), ?", answer: b, cat: "Sequence")
    }
    
    static func decreasingSeq(_ d: Int) -> Puzzle {
        let start = Int.random(in: 30...(50 + d))
        let step = Int.random(in: 2...(5 + d / 10))
        let seq = (0..<4).map { start - step * $0 }
        let answer = start - step * 4
        let shown = seq.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Next: \(shown), ?", answer: answer, cat: "Sequence")
    }
    
    static func addIncreasingSeq(_ d: Int) -> Puzzle {
        // +1, +2, +3, +4, ...
        let start = Int.random(in: 1...(10 + d / 3))
        var seq = [start]
        for i in 1...4 { seq.append(seq.last! + i) }
        let answer = seq.last! + 5
        let shown = seq.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Next: \(shown), ?", answer: answer, cat: "Sequence")
    }
    
    static func multiplyIncSeq(_ d: Int) -> Puzzle {
        // x2, x3, x4 ...
        let start = Int.random(in: 1...(3 + d / 15))
        var seq = [start]
        for i in 2...4 { seq.append(seq.last! * i) }
        let answer = seq.last! * 5
        let shown = seq.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Next: \(shown), ?", answer: answer, cat: "Sequence")
    }
    
    static func primeGapSeq(_ d: Int) -> Puzzle {
        let primes = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47]
        let startIdx = Int.random(in: 0..<max(1, primes.count - 5))
        let seq = (0..<4).map { primes[startIdx + $0] }
        let answer = primes[min(startIdx + 4, primes.count - 1)]
        let shown = seq.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Next: \(shown), ?", answer: answer, cat: "Sequence")
    }
    
    static func pentagonalSeq(_ d: Int) -> Puzzle {
        // P(n) = n(3n-1)/2: 1, 5, 12, 22, 35, 51...
        let pent: (Int) -> Int = { n in n * (3 * n - 1) / 2 }
        let start = Int.random(in: 1...3)
        let seq = (0..<3).map { pent(start + $0) }
        let answer = pent(start + 3)
        let shown = seq.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Next: \(shown), ?", answer: answer, cat: "Sequence")
    }
    
    static func halfSeq(_ d: Int) -> Puzzle {
        let start = Int.random(in: 4...(8 + d / 5)) * 16
        var seq = [start]
        for _ in 0..<3 { seq.append(seq.last! / 2) }
        let answer = seq.last! / 2
        if answer == 0 { return sequenceNext(d) }
        let shown = seq.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Next: \(shown), ?", answer: answer, cat: "Sequence")
    }
    
    // MARK: - Logic (60-84)
    
    static func oddOneOutNumber(_ d: Int) -> Puzzle {
        let base = Int.random(in: 2...(5 + d / 5))
        var nums = (0..<4).map { base * ($0 + 1) }
        let oddIdx = Int.random(in: 0..<4)
        let oddVal = nums[oddIdx] + (Bool.random() ? 1 : -1)
        nums[oddIdx] = oddVal
        let shown = nums.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Odd one out: \(shown)", answer: oddVal, cat: "Logic")
    }
    
    static func patternCompletion(_ d: Int) -> Puzzle {
        let a = Int.random(in: 1...(5 + d / 5))
        let b = Int.random(in: 1...(5 + d / 5))
        return makeChoices(q: "Pattern: \(a), \(b), \(a), \(b), \(a), ?", answer: b, cat: "Logic")
    }
    
    static func missingOperator(_ d: Int) -> Puzzle {
        let a = Int.random(in: 2...(10 + d / 3))
        let b = Int.random(in: 2...(10 + d / 3))
        let ops = [("+", a + b), ("-", a - b), ("x", a * b)]
        let chosen = ops.randomElement()!
        let idx = ops.firstIndex(where: { $0.0 == chosen.0 })!
        return Puzzle(question: "\(a) ? \(b) = \(chosen.1)", choices: ["+", "-", "x", "/"], correctIndex: idx, category: "Logic")
    }
    
    static func compareExpressions(_ d: Int) -> Puzzle {
        let a = Int.random(in: 1...(10 + d))
        let b = Int.random(in: 1...(10 + d))
        let c = Int.random(in: 1...(10 + d))
        let e = Int.random(in: 1...(10 + d))
        let left = a + b
        let right = c + e
        let answer: String
        if left > right { answer = ">" } else if left < right { answer = "<" } else { answer = "=" }
        let choices = [">", "<", "=", "!="]
        let idx = choices.firstIndex(of: answer)!
        return Puzzle(question: "\(a)+\(b) ? \(c)+\(e)", choices: choices, correctIndex: idx, category: "Logic")
    }
    
    static func binaryConvert(_ d: Int) -> Puzzle {
        let n = Int.random(in: 1...(15 + d / 3))
        return makeChoices(q: "Binary \(String(n, radix: 2)) = ?", answer: n, cat: "Logic")
    }
    
    static func hexConvert(_ d: Int) -> Puzzle {
        let n = Int.random(in: 1...(15 + d / 3))
        return makeChoices(q: "Hex \(String(n, radix: 16).uppercased()) = ?", answer: n, cat: "Logic")
    }
    
    static func isPrimePuzzle(_ d: Int) -> Puzzle {
        let n = Int.random(in: 2...(30 + d))
        var prime = true
        if n < 2 { prime = false }
        else { for i in 2..<max(2, n) { if i * i > n { break }; if n % i == 0 { prime = false; break } } }
        let idx = prime ? 0 : 1
        return Puzzle(question: "Is \(n) prime?", choices: ["Yes", "No", "Sometimes", "Depends"], correctIndex: idx, category: "Logic")
    }
    
    static func nextEvenPuzzle(_ d: Int) -> Puzzle {
        let n = Int.random(in: 1...(30 + d))
        return makeChoices(q: "Next even after \(n) = ?", answer: n % 2 == 0 ? n + 2 : n + 1, cat: "Logic")
    }
    
    static func nextOddPuzzle(_ d: Int) -> Puzzle {
        let n = Int.random(in: 1...(30 + d))
        return makeChoices(q: "Next odd after \(n) = ?", answer: n % 2 == 1 ? n + 2 : n + 1, cat: "Logic")
    }
    
    static func reverseNumber(_ d: Int) -> Puzzle {
        let n = Int.random(in: 10...(100 + d * 5))
        let answer = Int(String(String(n).reversed())) ?? 0
        return makeChoices(q: "Reverse \(n) = ?", answer: answer, cat: "Logic")
    }
    
    static func multipleOfPuzzle(_ d: Int) -> Puzzle {
        let base = Int.random(in: 2...(8 + d / 5))
        let n = Int.random(in: 2...(10 + d / 3))
        let answer = base * n
        var choices = [answer, answer + 1, answer - 1, answer + base].map { String($0) }
        choices.shuffle()
        let idx = choices.firstIndex(of: String(answer))!
        return Puzzle(question: "Which is a multiple of \(base)?", choices: choices, correctIndex: idx, category: "Logic")
    }
    
    static func sortAscending(_ d: Int) -> Puzzle {
        let nums = (0..<4).map { _ in Int.random(in: 1...(20 + d)) }
        let shown = nums.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Smallest in \(shown) = ?", answer: nums.min()!, cat: "Logic")
    }
    
    static func sortDescending(_ d: Int) -> Puzzle {
        let nums = (0..<4).map { _ in Int.random(in: 1...(20 + d)) }
        let shown = nums.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Largest in \(shown) = ?", answer: nums.max()!, cat: "Logic")
    }
    
    static func closestTo100(_ d: Int) -> Puzzle {
        let nums = (0..<4).map { _ in Int.random(in: 50...(150 + d)) }
        let answer = nums.min(by: { abs($0 - 100) < abs($1 - 100) })!
        let shown = nums.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Closest to 100: \(shown)", answer: answer, cat: "Logic")
    }
    
    static func furthestFrom50(_ d: Int) -> Puzzle {
        let nums = (0..<4).map { _ in Int.random(in: 0...(100 + d)) }
        let answer = nums.max(by: { abs($0 - 50) < abs($1 - 50) })!
        let shown = nums.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Furthest from 50: \(shown)", answer: answer, cat: "Logic")
    }
    
    static func analogyPuzzle(_ d: Int) -> Puzzle {
        let pairs: [(Int, Int, Int, Int)] = [
            (2, 4, 3, 6), (5, 25, 4, 16), (10, 100, 7, 49),
            (3, 9, 6, 36), (1, 1, 8, 64), (2, 8, 3, 27)
        ]
        let p = pairs.randomElement()!
        return makeChoices(q: "\(p.0) -> \(p.1), \(p.2) -> ?", answer: p.3, cat: "Logic")
    }
    
    static func evenOddCount(_ d: Int) -> Puzzle {
        let count = 5 + min(d / 10, 5)
        let nums = (0..<count).map { _ in Int.random(in: 1...(20 + d)) }
        let evens = nums.filter { $0 % 2 == 0 }.count
        let shown = nums.map { String($0) }.joined(separator: ", ")
        return makeChoices(q: "Count evens: \(shown)", answer: evens, cat: "Logic")
    }
    
    static func palindromePuzzle(_ d: Int) -> Puzzle {
        let palinVal = Int.random(in: 1...9) * 11
        var choices = [String(palinVal)]
        while choices.count < 4 {
            let v = Int.random(in: 10...99)
            let s = String(v)
            if s != String(s.reversed()) && !choices.contains(s) { choices.append(s) }
        }
        choices.shuffle()
        let idx = choices.firstIndex(of: String(palinVal))!
        return Puzzle(question: "Which is a palindrome?", choices: choices, correctIndex: idx, category: "Logic")
    }
    
    static func logicNotPuzzle(_ d: Int) -> Puzzle {
        // Which is NOT a multiple of X?
        let base = Int.random(in: 2...(7))
        let multiples = (1...5).map { $0 * base }
        let notMult = multiples.randomElement()! + 1
        var choices = [String(notMult)]
        var used = Set([notMult])
        for m in multiples.shuffled() {
            if choices.count < 4 && !used.contains(m) { choices.append(String(m)); used.insert(m) }
        }
        while choices.count < 4 {
            let m = Int.random(in: 1...5) * base
            if !used.contains(m) { choices.append(String(m)); used.insert(m) }
        }
        choices.shuffle()
        let idx = choices.firstIndex(of: String(notMult))!
        return Puzzle(question: "NOT a multiple of \(base)?", choices: choices, correctIndex: idx, category: "Logic")
    }
    
    static func countVowelsPuzzle(_ d: Int) -> Puzzle {
        let words = ["apple", "orange", "computer", "education", "umbrella", "algorithm", "sequence", "beautiful", "outside", "universe"]
        let word = words.randomElement()!
        let vowels = "aeiouAEIOU"
        let count = word.filter { vowels.contains($0) }.count
        return makeChoices(q: "Vowels in \"\(word)\" = ?", answer: count, cat: "Logic")
    }
    
    static func countConsonantsPuzzle(_ d: Int) -> Puzzle {
        let words = ["rhythm", "strong", "planet", "bridge", "crystal", "jungle", "garden", "market", "silver", "thunder"]
        let word = words.randomElement()!
        let vowels = "aeiouAEIOU"
        let count = word.filter { $0.isLetter && !vowels.contains($0) }.count
        return makeChoices(q: "Consonants in \"\(word)\" = ?", answer: count, cat: "Logic")
    }
    
    static func whichIsBiggerPuzzle(_ d: Int) -> Puzzle {
        let a = Int.random(in: 1...(50 + d))
        let b = Int.random(in: 1...(50 + d))
        let answer = max(a, b)
        return makeChoices(q: "Bigger: \(a) or \(b)?", answer: answer, cat: "Logic")
    }
    
    static func twoAwayPuzzle(_ d: Int) -> Puzzle {
        let n = Int.random(in: 5...(50 + d))
        let dir = Bool.random()
        let answer = dir ? n + 2 : n - 2
        return makeChoices(q: "2 \(dir ? "more" : "less") than \(n) = ?", answer: answer, cat: "Logic")
    }
    
    static func betweenPuzzle(_ d: Int) -> Puzzle {
        let a = Int.random(in: 1...(20 + d))
        let b = a + Int.random(in: 4...(10 + d / 3))
        let answer = (a + b) / 2
        let wrong1 = a - 1
        let wrong2 = b + 1
        let wrong3 = a + b
        var choices = [String(answer), String(wrong1), String(wrong2), String(wrong3)]
        choices.shuffle()
        let idx = choices.firstIndex(of: String(answer))!
        return Puzzle(question: "Number between \(a) and \(b)?", choices: choices, correctIndex: idx, category: "Logic")
    }
    
    static func sumOrProductPuzzle(_ d: Int) -> Puzzle {
        let a = Int.random(in: 2...(8 + d / 5))
        let b = Int.random(in: 2...(8 + d / 5))
        let isSum = Bool.random()
        let answer = isSum ? a + b : a * b
        return makeChoices(q: "\(isSum ? "Sum" : "Product") of \(a) and \(b) = ?", answer: answer, cat: "Logic")
    }
    
    // MARK: - Word Puzzles (85-94)
    
    static let wordBank = ["rain", "star", "blue", "fire", "cold", "dark", "gold", "fast", "slow", "deep",
                           "soft", "loud", "calm", "wild", "warm", "cool", "bold", "kind", "fair", "tall",
                           "wide", "thin", "rich", "pure", "rare", "vast", "keen", "mild", "pale", "grim"]
    
    static func anagramPuzzle(_ d: Int) -> Puzzle {
        let originals = ["star", "race", "evil", "note", "tale", "meat", "lead", "bare", "cafe", "grin"]
        let anagrams  = ["rats", "care", "vile", "tone", "late", "team", "deal", "bear", "face", "ring"]
        let idx = Int.random(in: 0..<originals.count)
        let answer = anagrams[idx]
        var choices = [answer]
        while choices.count < 4 {
            let w = anagrams.randomElement()!
            if !choices.contains(w) { choices.append(w) }
        }
        choices.shuffle()
        let ci = choices.firstIndex(of: answer)!
        return Puzzle(question: "Anagram of \"\(originals[idx])\"?", choices: choices, correctIndex: ci, category: "Word")
    }
    
    static func letterCountPuzzle(_ d: Int) -> Puzzle {
        let words = ["programming", "sequence", "pattern", "breaker", "algorithm", "challenge", "solution", "variable", "function", "keyboard"]
        let word = words.randomElement()!
        return makeChoices(q: "Letters in \"\(word)\" = ?", answer: word.count, cat: "Word")
    }
    
    static func firstLetterPuzzle(_ d: Int) -> Puzzle {
        let words = ["alpha", "bravo", "charlie", "delta", "echo", "foxtrot", "golf", "hotel"]
        let word = words.randomElement()!
        let first = String(word.first!).uppercased()
        let letters = ["A", "B", "C", "D", "E", "F", "G", "H"]
        var choices = [first]
        while choices.count < 4 {
            let l = letters.randomElement()!
            if !choices.contains(l) { choices.append(l) }
        }
        choices.shuffle()
        let idx = choices.firstIndex(of: first)!
        return Puzzle(question: "First letter of \"\(word)\"?", choices: choices, correctIndex: idx, category: "Word")
    }
    
    static func lastLetterPuzzle(_ d: Int) -> Puzzle {
        let words = ["stone", "brick", "cloud", "dream", "flame", "glass", "heart", "ivory"]
        let word = words.randomElement()!
        let last = String(word.last!).uppercased()
        let letters = ["E", "K", "D", "M", "S", "T", "Y", "N"]
        var choices = [last]
        while choices.count < 4 {
            let l = letters.randomElement()!
            if !choices.contains(l) { choices.append(l) }
        }
        choices.shuffle()
        let idx = choices.firstIndex(of: last)!
        return Puzzle(question: "Last letter of \"\(word)\"?", choices: choices, correctIndex: idx, category: "Word")
    }
    
    static func rhymePuzzle(_ d: Int) -> Puzzle {
        let pairs: [(String, String, [String])] = [
            ("cat", "hat", ["dog", "sun", "hat"]),
            ("moon", "spoon", ["star", "spoon", "lamp"]),
            ("day", "play", ["night", "play", "work"]),
            ("light", "night", ["dark", "bright", "night"]),
            ("rain", "train", ["snow", "train", "cloud"]),
            ("blue", "true", ["red", "true", "false"]),
            ("lake", "cake", ["pond", "cake", "fish"]),
        ]
        let p = pairs.randomElement()!
        var choices = p.2
        choices.shuffle()
        let idx = choices.firstIndex(of: p.1)!
        return Puzzle(question: "Rhymes with \"\(p.0)\"?", choices: choices + ["none"], correctIndex: idx, category: "Word")
    }
    
    static func vowelCountWordPuzzle(_ d: Int) -> Puzzle {
        let words = ["extraordinary", "beautiful", "onomatopoeia", "queue", "rhythm", "education", "aardvark", "sequoia"]
        let word = words.randomElement()!
        let vowels = "aeiouAEIOU"
        let count = word.filter { vowels.contains($0) }.count
        return makeChoices(q: "Vowels in \"\(word)\" = ?", answer: count, cat: "Word")
    }
    
    static func reverseWordPuzzle(_ d: Int) -> Puzzle {
        let words = ["star", "loop", "live", "draw", "stop", "snap", "trap", "mood"]
        let revs  = ["rats", "pool", "evil", "ward", "pots", "pans", "part", "doom"]
        let idx = Int.random(in: 0..<words.count)
        let answer = revs[idx]
        var choices = [answer]
        while choices.count < 4 {
            let w = revs.randomElement()!
            if !choices.contains(w) { choices.append(w) }
        }
        choices.shuffle()
        let ci = choices.firstIndex(of: answer)!
        return Puzzle(question: "Reverse \"\(words[idx])\"?", choices: choices, correctIndex: ci, category: "Word")
    }
    
    static func longestWordPuzzle(_ d: Int) -> Puzzle {
        var words: [String] = []
        let pool = ["cat", "elephant", "dog", "butterfly", "ox", "rhinoceros", "ant", "hippopotamus", "bee", "crocodile"]
        while words.count < 4 {
            let w = pool.randomElement()!
            if !words.contains(w) { words.append(w) }
        }
        let longest = words.max(by: { $0.count < $1.count })!
        let choices = words.shuffled()
        let idx = choices.firstIndex(of: longest)!
        return Puzzle(question: "Which is longest?", choices: choices, correctIndex: idx, category: "Word")
    }
    
    static func shortestWordPuzzle(_ d: Int) -> Puzzle {
        var words: [String] = []
        let pool = ["cat", "elephant", "dog", "butterfly", "ox", "rhinoceros", "ant", "hippopotamus", "bee", "crocodile"]
        while words.count < 4 {
            let w = pool.randomElement()!
            if !words.contains(w) { words.append(w) }
        }
        let shortest = words.min(by: { $0.count < $1.count })!
        let choices = words.shuffled()
        let idx = choices.firstIndex(of: shortest)!
        return Puzzle(question: "Which is shortest?", choices: choices, correctIndex: idx, category: "Word")
    }
    
    static func alphabetOrderPuzzle(_ d: Int) -> Puzzle {
        let letters = (0..<4).map { _ in String(UnicodeScalar(Int.random(in: 65...90))!) }
        let sorted = letters.sorted()
        let first = sorted[0]
        let choices = letters.shuffled()
        let idx = choices.firstIndex(of: first)!
        return Puzzle(question: "First alphabetically?", choices: choices, correctIndex: idx, category: "Word")
    }
    
    // MARK: - Visual/Counting (95-99)
    
    static func countSymbolsPuzzle(_ d: Int) -> Puzzle {
        let sym = ["#", "*", "+", "@", "&"].randomElement()!
        let count = Int.random(in: 3...(8 + d / 10))
        let noise = [".", "-", "~", "="]
        var str = ""
        var placed = 0
        let total = count + Int.random(in: 3...6)
        for _ in 0..<total {
            if placed < count && (Bool.random() || total - str.count <= count - placed) {
                str += sym
                placed += 1
            } else {
                str += noise.randomElement()!
            }
        }
        return makeChoices(q: "Count \"\(sym)\" in: \(str)", answer: count, cat: "Visual")
    }
    
    static func symmetryPuzzle(_ d: Int) -> Puzzle {
        // Which sequence reads same forwards and backwards?
        let palindromes = ["12321", "abcba", "45654", "78987"]
        let nonPalin = ["12345", "abcde", "45678", "78901"]
        let answer = palindromes.randomElement()!
        var choices = [answer]
        while choices.count < 4 {
            let w = nonPalin.randomElement()!
            if !choices.contains(w) { choices.append(w) }
        }
        choices.shuffle()
        let idx = choices.firstIndex(of: answer)!
        return Puzzle(question: "Which is symmetric?", choices: choices, correctIndex: idx, category: "Visual")
    }
    
    static func patternRowPuzzle(_ d: Int) -> Puzzle {
        // AB AB AB A? -> B
        let a = ["#", "*", "+", "@"].randomElement()!
        let b = [".", "-", "~", "="].randomElement()!
        let pattern = "\(a)\(b) \(a)\(b) \(a)\(b) \(a)?"
        let choices = [b, a, "#", "!"]
        var ch = choices
        ch.shuffle()
        let idx = ch.firstIndex(of: b)!
        return Puzzle(question: "Complete: \(pattern)", choices: ch, correctIndex: idx, category: "Visual")
    }
    
    static func countPairsPuzzle(_ d: Int) -> Puzzle {
        let nums = (0..<(6 + d / 10)).map { _ in Int.random(in: 1...5) }
        var counts: [Int: Int] = [:]
        for n in nums { counts[n, default: 0] += 1 }
        let pairs = counts.values.reduce(0) { $0 + $1 / 2 }
        let shown = nums.map { String($0) }.joined(separator: " ")
        return makeChoices(q: "Pairs in: \(shown) = ?", answer: pairs, cat: "Visual")
    }
    
    static func missingSymbolPuzzle(_ d: Int) -> Puzzle {
        // Pattern: # * + # * + # ? -> *
        let symbols = ["#", "*", "+"]
        let pattern = symbols + symbols + [symbols[0], "?"]
        let answer = symbols[1]
        var choices = symbols + ["@"]
        choices.shuffle()
        let idx = choices.firstIndex(of: answer)!
        return Puzzle(question: "Fill in: \(pattern.joined(separator: " "))", choices: choices, correctIndex: idx, category: "Visual")
    }
    
    // MARK: - Mixed (100-104)
    
    static func mathWordPuzzle(_ d: Int) -> Puzzle {
        let words = [("two", 2), ("three", 3), ("five", 5), ("seven", 7), ("eight", 8)]
        let p = words.randomElement()!
        let mult = Int.random(in: 2...(5 + d / 10))
        return makeChoices(q: "\"\(p.0)\" x \(mult) = ?", answer: p.1 * mult, cat: "Mixed")
    }
    
    static func codePatternPuzzle(_ d: Int) -> Puzzle {
        // A=1, B=2 ... what is C+D?
        let a = Int.random(in: 0..<26)
        let b = Int.random(in: 0..<26)
        let la = String(UnicodeScalar(65 + a)!)
        let lb = String(UnicodeScalar(65 + b)!)
        let answer = (a + 1) + (b + 1)
        return makeChoices(q: "A=1,B=2... \(la)+\(lb) = ?", answer: answer, cat: "Mixed")
    }
    
    static func digitPositionPuzzle(_ d: Int) -> Puzzle {
        let n = Int.random(in: 100...(999 + d * 10))
        let digits = Array(String(n))
        let pos = Int.random(in: 0..<digits.count)
        let posNames = ["1st", "2nd", "3rd", "4th"]
        let answer = digits[pos].wholeNumberValue!
        return makeChoices(q: "\(posNames[pos]) digit of \(n) = ?", answer: answer, cat: "Mixed")
    }
    
    static func combinedOpsPuzzle(_ d: Int) -> Puzzle {
        let a = Int.random(in: 1...(10 + d / 3))
        let b = Int.random(in: 1...(5 + d / 5))
        let c = Int.random(in: 1...(5 + d / 5))
        let answer = a + b * c
        return makeChoices(q: "\(a) + \(b) x \(c) = ?", answer: answer, cat: "Mixed")
    }
    
    static func chainCalcPuzzle(_ d: Int) -> Puzzle {
        let a = Int.random(in: 1...(10 + d / 3))
        let b = Int.random(in: 1...(5 + d / 5))
        let c = Int.random(in: 1...(5 + d / 5))
        let answer = (a + b) * c
        return makeChoices(q: "(\(a) + \(b)) x \(c) = ?", answer: answer, cat: "Mixed")
    }
    
    // MARK: - Helpers
    
    static func makeChoices(q: String, answer: Int, cat: String) -> Puzzle {
        var options = Set<Int>()
        options.insert(answer)
        while options.count < 4 {
            let offset = Int.random(in: 1...max(5, abs(answer / 2) + 3))
            let candidate = answer + (Bool.random() ? offset : -offset)
            if candidate >= 0 { options.insert(candidate) }
        }
        var arr = Array(options)
        arr.shuffle()
        let idx = arr.firstIndex(of: answer)!
        return Puzzle(question: q, choices: arr.map { String($0) }, correctIndex: idx, category: cat)
    }
    
    static func gcd(_ a: Int, _ b: Int) -> Int {
        var x = a, y = b
        while y != 0 { let t = y; y = x % y; x = t }
        return x
    }
}
