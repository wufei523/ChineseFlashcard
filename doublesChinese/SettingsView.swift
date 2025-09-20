//
//  SettingsView.swift
//  doublesChinese
//
//  Created by Wu, Fei on 9/15/25.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var dataManager: DataManager
    @ObservedObject var settingsManager: SettingsManager
    @State private var localSelectedLessons: Set<UUID> = []
    @State private var showingStatistics = false
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorTheme) var colorTheme
    
    var selectedCharactersCount: Int {
        // Use local selections (not saved settings) for real-time updates
        let selectedLessonObjects = dataManager.lessons.filter { localSelectedLessons.contains($0.id) }
        let characters = dataManager.getCharacters(from: selectedLessonObjects)
        return characters.count
    }
    
    var maxSessionSize: Int {
        let maxSize = max(1, selectedCharactersCount)
        // Automatically clamp session size when max changes
        if settingsManager.sessionSize > maxSize {
            DispatchQueue.main.async {
                settingsManager.updateSessionSize(maxSize, maxCharacters: maxSize)
            }
        }
        return maxSize
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with title and buttons
            HStack {
                Button("Cancel") {
                    // Restore original selections
                    localSelectedLessons = settingsManager.selectedLessonIds
                    dismiss()
                }
                .foregroundColor(colorTheme.accentColor)
                
                Spacer()
                
                Text("Settings")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(colorTheme.primaryTextColor)
                
                Spacer()
                
                Button("Save") {
                    settingsManager.updateSelectedLessons(localSelectedLessons)
                    dismiss()
                }
                .fontWeight(.semibold)
                .disabled(localSelectedLessons.isEmpty)
                .foregroundColor(localSelectedLessons.isEmpty ? colorTheme.secondaryTextColor : colorTheme.accentColor)
            }
            .padding()
            .background(colorTheme.backgroundColor)
            
            // Main content
            Form {
                // App Info Section
                Section {
                    Button(action: { showingStatistics = true }) {
                        HStack {
                            Image(systemName: "chart.bar.fill")
                                .foregroundColor(.blue)
                            Text("View Progress & Statistics")
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                                .font(.caption)
                        }
                    }
                    .buttonStyle(.plain)
                }
                
                // Practice Options Section
                Section("Practice Options") {
                    Toggle("Shuffle Cards", isOn: $settingsManager.shuffleCards)
                        .onChange(of: settingsManager.shuffleCards) { oldValue, newValue in
                            settingsManager.saveSettings()
                        }
                    
                    HStack {
                        Text("Selected Characters")
                        Spacer()
                        Text("\(selectedCharactersCount)")
                            .foregroundColor(.secondary)
                    }
                    
                    // Session Size Control
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Cards per Session")
                            Spacer()
                            Text("\(settingsManager.sessionSize)")
                                .foregroundColor(.secondary)
                        }
                        
                        if selectedCharactersCount > 0 {
                            Slider(
                                value: Binding(
                                    get: { Double(settingsManager.sessionSize) },
                                    set: { newValue in
                                        settingsManager.updateSessionSize(Int(newValue), maxCharacters: maxSessionSize)
                                    }
                                ),
                                in: 1...Double(maxSessionSize),
                                step: 1
                            )
                            
                            HStack {
                                Text("1")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("\(maxSessionSize)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        } else {
                            Text("Select lessons first to set session size")
                                .font(.caption)
                                .foregroundColor(.orange)
                        }
                        
                        Text("Randomly selects characters from your selection for each session")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                // Theme Selection Section
                Section("Color Theme (Eye Health)") {
                    Picker("Theme", selection: $settingsManager.selectedTheme) {
                        ForEach(AppTheme.allCases, id: \.self) { theme in
                            Text(theme.colorTheme.name).tag(theme)
                        }
                    }
                    .pickerStyle(.menu)
                    .onChange(of: settingsManager.selectedTheme) { oldValue, newValue in
                        settingsManager.saveSettings()
                    }
                }
                
                // Lesson Selection Section
                Section("Select Lessons") {
                    ForEach(dataManager.getAvailableBooks(), id: \.self) { bookNumber in
                        BookSelectionSection(
                            bookNumber: bookNumber,
                            lessons: dataManager.getLessons(for: bookNumber),
                            selectedLessons: $localSelectedLessons
                        )
                    }
                }
                
                // Quick Selection Section
                Section("Quick Selection") {
                    Button("Select All") {
                        localSelectedLessons = Set(dataManager.lessons.map { $0.id })
                    }
                    
                    Button("Select Book 1 Only") {
                        let book1Lessons = dataManager.lessons.filter { $0.bookNumber == 1 }
                        localSelectedLessons = Set(book1Lessons.map { $0.id })
                    }
                    
                    Button("Select Book 2 Only") {
                        let book2Lessons = dataManager.lessons.filter { $0.bookNumber == 2 }
                        localSelectedLessons = Set(book2Lessons.map { $0.id })
                    }
                    
                    Button("Clear All") {
                        localSelectedLessons.removeAll()
                    }
                    .foregroundColor(colorTheme.incorrectButtonColor)
                }
            }
            .scrollContentBackground(.hidden)
            .background(colorTheme.backgroundColor)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        // Restore original selections
                        localSelectedLessons = settingsManager.selectedLessonIds
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        settingsManager.updateSelectedLessons(localSelectedLessons)
                        dismiss()
                    }
                    .fontWeight(.semibold)
                    .disabled(localSelectedLessons.isEmpty)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        // Restore original selections
                        localSelectedLessons = settingsManager.selectedLessonIds
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        settingsManager.updateSelectedLessons(localSelectedLessons)
                        dismiss()
                    }
                    .fontWeight(.semibold)
                    .disabled(localSelectedLessons.isEmpty)
                }
            }
        }
        .background(colorTheme.backgroundColor)
        .onAppear {
            localSelectedLessons = settingsManager.selectedLessonIds
        }
        .sheet(isPresented: $showingStatistics) {
            StatisticsView(dataManager: dataManager)
                .presentationDetents([.large])
                .presentationDragIndicator(.hidden)
        }
    }
}

