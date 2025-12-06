//
//  ThemeManager.swift
//  AstronomyStudyCoach
//
//  Created by user on 12/2/25.
//


import SwiftUI

class ThemeManager: ObservableObject {
    @AppStorage("appTheme") var theme: String = "system" {
        didSet {
            updateColorScheme()
        }
    }
    
    @Published var colorScheme: ColorScheme?
    
    init() {
        updateColorScheme()
    }
    
    func updateColorScheme() {
        switch theme {
        case "light":
            colorScheme = .light
        case "dark":
            colorScheme = .dark
        case "system":
            colorScheme = nil // nil means use system default
        default:
            colorScheme = nil
        }
    }
}


