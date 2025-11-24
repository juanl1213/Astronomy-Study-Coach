//
//  DashboardView.swift
//  Astronomy Study Coach


import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var appState: AppState
    var onNavigate: ((String) -> Void)?
    
    // Sample data
    @State private var studyProgress = [
        ("Solar System", 0.75),
        ("Stars & Stellar Evolution", 0.40),
        ("Galaxies", 0.20),
        ("Cosmology", 0.10)
    ]
    
    @State private var quickStats = [
        ("Total Study Time", "24h 32m", "book.fill"),
        ("Quizzes Completed", "18", "target"),
        ("Current Streak", "7 days", "flame.fill"),
        ("Topics Mastered", "3/8", "trophy.fill")
    ]
    
    @State private var recentAchievements = [
        ("Solar System Expert", "Completed all planet quizzes", "trophy.fill"),
        ("Star Gazer", "Learned 10 constellation patterns", "star.fill"),
        ("Quiz Master", "Scored 90% on 5 consecutive quizzes", "target")
    ]
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header Navigation
                AppHeaderView()
                
                ScrollView {
                    VStack(spacing: Spacing.lg) {
                        // Hero Section
                    ZStack(alignment: .leading) {
                        // Background Image Placeholder
                        RoundedRectangle(cornerRadius: CornerRadius.lg)
                            .fill(
                                LinearGradient(
                                    colors: [Color.indigo600.opacity(0.8), Color.cyan600.opacity(0.6)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(height: 180)
                        
                        // Gradient Overlay
                        LinearGradient(
                            colors: [
                                Color(red: 0.039, green: 0.055, blue: 0.102).opacity(0.95),
                                Color(red: 0.039, green: 0.055, blue: 0.102).opacity(0.8),
                                Color.clear
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .cornerRadius(CornerRadius.lg)
                        
                        // Content
                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            Text("Welcome Back, Astronomer!")
                                .font(.appHeading)
                                .foregroundColor(.white)
                            
                            Text("Continue your journey through the cosmos and expand your knowledge of the universe.")
                                .font(.appCaption)
                                .foregroundColor(.white.opacity(0.9))
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Button(action: {
                                onNavigate?("study")
                            }) {
                                HStack {
                                    Image(systemName: "book.fill")
                                        .font(.system(size: 14, weight: .semibold))
                                    Text("Continue Learning")
                                }
                                .font(.appCaption)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.horizontal, Spacing.md)
                                .padding(.vertical, Spacing.sm)
                                .background(Color.indigo600)
                                .cornerRadius(CornerRadius.md)
                            }
                            .padding(.top, Spacing.xs)
                        }
                        .padding(Spacing.lg)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: CornerRadius.lg)
                            .stroke(Color.border, lineWidth: 1)
                    )
                    .cardShadow()
                    
                    // Quick Stats
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: Spacing.md),
                        GridItem(.flexible(), spacing: Spacing.md)
                    ], spacing: Spacing.md) {
                        ForEach(Array(quickStats.enumerated()), id: \.offset) { index, stat in
                            StatCard(
                                label: stat.0,
                                value: stat.1,
                                icon: stat.2
                            )
                        }
                    }
                    
                    // Two Column Layout
                    VStack(alignment: .leading, spacing: Spacing.lg) {
                        if UIDevice.current.userInterfaceIdiom == .phone {
                            // Stack vertically on iPhone
                            studyProgressSection
                            recentAchievementsSection
                        } else {
                            // Side by side on iPad/Mac
                            HStack(alignment: .top, spacing: Spacing.lg) {
                                studyProgressSection
                                recentAchievementsSection
                            }
                        }
                    }
                    
                    // Quick Actions
                    quickActionsSection
                }
                .padding(Spacing.lg)
                }
            }
        }
    }
    
    // MARK: - Section Views
    private var studyProgressSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack(spacing: Spacing.sm) {
                ZStack {
                    RoundedRectangle(cornerRadius: CornerRadius.sm)
                        .fill(Color.indigo600.opacity(0.1))
                        .frame(width: 28, height: 28)
                    
                    Image(systemName: "telescope.fill")
                        .foregroundColor(.indigo600)
                        .font(.system(size: 14, weight: .medium))
                }
                
                Text("Study Progress")
                    .font(.appHeading)
                    .foregroundColor(.foreground)
            }
            
            Text("Track your learning journey across different astronomy topics")
                .font(.appCaption)
                .foregroundColor(.mutedForeground)
            
            VStack(spacing: Spacing.md) {
                ForEach(Array(studyProgress.enumerated()), id: \.offset) { index, progress in
                    ProgressRow(
                        title: progress.0,
                        progress: progress.1
                    )
                }
            }
            .padding(.top, Spacing.sm)
        }
        .padding(Spacing.lg)
        .frame(maxWidth: .infinity)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.lg)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.lg)
                .stroke(Color.border, lineWidth: 1)
        )
    }
    
    private var recentAchievementsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack(spacing: Spacing.sm) {
                ZStack {
                    RoundedRectangle(cornerRadius: CornerRadius.sm)
                        .fill(Color.cyan600.opacity(0.1))
                        .frame(width: 28, height: 28)
                    
                    Image(systemName: "trophy.fill")
                        .foregroundColor(.cyan600)
                        .font(.system(size: 14, weight: .medium))
                }
                
                Text("Recent Achievements")
                    .font(.appHeading)
                    .foregroundColor(.foreground)
            }
            
            VStack(spacing: Spacing.md) {
                ForEach(Array(recentAchievements.enumerated()), id: \.offset) { index, achievement in
                    AchievementRow(
                        title: achievement.0,
                        description: achievement.1,
                        icon: achievement.2
                    )
                }
            }
            .padding(.top, Spacing.sm)
            
            Button(action: {
                onNavigate?("achievements")
            }) {
                Text("View All Achievements")
                    .font(.appCaption)
                    .foregroundColor(.indigo400)
            }
            .padding(.top, Spacing.sm)
        }
        .padding(Spacing.lg)
        .frame(maxWidth: .infinity)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.lg)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.lg)
                .stroke(Color.border, lineWidth: 1)
        )
    }
    
    private var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Quick Actions")
                .font(.appHeading)
                .foregroundColor(.foreground)
            
            Text("Jump into your astronomy studies")
                .font(.appCaption)
                .foregroundColor(.mutedForeground)
            
            LazyVGrid(columns: UIDevice.current.userInterfaceIdiom == .phone ? [
                GridItem(.flexible(), spacing: Spacing.md)
            ] : [
                GridItem(.flexible(), spacing: Spacing.md),
                GridItem(.flexible(), spacing: Spacing.md),
                GridItem(.flexible(), spacing: Spacing.md)
            ], spacing: Spacing.md) {
                QuickActionButton(
                    icon: "target",
                    title: "Take a Quiz",
                    action: {
                        onNavigate?("quiz")
                    }
                )
                
                QuickActionButton(
                    icon: "book.fill",
                    title: "Study Flashcards",
                    action: {
                        onNavigate?("flashcards")
                    }
                )
                
                QuickActionButton(
                    icon: "star.fill",
                    title: "Explore Constellations",
                    action: {
                        onNavigate?("constellations")
                    }
                )
            }
            .padding(.top, Spacing.sm)
        }
        .padding(Spacing.lg)
        .frame(maxWidth: .infinity)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.lg)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.lg)
                .stroke(Color.border, lineWidth: 1)
        )
    }
}


