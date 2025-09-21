//
//  FlashcardView.swift
//  doublesChinese
//
//  Created by Wu, Fei on 9/15/25.
//

import SwiftUI

struct FlashcardView: View {
    @ObservedObject var dataManager: DataManager
    @ObservedObject var settingsManager: SettingsManager
    @Environment(\.colorTheme) var colorTheme
    
    @State private var currentIndex = 0
    @State private var showAnswer = false
    @State private var practiceCharacters: [ChineseCharacter] = []
    @State private var sessionStats = SessionStats()
    @State private var showingSettings = false
    @State private var showingRestartConfirmation = false
    
    var currentCharacter: ChineseCharacter? {
        guard currentIndex < practiceCharacters.count else { return nil }
        return practiceCharacters[currentIndex]
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with settings and action buttons
            HStack {
                Button {
                    showingSettings = true
                } label: {
                    Image(systemName: "gearshape.fill")
                        .font(.title2)
                }
                
                Spacer()
                
                Text("Practice")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                HStack(spacing: 12) {
                    // Restart Session button
                    Button {
                        showingRestartConfirmation = true
                    } label: {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .font(.title2)
                            .foregroundColor(colorTheme.accentColor)
                    }
                    .disabled(currentCharacter == nil)
                    
                    // Skip button
                    Button("Skip") {
                        nextCard()
                    }
                    .disabled(currentCharacter == nil)
                }
            }
            .padding()
            
            GeometryReader { geometry in
                VStack(spacing: 20) {
                    // Top section with progress and stats
                    VStack(spacing: 10) {
                        // Progress bar
                        ProgressView(value: Double(currentIndex), total: Double(practiceCharacters.count))
                            .progressViewStyle(LinearProgressViewStyle(tint: colorTheme.progressBarColor))
                            .scaleEffect(x: 1, y: 2, anchor: .center)
                            .padding(.horizontal)
                        
                        // Progress info
                        HStack {
                            Text("\(currentIndex + 1) of \(practiceCharacters.count)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            HStack(spacing: 16) {
                                Label("\(sessionStats.correct)", systemImage: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                    .font(.caption)
                                
                                Label("\(sessionStats.incorrect)", systemImage: "xmark.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.caption)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Center section with flashcard
                    ZStack {
                        if let character = currentCharacter {
                            FlashcardContentView(
                                character: character,
                                showAnswer: showAnswer,
                                geometry: geometry
                            ) {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    showAnswer.toggle()
                                }
                            }
                        } else {
                            // Session complete
                            SessionCompleteView(
                                stats: sessionStats,
                                totalCharacters: practiceCharacters.count
                            ) {
                                // Restart with current settings
                                setupPracticeSession()
                            }
                        }
                    }
                    .frame(maxHeight: .infinity)
                    
                    // Bottom section with buttons
                    VStack(spacing: 10) {
                        if showAnswer && currentCharacter != nil {
                            HStack(spacing: 20) {
                                Button(action: { markAnswer(correct: false) }) {
                                    HStack {
                                        Image(systemName: "xmark.circle.fill")
                                        Text("Don't Know")
                                    }
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(colorTheme.incorrectButtonColor)
                                    .cornerRadius(12)
                                }
                                
                                Button(action: { markAnswer(correct: true) }) {
                                    HStack {
                                        Image(systemName: "checkmark.circle.fill")
                                        Text("I Know")
                                    }
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(colorTheme.correctButtonColor)
                                    .cornerRadius(12)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        if !showAnswer {
                            Text("Tap the card to see the answer")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.bottom, 5)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView(dataManager: dataManager, settingsManager: settingsManager)
                .environment(\.colorTheme, colorTheme)
                .presentationDetents([.large])
                .presentationDragIndicator(.hidden)
        }
        .alert("Restart Session", isPresented: $showingRestartConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Restart", role: .destructive) {
                restartSession()
            }
        } message: {
            Text("Are you sure you want to restart this session? Your current progress will be lost.")
        }
        .onAppear {
            setupPracticeSession()
        }
        .onChange(of: settingsManager.selectedLessonIds) { oldValue, newValue in
            setupPracticeSession()
        }
        .onChange(of: settingsManager.shuffleCards) { oldValue, newValue in
            setupPracticeSession()
        }
        .onChange(of: settingsManager.reviewMode) { oldValue, newValue in
            setupPracticeSession()
        }
        .onChange(of: settingsManager.sessionSize) { oldValue, newValue in
            setupPracticeSession()
        }
    }
    
    private func setupPracticeSession() {
        practiceCharacters = settingsManager.getSessionCharacters(from: dataManager)
        currentIndex = 0
        showAnswer = false
        sessionStats = SessionStats()
    }
    
    private func restartSession() {
        // Reset all session state
        setupPracticeSession()
        
        // Reset any UI state
        showAnswer = false
        
        // Optional: Add haptic feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }
    
    private func markAnswer(correct: Bool) {
        guard let character = currentCharacter else { return }
        
        // Update statistics
        if correct {
            sessionStats.correct += 1
        } else {
            sessionStats.incorrect += 1
        }
        
        // Update character progress in data manager
        dataManager.updateCharacterProgress(character, wasCorrect: correct)
        
        // Move to next card
        nextCard()
    }
    
    private func nextCard() {
        withAnimation(.easeInOut(duration: 0.3)) {
            showAnswer = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            currentIndex += 1
        }
    }
}

struct FlashcardContentView: View {
    let character: ChineseCharacter
    let showAnswer: Bool
    let geometry: GeometryProxy
    let onTap: () -> Void
    @Environment(\.colorTheme) var colorTheme
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 20) {
                // Chinese character (always visible)
                Text(character.character)
                    .font(.system(size: min(geometry.size.width * 0.4, 200), weight: .bold, design: .serif))
                    .foregroundColor(colorTheme.primaryTextColor)
                
                // Answer content (only when revealed)
                if showAnswer {
                    VStack(spacing: 16) {
                        // Pinyin
                        Text(character.pinyin)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundColor(colorTheme.accentColor)
                        
                        // Meaning
                        Text(character.meaning)
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(colorTheme.secondaryTextColor)
                        
                        // Example words
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Examples:")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(colorTheme.primaryTextColor)
                            
                            ForEach(character.exampleWords, id: \.self) { example in
                                Text(example)
                                    .font(.title3)
                                    .foregroundColor(colorTheme.secondaryTextColor)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
            .padding(32)
            .frame(maxWidth: .infinity, maxHeight: showAnswer ? .infinity : 300)
            .background(colorTheme.cardBackgroundColor)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(.systemGray4), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .padding(.horizontal)
    }
}

struct DifficultyBadge: View {
    let level: DifficultyLevel
    
    var badgeColor: Color {
        switch level {
        case .new: return .blue
        case .easy: return .green
        case .medium: return .orange
        case .hard: return .red
        }
    }
    
    var body: some View {
        Text(level.rawValue)
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(badgeColor)
            .cornerRadius(12)
    }
}

struct SessionCompleteView: View {
    let stats: SessionStats
    let totalCharacters: Int
    let onClose: () -> Void
    
    var accuracy: Double {
        let total = stats.correct + stats.incorrect
        return total > 0 ? Double(stats.correct) / Double(total) : 0
    }
    
    var body: some View {
        VStack(spacing: 24) {
            // Celebration icon
            Image(systemName: "star.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.yellow)
            
            Text("Session Complete!")
                .font(.title)
                .fontWeight(.bold)
            
            // Statistics
            VStack(spacing: 16) {
                StatRow(label: "Characters Practiced", value: "\(totalCharacters)")
                StatRow(label: "Correct Answers", value: "\(stats.correct)")
                StatRow(label: "Incorrect Answers", value: "\(stats.incorrect)")
                StatRow(label: "Accuracy", value: "\(Int(accuracy * 100))%")
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(16)
            
            Button("Start New Session") {
                onClose()
            }
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(12)
        }
        .padding()
    }
}

struct StatRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.semibold)
        }
    }
}

struct SessionStats {
    var correct = 0
    var incorrect = 0
}

#Preview {
    let dataManager = DataManager()
    let settingsManager = SettingsManager()
    
    return FlashcardView(dataManager: dataManager, settingsManager: settingsManager)
}
