//
//  AppHeaderView.swift
//  Astronomy Study Coach
//
//  Reusable header component with logo, title, and hamburger menu
//

import SwiftUI

struct AppHeaderView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        HStack {
            // Logo and Title
            HStack(spacing: Spacing.sm) {
                AppLogo(size: 28)
                
                Text("AstroLearn")
                    .font(.appHeading)
                    .foregroundStyle(LinearGradient.textGradient)
            }
            
            Spacer()
            
            // Search Button
                       Button(action: {
                           appState.navigate(to: "search")
                       }) {
                           Image(systemName: "magnifyingglass")
                               .font(.system(size: 18, weight: .medium))
                               .foregroundColor(.foreground)
                               .padding(Spacing.sm)
                               .background(Color.cardBackground)
                               .cornerRadius(CornerRadius.md)
                               .overlay(
                                   RoundedRectangle(cornerRadius: CornerRadius.md)
                                       .stroke(Color.border, lineWidth: 1)
                               )
                       }
                       .padding(.trailing, Spacing.sm)
            
            // Hamburger Menu Dropdown
            Menu {
                Button(action: {
                    appState.navigate(to: "dashboard")
                }) {
                    Label("Dashboard", systemImage: "house.fill")
                }
                
                Button(action: {
                    Task { @MainActor in
                        appState.navigate(to: "study")
                    }
                }) {
                    Label("Study Topics", systemImage: "book.fill")
                }
                
                Button(action: {
                    Task { @MainActor in
                        appState.navigate(to: "quiz")
                    }
                }) {
                    Label("Quizzes", systemImage: "target")
                }
                
                Button(action: {
                    Task { @MainActor in
                        appState.navigate(to: "flashcards")
                    }
                }) {
                    Label("Flashcards", systemImage: "brain")
                }
                
                Button(action: {
                    Task { @MainActor in
                        appState.navigate(to: "constellations")
                    }
                }) {
                    Label("Constellations", systemImage: "star.fill")
                }
                
                Button(action: {
                    Task { @MainActor in
                        appState.navigate(to: "progress")
                    }
                }) {
                    Label("Progress", systemImage: "chart.line.uptrend.xyaxis")
                }
                
                Button(action: {
                    appState.navigate(to: "settings")
                }) {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                
                Button(action: {
                    Task { @MainActor in
                        appState.navigate(to: "resources")
                    }
                }) {
                    Label("Resources", systemImage: "link")
                }
                
                Button(action: {
                    Task { @MainActor in
                        appState.navigate(to: "glossary")
                    }
                }) {
                    Label("Glossary", systemImage: "book.closed.fill")
                }
                
                Button(action: {
                    Task { @MainActor in
                        appState.navigate(to: "ai-assistant")
                    }
                }) {
                    Label("AI Study Assistant", systemImage: "brain.head.profile")
                }
                
                Divider()
                
                Button(role: .destructive, action: {
                    appState.logout()
                }) {
                    Label("Log Out", systemImage: "arrow.right.square.fill")
                }
            } label: {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.foreground)
                    .padding(Spacing.sm)
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

#Preview {
    AppHeaderView()
        .environmentObject(AppState())
        .preferredColorScheme(.dark)
}


