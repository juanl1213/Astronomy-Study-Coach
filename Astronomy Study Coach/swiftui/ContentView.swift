//
//  ContentView.swift
//  Astronomy Study Coach
//
//  Main content view that handles navigation between all screens
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            Group {
                switch appState.currentView {
                case "login":
                    LoginView(
                        onNavigate: { view in
                            appState.navigate(to: view)
                        },
                        onLogin: { email in
                            appState.login(email: email)
                        }
                    )
                    
                case "signup":
                    SignUpView(
                        onNavigate: { view in
                            appState.navigate(to: view)
                        },
                        onSignUp: { email, name in
                            appState.signUp(email: email, name: name)
                        }
                    )
                    
                case "dashboard":
                    if appState.isAuthenticated {
                        MainAppView()
                            .environmentObject(appState)
                    } else {
                        LoginView(
                            onNavigate: { view in
                                appState.navigate(to: view)
                            },
                            onLogin: { email in
                                appState.login(email: email)
                            }
                        )
                    }
                    
                case "settings":
                    if appState.isAuthenticated {
                        SettingsView(
                            onNavigate: { view in
                                appState.navigate(to: view)
                            },
                            userEmail: appState.userEmail,
                            userName: appState.userName
                        )
                    } else {
                        LoginView(
                            onNavigate: { view in
                                appState.navigate(to: view)
                            },
                            onLogin: { email in
                                appState.login(email: email)
                            }
                        )
                    }
                    
                default:
                    if appState.isAuthenticated {
                        MainAppView()
                            .environmentObject(appState)
                    } else {
                        LoginView(
                            onNavigate: { view in
                                appState.navigate(to: view)
                            },
                            onLogin: { email in
                                appState.login(email: email)
                            }
                        )
                    }
                }
            }
            .transition(.opacity)
            .animation(.easeInOut, value: appState.currentView)
        }
    }
}

// MARK: - Main App View (Authenticated)
struct MainAppView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedTab: String = "dashboard"
    
    var body: some View {
        VStack(spacing: 0) {
            // Header Navigation
            HeaderView()
                .environmentObject(appState)
            
            // Main Content
            ScrollView {
                Group {
                    switch selectedTab {
                    case "dashboard":
                        DashboardView(
                            onNavigate: { view in
                                appState.navigate(to: view)
                                selectedTab = view
                            }
                        )
                        
                    case "settings":
                        SettingsView(
                            onNavigate: { view in
                                appState.navigate(to: view)
                                selectedTab = view
                            },
                            userEmail: appState.userEmail,
                            userName: appState.userName
                        )
                        
                    default:
                        DashboardView(
                            onNavigate: { view in
                                appState.navigate(to: view)
                                selectedTab = view
                            }
                        )
                    }
                }
            }
            
            // Bottom Tab Bar (Mobile)
            if UIDevice.current.userInterfaceIdiom == .phone {
                BottomTabBar(selectedTab: $selectedTab)
                    .environmentObject(appState)
            }
        }
    }
}

// MARK: - Header View
struct HeaderView: View {
    @EnvironmentObject var appState: AppState
    @State private var showUserMenu: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                // Logo and Title
                Button(action: {
                    appState.navigate(to: "dashboard")
                }) {
                    HStack(spacing: Spacing.sm) {
                        ZStack {
                            RoundedRectangle(cornerRadius: CornerRadius.sm)
                                .fill(LinearGradient.primaryGradient)
                                .frame(width: 32, height: 32)
                                .logoShadow()
                            
                            Image(systemName: "star.fill")
                                .font(.system(size: 16))
                                .foregroundColor(.white)
                        }
                        
                        Text("Astronomy Study Coach")
                            .font(.appHeading)
                            .foregroundStyle(LinearGradient.textGradient)
                    }
                }
                
                Spacer()
                
                // Desktop Navigation (iPad/Mac)
                if UIDevice.current.userInterfaceIdiom != .phone {
                    HStack(spacing: Spacing.sm) {
                        NavButton(
                            title: "Dashboard",
                            icon: "house.fill",
                            isSelected: appState.currentView == "dashboard",
                            action: {
                                appState.navigate(to: "dashboard")
                            }
                        )
                        
                        NavButton(
                            title: "Settings",
                            icon: "gearshape.fill",
                            isSelected: appState.currentView == "settings",
                            action: {
                                appState.navigate(to: "settings")
                            }
                        )
                    }
                }
                
                // User Menu
                Menu {
                    Button(action: {
                        appState.navigate(to: "settings")
                    }) {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
                    
                    Divider()
                    
                    Button(role: .destructive, action: {
                        appState.logout()
                    }) {
                        Label("Log Out", systemImage: "arrow.right.square.fill")
                    }
                } label: {
                    HStack(spacing: Spacing.sm) {
                        // Avatar
                        ZStack {
                            Circle()
                                .fill(LinearGradient.primaryGradient)
                                .frame(width: 28, height: 28)
                            
                            Text(appState.userName.prefix(1).uppercased())
                                .font(.appSmall)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        
                        if UIDevice.current.userInterfaceIdiom != .phone {
                            Text(appState.userName)
                                .font(.appBody)
                                .foregroundColor(.foreground)
                        }
                        
                        Image(systemName: "chevron.down")
                            .font(.system(size: 12))
                            .foregroundColor(.mutedForeground)
                    }
                    .padding(.horizontal, Spacing.sm)
                    .padding(.vertical, Spacing.xs)
                    .background(Color.cardBackground)
                    .cornerRadius(CornerRadius.md)
                    .overlay(
                        RoundedRectangle(cornerRadius: CornerRadius.md)
                            .stroke(Color.border, lineWidth: 1)
                    )
                }
            }
            .padding(.horizontal, Spacing.lg)
            .padding(.vertical, Spacing.md)
            .background(
                Color.cardBackground
                    .opacity(0.95)
                    .background(.ultraThinMaterial)
            )
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.border),
                alignment: .bottom
            )
        }
    }
}

// MARK: - Navigation Button
struct NavButton: View {
    let title: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: Spacing.sm) {
                Image(systemName: icon)
                    .font(.system(size: 14))
                Text(title)
                    .font(.appBody)
            }
            .foregroundColor(isSelected ? .white : .mutedForeground)
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.sm)
            .background(isSelected ? LinearGradient.primaryGradient : Color.clear)
            .cornerRadius(CornerRadius.md)
        }
    }
}

// MARK: - Bottom Tab Bar (Mobile)
struct BottomTabBar: View {
    @Binding var selectedTab: String
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(
                icon: "house.fill",
                title: "Dashboard",
                isSelected: selectedTab == "dashboard",
                action: {
                    selectedTab = "dashboard"
                    appState.navigate(to: "dashboard")
                }
            )
            
            TabBarButton(
                icon: "gearshape.fill",
                title: "Settings",
                isSelected: selectedTab == "settings",
                action: {
                    selectedTab = "settings"
                    appState.navigate(to: "settings")
                }
            )
        }
        .padding(.horizontal, Spacing.md)
        .padding(.vertical, Spacing.sm)
        .background(
            Color.cardBackground
                .opacity(0.95)
                .background(.ultraThinMaterial)
        )
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.border),
            alignment: .top
        )
    }
}

// MARK: - Tab Bar Button
struct TabBarButton: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(isSelected ? .indigo400 : .mutedForeground)
                
                Text(title)
                    .font(.appSmall)
                    .foregroundColor(isSelected ? .indigo400 : .mutedForeground)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Spacing.sm)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}