struct BookSelectionSection: View {
    let bookNumber: Int
    let lessons: [Lesson]
    @Binding var selectedLessons: Set<UUID>
    
    var allLessonsSelected: Bool {
        lessons.allSatisfy { selectedLessons.contains($0.id) }
    }
    
    var body: some View {
        DisclosureGroup("Book \(bookNumber)") {
            // Select all for this book
            HStack {
                Button(action: toggleAllLessons) {
                    HStack {
                        Image(systemName: allLessonsSelected ? "checkmark.square.fill" : "square")
                            .foregroundColor(allLessonsSelected ? .blue : .secondary)
                        Text("Select All Book \(bookNumber)")
                    }
                }
                .buttonStyle(.plain)
                Spacer()
            }
            .padding(.vertical, 4)
            
            // Individual lessons
            ForEach(lessons) { lesson in
                HStack {
                    Button(action: { toggleLesson(lesson.id) }) {
                        HStack {
                            Image(systemName: selectedLessons.contains(lesson.id) ? "checkmark.square.fill" : "square")
                                .foregroundColor(selectedLessons.contains(lesson.id) ? .blue : .secondary)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Lesson \(lesson.lessonNumber): \(lesson.title)")
                                    .font(.body)
                                Text("\(lesson.characters.count) characters")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .buttonStyle(.plain)
                    Spacer()
                }
                .padding(.vertical, 2)
            }
        }
    }
    
    private func toggleAllLessons() {
        if allLessonsSelected {
            for lesson in lessons {
                selectedLessons.remove(lesson.id)
            }
        } else {
            for lesson in lessons {
                selectedLessons.insert(lesson.id)
            }
        }
    }
    
    private func toggleLesson(_ lessonId: UUID) {
        if selectedLessons.contains(lessonId) {
            selectedLessons.remove(lessonId)
        } else {
            selectedLessons.insert(lessonId)
        }
    }
}

#Preview {
    SettingsView(dataManager: DataManager(), settingsManager: SettingsManager())
}
