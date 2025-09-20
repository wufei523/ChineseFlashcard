//
//  LessonSelectionView.swift
//  doublesChinese
//
//  Created by Wu, Fei on 9/15/25.
//  
//  NOTE: This file is no longer used in the app. 
//  Lesson selection has been moved to SettingsView.swift
//  The app now launches directly into flashcard mode.
//

import SwiftUI

// This view is deprecated and no longer used in the app
struct LessonSelectionView: View {
    @ObservedObject var dataManager: DataManager
    
    var body: some View {
        Text("This view is no longer used")
            .foregroundColor(.secondary)
    }
}

#Preview {
    LessonSelectionView(dataManager: DataManager())
}
