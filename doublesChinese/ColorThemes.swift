//
//  ColorThemes.swift
//  doublesChinese
//
//  Created by Wu, Fei on 9/15/25.
//

import SwiftUI

// Color theme for eye health and comfort
struct ColorTheme {
    let name: String
    let backgroundColor: Color
    let cardBackgroundColor: Color
    let primaryTextColor: Color
    let secondaryTextColor: Color
    let accentColor: Color
    let correctButtonColor: Color
    let incorrectButtonColor: Color
    let progressBarColor: Color
}

enum AppTheme: String, CaseIterable {
    case light = "Light"
    case dark = "Dark" 
    case sepia = "Sepia"
    case forest = "Forest"
    case ocean = "Ocean"
    
    var colorTheme: ColorTheme {
        switch self {
        case .light:
            return ColorTheme(
                name: "Light",
                backgroundColor: Color(.systemBackground),
                cardBackgroundColor: Color(.systemBackground),
                primaryTextColor: Color(.label),
                secondaryTextColor: Color(.secondaryLabel),
                accentColor: Color.blue,
                correctButtonColor: Color.green,
                incorrectButtonColor: Color.red,
                progressBarColor: Color.blue
            )
            
        case .dark:
            return ColorTheme(
                name: "Dark",
                backgroundColor: Color(red: 0.1, green: 0.1, blue: 0.1),
                cardBackgroundColor: Color(red: 0.15, green: 0.15, blue: 0.15),
                primaryTextColor: Color(red: 0.95, green: 0.95, blue: 0.95),
                secondaryTextColor: Color(red: 0.7, green: 0.7, blue: 0.7),
                accentColor: Color(red: 0.4, green: 0.7, blue: 1.0),
                correctButtonColor: Color(red: 0.3, green: 0.8, blue: 0.4),
                incorrectButtonColor: Color(red: 0.9, green: 0.4, blue: 0.4),
                progressBarColor: Color(red: 0.4, green: 0.7, blue: 1.0)
            )
            
        case .sepia:
            return ColorTheme(
                name: "Sepia (Eye Comfort)",
                backgroundColor: Color(red: 0.98, green: 0.94, blue: 0.85),
                cardBackgroundColor: Color(red: 0.96, green: 0.91, blue: 0.81),
                primaryTextColor: Color(red: 0.3, green: 0.2, blue: 0.1),
                secondaryTextColor: Color(red: 0.5, green: 0.4, blue: 0.3),
                accentColor: Color(red: 0.6, green: 0.4, blue: 0.2),
                correctButtonColor: Color(red: 0.4, green: 0.6, blue: 0.3),
                incorrectButtonColor: Color(red: 0.7, green: 0.4, blue: 0.3),
                progressBarColor: Color(red: 0.6, green: 0.4, blue: 0.2)
            )
            
        case .forest:
            return ColorTheme(
                name: "Forest (Relaxing)",
                backgroundColor: Color(red: 0.92, green: 0.95, blue: 0.90),
                cardBackgroundColor: Color(red: 0.88, green: 0.92, blue: 0.85),
                primaryTextColor: Color(red: 0.2, green: 0.3, blue: 0.2),
                secondaryTextColor: Color(red: 0.4, green: 0.5, blue: 0.4),
                accentColor: Color(red: 0.3, green: 0.6, blue: 0.4),
                correctButtonColor: Color(red: 0.2, green: 0.7, blue: 0.3),
                incorrectButtonColor: Color(red: 0.8, green: 0.5, blue: 0.3),
                progressBarColor: Color(red: 0.3, green: 0.6, blue: 0.4)
            )
            
        case .ocean:
            return ColorTheme(
                name: "Ocean (Cool Blue)",
                backgroundColor: Color(red: 0.90, green: 0.94, blue: 0.98),
                cardBackgroundColor: Color(red: 0.85, green: 0.91, blue: 0.96),
                primaryTextColor: Color(red: 0.1, green: 0.2, blue: 0.3),
                secondaryTextColor: Color(red: 0.3, green: 0.4, blue: 0.5),
                accentColor: Color(red: 0.2, green: 0.5, blue: 0.7),
                correctButtonColor: Color(red: 0.2, green: 0.6, blue: 0.8),
                incorrectButtonColor: Color(red: 0.7, green: 0.4, blue: 0.5),
                progressBarColor: Color(red: 0.2, green: 0.5, blue: 0.7)
            )
        }
    }
}

// Environment key for color theme
struct ColorThemeKey: EnvironmentKey {
    static let defaultValue: ColorTheme = AppTheme.light.colorTheme
}

extension EnvironmentValues {
    var colorTheme: ColorTheme {
        get { self[ColorThemeKey.self] }
        set { self[ColorThemeKey.self] = newValue }
    }
}
