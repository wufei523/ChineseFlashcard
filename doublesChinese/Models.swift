//
//  Models.swift
//  doublesChinese
//
//  Created by Wu, Fei on 9/15/25.
//

import Foundation

// Model for a Chinese character with all its learning information
struct ChineseCharacter: Identifiable, Codable {
    let id: UUID
    let character: String
    let pinyin: String
    let meaning: String
    let exampleWords: [String]
    let bookNumber: Double // Changed to Double to support decimal book numbers (e.g., 2.1)
    let lessonNumber: Int
    
    // For tracking learning progress
    var reviewCount: Int = 0
    var correctCount: Int = 0
    var lastReviewed: Date?
    
    init(character: String, pinyin: String, meaning: String, exampleWords: [String], bookNumber: Double, lessonNumber: Int) {
        // Create a deterministic UUID based on book, lesson numbers and character unicode value
        let charValue = character.unicodeScalars.first?.value ?? 0
        let bookValue = UInt(bookNumber * 10) // Convert 2.1 to 21 for unique ID generation
        let value = (bookValue * 1000000 + UInt(lessonNumber) * 1000 + UInt(charValue % 1000))
        let uuidString = String(format: "00000000-0000-4000-8000-%012d", value)
        self.id = UUID(uuidString: uuidString)!
        self.character = character
        self.pinyin = pinyin
        self.meaning = meaning
        self.exampleWords = exampleWords
        self.bookNumber = bookNumber
        self.lessonNumber = lessonNumber
    }
    
    var difficultyLevel: DifficultyLevel {
        if reviewCount == 0 { return .new }
        let accuracy = Double(correctCount) / Double(reviewCount)
        if accuracy >= 0.8 { return .easy }
        if accuracy >= 0.6 { return .medium }
        return .hard
    }
}

enum DifficultyLevel: String, CaseIterable {
    case new = "New"
    case easy = "Easy"
    case medium = "Medium" 
    case hard = "Hard"
}

// Model for organizing lessons
struct Lesson: Identifiable, Codable {
    let id: UUID
    let bookNumber: Double // Changed to Double to support decimal book numbers (e.g., 2.1)
    let lessonNumber: Int
    let title: String
    var characters: [ChineseCharacter]
    
    init(bookNumber: Double, lessonNumber: Int, title: String, characters: [ChineseCharacter]) {
        // Create a deterministic UUID based on book and lesson numbers
        let bookValue = Int(bookNumber * 10) // Convert 2.1 to 21 for unique ID generation
        let uuidString = String(format: "00000000-0000-4000-8000-%012d", bookValue * 1000 + lessonNumber)
        self.id = UUID(uuidString: uuidString)!
        self.bookNumber = bookNumber
        self.lessonNumber = lessonNumber
        self.title = title
        self.characters = characters
    }
    
    var lessonIdentifier: String {
        "Book \(String(format: "%.1f", bookNumber)), Lesson \(lessonNumber)"
    }
}

// Model for practice session settings
struct PracticeSession {
    let selectedLessons: [Lesson]
    let selectedCharacters: [ChineseCharacter]
    let shuffled: Bool
    let reviewMode: Bool // Only show characters that need more practice
    
    var practiceCharacters: [ChineseCharacter] {
        var characters = selectedCharacters
        
        if reviewMode {
            characters = characters.filter { $0.difficultyLevel == .hard || $0.difficultyLevel == .medium }
        }
        
        if shuffled {
            characters = characters.shuffled()
        }
        
        return characters
    }
}

// Model for tracking overall progress
struct LearningStats {
    let totalCharacters: Int
    let charactersStudied: Int
    let averageAccuracy: Double
    let charactersByDifficulty: [DifficultyLevel: Int]
    let recentSessions: [Date]
}
