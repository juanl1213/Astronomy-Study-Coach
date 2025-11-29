//
//  QuizView.swift
//  Astronomy Study Coach
//
//  Quiz home page matching the React application design
//

import SwiftUI

struct QuizView: View {
    @EnvironmentObject var appState: AppState
    var onNavigate: ((String) -> Void)?
    @State private var isQuizActive = false
    
    let quizzes = [
        QuizData(
            id: "solar-system",
            title: "Solar System Quiz",
            description: "Test your knowledge of our cosmic neighborhood",
            questions: 10,
            difficulty: "Beginner",
            timeEstimate: "10 min",
            category: "Solar System"
        ),
        QuizData(
            id: "planets",
            title: "Planets Quiz",
            description: "How well do you know the eight planets?",
            questions: 15,
            difficulty: "Beginner",
            timeEstimate: "12 min",
            category: "Planets"
        ),
        QuizData(
            id: "stars",
            title: "Stars & Stellar Evolution",
            description: "From protostars to black holes",
            questions: 12,
            difficulty: "Intermediate",
            timeEstimate: "15 min",
            category: "Stars"
        ),
        QuizData(
            id: "galaxies",
            title: "Galaxies Quiz",
            description: "Explore galactic structures and types",
            questions: 10,
            difficulty: "Intermediate",
            timeEstimate: "12 min",
            category: "Galaxies"
        ),
        QuizData(
            id: "general",
            title: "General Astronomy",
            description: "Mixed topics covering all astronomy",
            questions: 20,
            difficulty: "Advanced",
            timeEstimate: "20 min",
            category: "Mixed"
        )
    ]
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            if isQuizActive {
                QuizSessionView(
                    onNavigate: onNavigate,
                    isActive: $isQuizActive
                )
                .environmentObject(appState)
            } else {
                VStack(spacing: 0) {
                    // Header Navigation
                    headerSection
                    
                    ScrollView {
                        VStack(spacing: Spacing.lg) {
                            // Title Section
                            VStack(alignment: .leading, spacing: Spacing.sm) {
                                Text("Astronomy Quizzes")
                                    .font(.appTitle)
                                    .foregroundColor(.foreground)
                                
                                Text("Challenge yourself and track your progress across different astronomy topics.")
                                    .font(.appCaption)
                                    .foregroundColor(.mutedForeground)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            // Demo Quiz Button
                            demoQuizButton
                            
                            // Stats Cards
                            statsSection
                            
                            // Quiz Cards
                            quizCardsSection
                            
                            // Quick Access
                            quickAccessSection
                        }
                        .padding(Spacing.lg)
                    }
                }
            }
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        AppHeaderView()
    }
    
    // MARK: - Demo Quiz Button
    private var demoQuizButton: some View {
        Button(action: {
            isQuizActive = true
        }) {
            HStack {
                Image(systemName: "play.circle.fill")
                    .font(.system(size: 20, weight: .medium))
                Text("Try Demo Quiz (2 Questions)")
                    .font(.appBody)
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: "arrow.right")
                    .font(.system(size: 14, weight: .medium))
            }
            .foregroundColor(.white)
            .padding(Spacing.md)
            .background(LinearGradient.primaryGradient)
            .cornerRadius(CornerRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.md)
                    .stroke(Color.border, lineWidth: 1)
            )
        }
    }
    
    // MARK: - Stats Section
    private var statsSection: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(), spacing: Spacing.md),
            GridItem(.flexible(), spacing: Spacing.md),
            GridItem(.flexible(), spacing: Spacing.md)
        ], spacing: Spacing.md) {
            QuizStatCard(
                label: "Best Score",
                value: "85%",
                icon: "trophy.fill",
                color: Color.indigo600
            )
            
            QuizStatCard(
                label: "Quizzes Taken",
                value: "12",
                icon: "target",
                color: Color.cyan600
            )
            
            QuizStatCard(
                label: "Avg. Time",
                value: "14 min",
                icon: "clock.fill",
                color: Color.indigo600
            )
        }
    }
    
    // MARK: - Quiz Cards Section
    private var quizCardsSection: some View {
        LazyVGrid(columns: UIDevice.current.userInterfaceIdiom == .phone ? [
            GridItem(.flexible(), spacing: Spacing.lg)
        ] : [
            GridItem(.flexible(), spacing: Spacing.lg),
            GridItem(.flexible(), spacing: Spacing.lg)
        ], spacing: Spacing.lg) {
            ForEach(quizzes) { quiz in
                QuizCard(quiz: quiz, onStart: {
                    onNavigate?("quiz-\(quiz.id)")
                })
            }
        }
    }
    
    // MARK: - Quick Access Section
    private var quickAccessSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack(spacing: Spacing.sm) {
                Image(systemName: "clock.arrow.circlepath")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color.indigo600)
                Text("Quick Access")
                    .font(.appHeading)
                    .foregroundColor(.foreground)
            }
            
            VStack(spacing: Spacing.sm) {
                Button(action: {
                    Task { @MainActor in
                        appState.navigate(to: "quiz-history")
                    }
                }) {
                    HStack {
                        Image(systemName: "clock.arrow.circlepath")
                            .font(.system(size: 14, weight: .medium))
                        Text("View Quiz History")
                            .font(.appBody)
                        Spacer()
                    }
                    .foregroundColor(.foreground)
                    .padding(Spacing.md)
                    .background(Color.inputBackground)
                    .cornerRadius(CornerRadius.md)
                    .overlay(
                        RoundedRectangle(cornerRadius: CornerRadius.md)
                            .stroke(Color.border, lineWidth: 1)
                    )
                }
                
                Button(action: {
                    Task { @MainActor in
                        appState.navigate(to: "achievements")
                    }
                }) {
                    HStack {
                        Image(systemName: "trophy.fill")
                            .font(.system(size: 14, weight: .medium))
                        Text("View Achievements")
                            .font(.appBody)
                        Spacer()
                    }
                    .foregroundColor(.foreground)
                    .padding(Spacing.md)
                    .background(Color.inputBackground)
                    .cornerRadius(CornerRadius.md)
                    .overlay(
                        RoundedRectangle(cornerRadius: CornerRadius.md)
                            .stroke(Color.border, lineWidth: 1)
                    )
                }
            }
        }
        .padding(Spacing.lg)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.lg)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.lg)
                .stroke(Color.border, lineWidth: 1)
        )
    }
}

