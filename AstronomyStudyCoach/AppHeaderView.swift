//
//  AppHeaderView.swift
//  AstronomyStudyCoach
//
//  Created by user on 11/19/25.
//



import SwiftUI

struct AppHeaderView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        HStack {
            // Logo and Title
            HStack(spacing: Spacing.sm) {
                ZStack {
                    RoundedRectangle(cornerRadius: CornerRadius.sm)
                        .fill(LinearGradient.primaryGradient)
                        .frame(width: 28, height: 28)
                        .logoShadow()
                    
                    Image(systemName: "star.fill")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                }
                
                Text("Astronomy Study Coach")
                    .font(.appHeading)
                    .foregroundStyle(LinearGradient.textGradient)
            }
            
            Spacer()
            
            // Hamburger Menu Dropdown
            Menu {
                Button(action: {
                    appState.navigate(to: "dashboard")
                }) {
                    Label("Dashboard", systemImage: "house.fill")
                }
                
                // Study Topics - not implemented yet
                Button(action: {
                    // Navigate to study topics when implemented
                }) {
                    Label("Study Topics", systemImage: "book.fill")
                }
                .disabled(true)
                
                Button(action: {
                    Task { @MainActor in
                        appState.navigate(to: "quiz")
                    }
                }) {
                    Label("Quizzes", systemImage: "target")
                }
                
                // Flashcards - not implemented yet
                Button(action: {
                    // Navigate to flashcards when implemented
                }) {
                    Label("Flashcards", systemImage: "brain")
                }
                .disabled(true)
                
                // Constellations - not implemented yet
                Button(action: {
                    // Navigate to constellations when implemented
                }) {
                    Label("Constellations", systemImage: "star.fill")
                }
                .disabled(true)
                
                // Progress - not implemented yet
                Button(action: {
                    // Navigate to progress when implemented
                }) {
                    Label("Progress", systemImage: "chart.line.uptrend.xyaxis")
                }
                .disabled(true)
                
                Button(action: {
                    appState.navigate(to: "settings")
                }) {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                
                // Resources - not implemented yet
                Button(action: {
                    // Navigate to resources when implemented
                }) {
                    Label("Resources", systemImage: "link")
                }
                .disabled(true)
                
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


