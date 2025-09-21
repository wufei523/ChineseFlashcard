//
//  doublesChineseApp.swift
//  doublesChinese
//
//  Created by Wu, Fei on 9/12/25.
//

import SwiftUI

@main
struct doublesChineseApp: App {
    // Create shared instances that persist throughout app lifecycle
    @StateObject private var dataManager = DataManager()
    @StateObject private var settingsManager = SettingsManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light) // Force light mode
                .environmentObject(dataManager)
                .environmentObject(settingsManager)
        }
    }
}
