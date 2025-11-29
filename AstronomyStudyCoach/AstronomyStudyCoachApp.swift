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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .preferredColorScheme(.dark) // Match the React app's dark theme
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
        self.userName = email.split(separator: "@").first?.capitalized ?? "User"
        self.isAuthenticated = true
        self.currentView = "dashboard"
    }
    
    func signUp(email: String, name: String) {
        self.userEmail = email
        self.userName = name
        self.isAuthenticated = true
        self.currentView = "dashboard"
    }
    
    func logout() {
        self.isAuthenticated = false
        self.userEmail = ""
        self.userName = ""
        self.currentView = "login"
    }
    
    func navigate(to view: String) {
        self.currentView = view
    }
}

