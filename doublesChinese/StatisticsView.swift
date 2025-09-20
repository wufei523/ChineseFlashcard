//
//  StatisticsView.swift
//  doublesChinese
//
//  Created by Wu, Fei on 9/15/25.
//

import SwiftUI

struct StatisticsView: View {
    @ObservedObject var dataManager: DataManager
    @Environment(\.dismiss) private var dismiss
    
    var learningStats: LearningStats {
        dataManager.getLearningStats()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Button("Close") {
                    dismiss()
                }
                
                Spacer()
                
                Text("Progress")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                // Invisible button for balance
                Button("") { }
                    .opacity(0)
            }
            .padding()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Overall progress
                    ProgressSectionView(stats: learningStats)
                    
                    // Difficulty breakdown
                    DifficultyBreakdownView(stats: learningStats)
                    
                    // Character list with difficulties
                    CharacterListView(dataManager: dataManager)
                }
                .padding()
            }
        }
    }
}

struct ProgressSectionView: View {
    let stats: LearningStats
    
    var progressPercentage: Double {
        guard stats.totalCharacters > 0 else { return 0 }
        return Double(stats.charactersStudied) / Double(stats.totalCharacters)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Overall Progress")
                .font(.title2)
                .fontWeight(.semibold)
            
            // Progress circle
            HStack {
                ZStack {
                    Circle()
                        .stroke(Color(.systemGray4), lineWidth: 8)
                        .frame(width: 100, height: 100)
                    
                    Circle()
                        .trim(from: 0, to: progressPercentage)
                        .stroke(Color.blue, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .frame(width: 100, height: 100)
                        .rotationEffect(.degrees(-90))
                    
                    Text("\(Int(progressPercentage * 100))%")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 8) {
                    StatItem(
                        title: "Characters Studied",
                        value: "\(stats.charactersStudied)/\(stats.totalCharacters)"
                    )
                    
                    StatItem(
                        title: "Overall Accuracy",
                        value: "\(Int(stats.averageAccuracy * 100))%"
                    )
                    
                    StatItem(
                        title: "Recent Sessions",
                        value: "\(stats.recentSessions.count)"
                    )
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

struct DifficultyBreakdownView: View {
    let stats: LearningStats
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Characters by Difficulty")
                .font(.title2)
                .fontWeight(.semibold)
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                ForEach(DifficultyLevel.allCases, id: \.self) { level in
                    DifficultyCard(
                        level: level,
                        count: stats.charactersByDifficulty[level] ?? 0
                    )
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

struct DifficultyCard: View {
    let level: DifficultyLevel
    let count: Int
    
    var levelColor: Color {
        switch level {
        case .new: return .blue
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        }
    }
    
    var levelIcon: String {
        switch level {
        case .new: return "star.fill"
        case .easy: return "checkmark.circle.fill"
        case .medium: return "clock.fill"
        case .hard: return "exclamationmark.triangle.fill"
        }
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: levelIcon)
                .font(.title2)
                .foregroundColor(levelColor)
            
            Text("\(count)")
                .font(.title)
                .fontWeight(.bold)
            
            Text(level.rawValue)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(levelColor.opacity(0.1))
        .cornerRadius(12)
    }
}

struct CharacterListView: View {
    @ObservedObject var dataManager: DataManager
    @State private var selectedDifficulty: DifficultyLevel? = nil
    @State private var searchText = ""
    
    var filteredCharacters: [ChineseCharacter] {
        var characters = dataManager.allCharacters
        
        if let selectedDifficulty = selectedDifficulty {
            characters = characters.filter { $0.difficultyLevel == selectedDifficulty }
        }
        
        if !searchText.isEmpty {
            characters = characters.filter { character in
                character.character.contains(searchText) ||
                character.pinyin.lowercased().contains(searchText.lowercased()) ||
                character.meaning.lowercased().contains(searchText.lowercased())
            }
        }
        
        return characters.sorted { lhs, rhs in
            if lhs.bookNumber != rhs.bookNumber {
                return lhs.bookNumber < rhs.bookNumber
            }
            return lhs.lessonNumber < rhs.lessonNumber
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Character Details")
                .font(.title2)
                .fontWeight(.semibold)
            
            // Search and filter
            VStack(spacing: 12) {
                SearchBar(text: $searchText)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        DifficultyFilterButton(
                            title: "All",
                            isSelected: selectedDifficulty == nil
                        ) {
                            selectedDifficulty = nil
                        }
                        
                        ForEach(DifficultyLevel.allCases, id: \.self) { level in
                            DifficultyFilterButton(
                                title: level.rawValue,
                                isSelected: selectedDifficulty == level
                            ) {
                                selectedDifficulty = level
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            // Character list
            LazyVStack(spacing: 8) {
                ForEach(filteredCharacters) { character in
                    CharacterRowView(character: character)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            
            TextField("Search characters...", text: $text)
                .textFieldStyle(PlainTextFieldStyle())
        }
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct DifficultyFilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(isSelected ? .white : .blue)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.blue : Color.blue.opacity(0.1))
                .cornerRadius(20)
        }
    }
}

struct CharacterRowView: View {
    let character: ChineseCharacter
    
    var accuracyText: String {
        guard character.reviewCount > 0 else { return "Not practiced" }
        let accuracy = Double(character.correctCount) / Double(character.reviewCount)
        return "\(Int(accuracy * 100))% (\(character.correctCount)/\(character.reviewCount))"
    }
    
    var body: some View {
        HStack(spacing: 16) {
            // Character
            Text(character.character)
                .font(.title)
                .fontWeight(.bold)
                .frame(width: 50)
            
            // Details
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(character.pinyin)
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    
                    DifficultyBadge(level: character.difficultyLevel)
                }
                
                Text(character.meaning)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Book \(character.bookNumber), Lesson \(character.lessonNumber)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(accuracyText)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

struct StatItem: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.headline)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    StatisticsView(dataManager: DataManager())
}