// MARK: - Supporting Views
struct StatCard: View {
    let label: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack(spacing: Spacing.sm) {
            ZStack {
                RoundedRectangle(cornerRadius: CornerRadius.sm)
                    .fill(Color.indigo600.opacity(0.1))
                    .frame(width: 36, height: 36)
                
                Image(systemName: icon)
                    .foregroundColor(.indigo600)
                    .font(.system(size: 16, weight: .medium))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.appCaption)
                    .foregroundColor(.mutedForeground)
                
                Text(value)
                    .font(.appBody)
                    .fontWeight(.semibold)
                    .foregroundColor(.foreground)
            }
            
            Spacer()
        }
        .padding(Spacing.sm)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .stroke(Color.border, lineWidth: 1)
        )
    }
}

struct ProgressRow: View {
    let title: String
    let progress: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            HStack {
                Text(title)
                    .font(.appSmall)
                    .foregroundColor(.foreground)
                
                Spacer()
                
                Text("\(Int(progress * 100))%")
                    .font(.appSmall)
                    .foregroundColor(.mutedForeground)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.mutedBackground)
                        .frame(height: 8)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(LinearGradient.primaryGradient)
                        .frame(width: geometry.size.width * progress, height: 8)
                }
            }
            .frame(height: 8)
        }
    }
}

struct AchievementRow: View {
    let title: String
    let description: String
    let icon: String
    
    var body: some View {
        HStack(spacing: Spacing.sm) {
            ZStack {
                RoundedRectangle(cornerRadius: CornerRadius.sm)
                    .fill(Color.cyan600.opacity(0.1))
                    .frame(width: 36, height: 36)
                
                Image(systemName: icon)
                    .foregroundColor(.cyan600)
                    .font(.system(size: 16, weight: .medium))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.appCaption)
                    .fontWeight(.semibold)
                    .foregroundColor(.foreground)
                
                Text(description)
                    .font(.appSmall)
                    .foregroundColor(.mutedForeground)
            }
            
            Spacer()
        }
        .padding(Spacing.sm)
        .background(Color.mutedBackground.opacity(0.5))
        .cornerRadius(CornerRadius.md)
    }
}

struct QuickActionButton: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: Spacing.sm) {
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.indigo400)
                    .frame(height: 28)
                
                Text(title)
                    .font(.appCaption)
                    .fontWeight(.medium)
                    .foregroundColor(.foreground)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 90)
            .padding(Spacing.sm)
            .background(Color.inputBackground)
            .cornerRadius(CornerRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.md)
                    .stroke(Color.border, lineWidth: 1)
            )
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(AppState())
}


