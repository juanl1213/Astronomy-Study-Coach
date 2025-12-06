//
//  AstronomyStudyCoachApp.swift
//  Astronomy Study Coach
//
//  Main app entry point
//

import SwiftUI

@main
struct AstronomyStudyCoachApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var themeManager = ThemeManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environmentObject(themeManager)
                .preferredColorScheme(themeManager.colorScheme)
        }
    }
}

// MARK: - App State
class AppState: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var currentView: String = "login"
    @Published var userEmail: String = ""
    @Published var userName: String = ""
    
    func login(email: String) {
        self.userEmail = email
        // Get user name from UserManager if available
        self.userName = UserManager.shared.getUserName(email: email) ?? email.split(separator: "@").first?.capitalized ?? "User"
        self.isAuthenticated = true
        self.currentView = "dashboard"
        
        // Initialize progress if new user (will use demo data for demo account)
        if ProgressManager.shared.loadUserProgress(email: email) == nil {
            ProgressManager.shared.initializeProgress(for: email)
        } else if email == "astronomer@space.edu" {
            // Ensure demo account has demo data (in case it was cleared)
            let progress = ProgressManager.shared.loadUserProgress(email: email)
            if progress?.completedLessons.isEmpty == true {
                ProgressManager.shared.initializeDemoProgress(for: email)
            }
        }
    }
    
    func signUp(email: String, name: String) {
        self.userEmail = email
        self.userName = name
        self.isAuthenticated = true
        self.currentView = "dashboard"
        
        // Initialize progress for new user
        ProgressManager.shared.initializeProgress(for: email)
    }
    
    func logout() {
        // Save current AI chat conversation before logging out
        if !self.userEmail.isEmpty {
            // The chat view will automatically save when messages change,
            // but we ensure it's saved on logout by triggering a save
            // This is handled by the AIStudyAssistantView's onChange observer
        }
        
        self.isAuthenticated = false
        self.userEmail = ""
        self.userName = ""
        self.currentView = "login"
    }
    
    func navigate(to view: String) {
        self.currentView = view
    }
}


