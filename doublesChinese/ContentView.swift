//
//  ContentView.swift
//  doublesChinese
//
//  Created by Wu, Fei on 9/12/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var dataManager: DataManager
    @EnvironmentObject private var settingsManager: SettingsManager
    @State private var showingWelcome = false
    
    var body: some View {
        ZStack {
            // Main flashcard view
            FlashcardView(dataManager: dataManager, settingsManager: settingsManager)
                .environment(\.colorTheme, settingsManager.selectedTheme.colorTheme)
                .background(settingsManager.selectedTheme.colorTheme.backgroundColor)
            
            // Welcome overlay for first-time users
            if showingWelcome {
                WelcomeOverlay {
                    showingWelcome = false
                }
            }
        }
        .onAppear {
            setupApp()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            // Save settings when app goes to background
            settingsManager.saveSettings()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
            // Save settings when app terminates
            settingsManager.saveSettings()
        }
    }
    
    private func setupApp() {
        if settingsManager.isFirstLaunch {
            // Set default selections for first-time users
            settingsManager.setDefaultSelections(dataManager: dataManager)
            // Immediately mark first launch complete to avoid overwriting user choices on next launch
            settingsManager.saveSettings()
            showingWelcome = true
        }
    }
}

struct WelcomeOverlay: View {
    let onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // App icon/title
                VStack(spacing: 16) {
                    Image(systemName: "book.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    
                    Text("Chinese Flashcards")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Learn Chinese characters with interactive flashcards")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                
                // Instructions
                VStack(alignment: .leading, spacing: 16) {
                    Text("How to use:")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        InstructionRow(
                            icon: "hand.tap.fill",
                            text: "Tap cards to reveal pinyin and meanings"
                        )
                        
                        InstructionRow(
                            icon: "checkmark.circle.fill",
                            text: "Mark Easy or Hard to track progress"
                        )
                        
                        InstructionRow(
                            icon: "gearshape.fill",
                            text: "Tap ⚙️ to change lessons and settings"
                        )
                    }
                }
                
                // Get started button
                Button("Start Learning!") {
                    onDismiss()
                }
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .background(Color.blue)
                .cornerRadius(12)
            }
            .padding(32)
            .background(Color(.systemBackground))
            .cornerRadius(20)
            .shadow(radius: 20)
            .padding(32)
        }
    }
}

struct InstructionRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.blue)
                .frame(width: 24)
            
            Text(text)
                .font(.body)
        }
    }
}

#Preview {
    ContentView()
}
