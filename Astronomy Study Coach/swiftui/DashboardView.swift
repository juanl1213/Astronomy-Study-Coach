//
//  DashboardView.swift
//  Astronomy Study Coach
//
//  Dashboard screen matching the React application design
//

import SwiftUI

struct DashboardView: View {
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
                            .frame(height: 200)
                        
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
                        VStack(alignment: .leading, spacing: Spacing.md) {
                            Text("Welcome Back, Astronomer!")
                                .font(.appTitle)
                                .foregroundColor(.white)
                            
                            Text("Continue your journey through the cosmos and expand your knowledge of the universe.")
                                .font(.appBody)
                                .foregroundColor(.white.opacity(0.9))
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Button(action: {
                                onNavigate?("study")
                            }) {
                                HStack {
                                    Image(systemName: "book.fill")
                                    Text("Continue Learning")
                                }
                                .font(.appBody)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.horizontal, Spacing.lg)
                                .padding(.vertical, Spacing.md)
                                .background(Color.indigo600)
                                .cornerRadius(CornerRadius.md)
                            }
                            .padding(.top, Spacing.sm)
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
                    HStack(alignment: .top, spacing: Spacing.lg) {
                        // Study Progress
                        VStack(alignment: .leading, spacing: Spacing.md) {
                            HStack(spacing: Spacing.sm) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: CornerRadius.sm)
                                        .fill(Color.indigo600.opacity(0.1))
                                        .frame(width: 32, height: 32)
                                    
                                    Image(systemName: "telescope.fill")
                                        .foregroundColor(.indigo600)
                                        .font(.system(size: 16))
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
                        
                        // Recent Achievements
                        VStack(alignment: .leading, spacing: Spacing.md) {
                            HStack(spacing: Spacing.sm) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: CornerRadius.sm)
                                        .fill(Color.cyan600.opacity(0.1))
                                        .frame(width: 32, height: 32)
                                    
                                    Image(systemName: "trophy.fill")
                                        .foregroundColor(.cyan600)
                                        .font(.system(size: 16))
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
                                    .font(.appSmall)
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
                }
                .padding(Spacing.lg)
            }
        }
    }
}

// MARK: - Supporting Views
struct StatCard: View {
    let label: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack(spacing: Spacing.md) {
            ZStack {
                RoundedRectangle(cornerRadius: CornerRadius.sm)
                    .fill(Color.indigo600.opacity(0.1))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .foregroundColor(.indigo600)
                    .font(.system(size: 18))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.appSmall)
                    .foregroundColor(.mutedForeground)
                
                Text(value)
                    .font(.appBody)
                    .fontWeight(.semibold)
                    .foregroundColor(.foreground)
            }
            
            Spacer()
        }
        .padding(Spacing.md)
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
        HStack(spacing: Spacing.md) {
            ZStack {
                RoundedRectangle(cornerRadius: CornerRadius.sm)
                    .fill(Color.cyan600.opacity(0.1))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .foregroundColor(.cyan600)
                    .font(.system(size: 18))
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.appBody)
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

#Preview {
    DashboardView()
}