// MARK: - Supporting Views
struct QuizStatCard: View {
    let label: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: Spacing.sm) {
            ZStack {
                RoundedRectangle(cornerRadius: CornerRadius.sm)
                    .fill(color.opacity(0.1))
                    .frame(width: 40, height: 40)
                
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.system(size: 18, weight: .medium))
            }
            
            VStack(spacing: 4) {
                Text(label)
                    .font(.appSmall)
                    .foregroundColor(.mutedForeground)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.8)
                
                Text(value)
                    .font(.appHeading)
                    .fontWeight(.semibold)
                    .foregroundColor(.foreground)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(Spacing.md)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .stroke(Color.border, lineWidth: 1)
        )
    }
}

struct QuizCard: View {
    let quiz: QuizData
    let onStart: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text(quiz.title)
                        .font(.appHeading)
                        .foregroundColor(.foreground)
                    
                    Text(quiz.description)
                        .font(.appCaption)
                        .foregroundColor(.mutedForeground)
                }
                
                Spacer()
                
                BadgeView(difficulty: quiz.difficulty)
            }
            
            HStack(spacing: Spacing.md) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Questions")
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                    Text("\(quiz.questions)")
                        .font(.appBody)
                        .fontWeight(.medium)
                        .foregroundColor(.foreground)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Time")
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                    Text(quiz.timeEstimate)
                        .font(.appBody)
                        .fontWeight(.medium)
                        .foregroundColor(.foreground)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Category")
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                    Text(quiz.category)
                        .font(.appBody)
                        .fontWeight(.medium)
                        .foregroundColor(.foreground)
                }
                
                Spacer()
            }
            
            Button(action: onStart) {
                Text("Start Quiz")
                    .font(.appBody)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(Spacing.md)
                    .background(LinearGradient.primaryGradient)
                    .cornerRadius(CornerRadius.md)
            }
        }
        .padding(Spacing.lg)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.lg)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.lg)
                .stroke(Color.border, lineWidth: 1)
        )
    }
}

struct BadgeView: View {
    let difficulty: String
    
    var body: some View {
        Text(difficulty)
            .font(.appSmall)
            .fontWeight(.medium)
            .padding(.horizontal, Spacing.sm)
            .padding(.vertical, Spacing.xs)
            .background(difficultyBackground)
            .foregroundColor(difficultyForeground)
            .cornerRadius(CornerRadius.sm)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.sm)
                    .stroke(difficultyBorder, lineWidth: 1)
            )
    }
    
    private var difficultyBackground: Color {
        switch difficulty {
        case "Beginner": return Color.green.opacity(0.15)
        case "Intermediate": return Color.orange.opacity(0.15)
        case "Advanced": return Color.red.opacity(0.15)
        default: return Color.gray.opacity(0.15)
        }
    }
    
    private var difficultyForeground: Color {
        switch difficulty {
        case "Beginner": return Color.green
        case "Intermediate": return Color.orange
        case "Advanced": return Color.red
        default: return Color.gray
        }
    }
    
    private var difficultyBorder: Color {
        switch difficulty {
        case "Beginner": return Color.green.opacity(0.3)
        case "Intermediate": return Color.orange.opacity(0.3)
        case "Advanced": return Color.red.opacity(0.3)
        default: return Color.gray.opacity(0.3)
        }
    }
}

// MARK: - Data Models
struct QuizData: Identifiable {
    let id: String
    let title: String
    let description: String
    let questions: Int
    let difficulty: String
    let timeEstimate: String
    let category: String
}

#Preview {
    QuizView()
        .environmentObject(AppState())
}


