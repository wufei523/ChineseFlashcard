//
//  SettingsManager.swift
//  doublesChinese
//
//  Created by Wu, Fei on 9/15/25.
//

import Foundation

class SettingsManager: ObservableObject {
    @Published var selectedLessonIds: Set<UUID> = []
    @Published var shuffleCards: Bool = true
    @Published var reviewMode: Bool = false
    @Published var isFirstLaunch: Bool = true
    @Published var selectedTheme: AppTheme = .forest
    @Published var sessionSize: Int = 10 // Default to 10 cards per session
    
    private let selectedLessonsKey = "selectedLessons"
    private let shuffleCardsKey = "shuffleCards"
    private let reviewModeKey = "reviewMode"
    private let firstLaunchKey = "isFirstLaunch"
    private let selectedThemeKey = "selectedTheme"
    private let sessionSizeKey = "sessionSize"
    
    init() {
        loadSettings()
    }
    
    func loadSettings() {
        // Load shuffle and review mode settings
        shuffleCards = UserDefaults.standard.object(forKey: shuffleCardsKey) as? Bool ?? true
        reviewMode = UserDefaults.standard.object(forKey: reviewModeKey) as? Bool ?? false
        isFirstLaunch = UserDefaults.standard.object(forKey: firstLaunchKey) as? Bool ?? true
        sessionSize = UserDefaults.standard.object(forKey: sessionSizeKey) as? Int ?? 10
        
        // Load selected theme
        if let themeRawValue = UserDefaults.standard.string(forKey: selectedThemeKey),
           let theme = AppTheme(rawValue: themeRawValue) {
            selectedTheme = theme
        } else {
            selectedTheme = .forest // Default to forest theme
        }
        
        // Load selected lesson IDs
        if let savedLessonIds = UserDefaults.standard.data(forKey: selectedLessonsKey) {
            if let decodedIds = try? JSONDecoder().decode(Set<UUID>.self, from: savedLessonIds) {
                selectedLessonIds = decodedIds
            }
        }
    }
    
    func saveSettings() {
        UserDefaults.standard.set(shuffleCards, forKey: shuffleCardsKey)
        UserDefaults.standard.set(reviewMode, forKey: reviewModeKey)
        UserDefaults.standard.set(false, forKey: firstLaunchKey) // No longer first launch
        UserDefaults.standard.set(selectedTheme.rawValue, forKey: selectedThemeKey)
        UserDefaults.standard.set(sessionSize, forKey: sessionSizeKey)
        
        // Save selected lesson IDs
        if let encodedIds = try? JSONEncoder().encode(selectedLessonIds) {
            UserDefaults.standard.set(encodedIds, forKey: selectedLessonsKey)
        }
    }
    
    func setDefaultSelections(dataManager: DataManager) {
        // Select first 2 books by default for first-time users
        let defaultLessons = dataManager.lessons.filter { $0.bookNumber <= 2 }
        selectedLessonIds = Set(defaultLessons.map { $0.id })
        saveSettings()
    }
    
    func getSelectedLessons(from dataManager: DataManager) -> [Lesson] {
        return dataManager.lessons.filter { selectedLessonIds.contains($0.id) }
    }
    
    func updateSelectedLessons(_ lessonIds: Set<UUID>) {
        selectedLessonIds = lessonIds
        saveSettings()
    }
    
    func toggleShuffle() {
        shuffleCards.toggle()
        saveSettings()
    }
    
    func toggleReviewMode() {
        reviewMode.toggle()
        saveSettings()
    }
    
    // Get available characters for current selection
    func getAvailableCharacters(from dataManager: DataManager) -> [ChineseCharacter] {
        let selectedLessons = getSelectedLessons(from: dataManager)
        var characters = dataManager.getCharacters(from: selectedLessons)
        
        if reviewMode {
            characters = characters.filter { $0.difficultyLevel == .hard || $0.difficultyLevel == .medium }
        }
        
        return characters
    }
    
    // Get the actual session characters (limited by sessionSize)
    func getSessionCharacters(from dataManager: DataManager) -> [ChineseCharacter] {
        var characters = getAvailableCharacters(from: dataManager)
        
        // Handle empty selection
        if characters.isEmpty {
            // Fall back to a default selection (first few lessons)
            let defaultLessons = Array(dataManager.lessons.prefix(2))
            characters = dataManager.getCharacters(from: defaultLessons)
        }
        
        // Limit to session size
        if characters.count > sessionSize {
            characters = Array(characters.shuffled().prefix(sessionSize))
        }
        
        // Apply shuffle if needed (for final ordering)
        if shuffleCards {
            characters = characters.shuffled()
        }
        
        return characters
    }
    
    // Update session size with validation
    func updateSessionSize(_ newSize: Int, maxCharacters: Int) {
        sessionSize = max(1, min(newSize, maxCharacters))
        saveSettings()
    }
}
