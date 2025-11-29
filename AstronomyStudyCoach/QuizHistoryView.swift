//
//  QuizHistoryView.swift
//  Astronomy Study Coach


import SwiftUI

struct QuizHistoryView: View {
    @EnvironmentObject var appState: AppState
    var onNavigate: ((String) -> Void)?
    
    let quizHistory = [
        QuizAttempt(
            id: 1,
            quiz: "General Astronomy",
            score: 85,
            totalQuestions: 20,
            date: "2025-10-01",
            time: "18 min",
            trend: .up
        ),
        QuizAttempt(
            id: 2,
            quiz: "Stars & Stellar Evolution",
            score: 75,
            totalQuestions: 12,
            date: "2025-09-28",
            time: "14 min",
            trend: .same
        ),
        QuizAttempt(
            id: 3,
            quiz: "Galaxies Quiz",
            score: 90,
            totalQuestions: 10,
            date: "2025-09-25",
            time: "11 min",
            trend: .up
        ),
        QuizAttempt(
            id: 4,
            quiz: "Planets Quiz",
            score: 80,
            totalQuestions: 15,
            date: "2025-09-22",
            time: "13 min",
            trend: .down
        ),
        QuizAttempt(
            id: 5,
            quiz: "Solar System Quiz",
            score: 95,
            totalQuestions: 10,
            date: "2025-09-20",
            time: "9 min",
            trend: .up
        ),
        QuizAttempt(
            id: 6,
            quiz: "General Astronomy",
            score: 70,
            totalQuestions: 20,
            date: "2025-09-18",
            time: "22 min",
            trend: .down
        ),
        QuizAttempt(
            id: 7,
            quiz: "Stars & Stellar Evolution",
            score: 75,
            totalQuestions: 12,
            date: "2025-09-15",
            time: "15 min",
            trend: .up
        ),
        QuizAttempt(
            id: 8,
            quiz: "Planets Quiz",
            score: 88,
            totalQuestions: 15,
            date: "2025-09-12",
            time: "12 min",
            trend: .up
        )
    ]
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header Navigation
                headerSection
                
                ScrollView {
                    VStack(spacing: Spacing.lg) {
                        // Title Section
                        titleSection
                        
                        // Stats Cards
                        statsSection
                        
                        // Recent Attempts
                        recentAttemptsSection
                        
                        // Performance by Topic
                        performanceByTopicSection
                    }
                    .padding(Spacing.lg)
                }
            }
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        AppHeaderView()
    }
    
    // MARK: - Title Section
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack {
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text("Quiz History")
                        .font(.appTitle)
                        .foregroundColor(.foreground)
                    
                    Text("Track your performance and improvement over time.")
                        .font(.appCaption)
                        .foregroundColor(.mutedForeground)
                }
                
                Spacer()
                
                Button(action: {
                    Task { @MainActor in
                        appState.navigate(to: "quiz")
                    }
                }) {
                    HStack(spacing: Spacing.xs) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 14, weight: .medium))
                        Text("Back to Quizzes")
                            .font(.appBody)
                    }
                    .foregroundColor(.foreground)
                    .padding(.horizontal, Spacing.md)
                    .padding(.vertical, Spacing.sm)
                    .background(Color.inputBackground)
                    .cornerRadius(CornerRadius.md)
                    .overlay(
                        RoundedRectangle(cornerRadius: CornerRadius.md)
                            .stroke(Color.border, lineWidth: 1)
                    )
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Stats Section
    private var statsSection: some View {
        let stats = calculateStats()
        
        return LazyVGrid(columns: UIDevice.current.userInterfaceIdiom == .phone ? [
            GridItem(.flexible(), spacing: Spacing.md)
        ] : [
            GridItem(.flexible(), spacing: Spacing.md),
            GridItem(.flexible(), spacing: Spacing.md),
            GridItem(.flexible(), spacing: Spacing.md)
        ], spacing: Spacing.md) {
            HistoryStatCard(
                label: "Total Quizzes",
                value: "\(stats.total)",
                color: .foreground
            )
            
            HistoryStatCard(
                label: "Average Score",
                value: "\(stats.avgScore)%",
                color: scoreColor(score: stats.avgScore)
            )
            
            HistoryStatCard(
                label: "Best Score",
                value: "\(stats.bestScore)%",
                color: scoreColor(score: stats.bestScore)
            )
        }
    }
    
    // MARK: - Recent Attempts Section
    private var recentAttemptsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Recent Attempts")
                .font(.appHeading)
                .foregroundColor(.foreground)
            
            VStack(spacing: Spacing.md) {
                ForEach(quizHistory) { attempt in
                    QuizAttemptRow(attempt: attempt)
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
    
    // MARK: - Performance by Topic Section
    private var performanceByTopicSection: some View {
        let topics = [
            TopicPerformance(topic: "Solar System", attempts: 3, avgScore: 92),
            TopicPerformance(topic: "Planets", attempts: 4, avgScore: 84),
            TopicPerformance(topic: "Stars", attempts: 5, avgScore: 75),
            TopicPerformance(topic: "Galaxies", attempts: 2, avgScore: 90),
            TopicPerformance(topic: "General Astronomy", attempts: 3, avgScore: 75)
        ]
        
        return VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Performance by Topic")
                .font(.appHeading)
                .foregroundColor(.foreground)
            
            VStack(spacing: Spacing.lg) {
                ForEach(topics) { topic in
                    TopicPerformanceRow(topic: topic)
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
    
    // MARK: - Helper Functions
    private func calculateStats() -> (total: Int, avgScore: Int, bestScore: Int) {
        let total = quizHistory.count
        let avgScore = Int(round(Double(quizHistory.reduce(0) { $0 + $1.score }) / Double(total)))
        let bestScore = quizHistory.map { $0.score }.max() ?? 0
        return (total, avgScore, bestScore)
    }
    
    private func scoreColor(score: Int) -> Color {
        if score >= 90 {
            return Color.green
        } else if score >= 70 {
            return Color.orange
        } else {
            return Color.red
        }
    }
}

// MARK: - Supporting Views
struct HistoryStatCard: View {
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: Spacing.xs) {
            Text(label)
                .font(.appCaption)
                .foregroundColor(.mutedForeground)
            
            Text(value)
                .font(.appTitle)
                .fontWeight(.semibold)
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity)
        .padding(Spacing.lg)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .stroke(Color.border, lineWidth: 1)
        )
    }
}

struct QuizAttemptRow: View {
    let attempt: QuizAttempt
    
    var body: some View {
        HStack(alignment: .center, spacing: Spacing.md) {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(attempt.quiz)
                    .font(.appBody)
                    .fontWeight(.medium)
                    .foregroundColor(.foreground)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                
                HStack(spacing: Spacing.xs) {
                    Text(attempt.date)
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                    
                    Text("•")
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                    
                    Text(attempt.time)
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                    
                    Text("•")
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                    
                    Text("\(attempt.totalQuestions) Q")
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                }
                .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: Spacing.md) {
                trendIcon(attempt.trend)
                
                scoreBadge(score: attempt.score, total: attempt.totalQuestions)
            }
        }
        .padding(Spacing.md)
        .background(Color.inputBackground)
        .cornerRadius(CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .stroke(Color.border, lineWidth: 1)
        )
    }
    
    private func trendIcon(_ trend: Trend) -> some View {
        Group {
            switch trend {
            case .up:
                Image(systemName: "arrow.up.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color.green)
            case .down:
                Image(systemName: "arrow.down.right")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color.red)
            case .same:
                Image(systemName: "minus")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.mutedForeground)
            }
        }
    }
    
    private func scoreBadge(score: Int, total: Int) -> some View {
        let correctAnswers = Int(round(Double(total) * Double(score) / 100.0))
        
        return Text("\(score)% (\(correctAnswers)/\(total))")
            .font(.appSmall)
            .fontWeight(.medium)
            .foregroundColor(scoreForeground(score: score))
            .padding(.horizontal, Spacing.sm)
            .padding(.vertical, Spacing.xs)
            .background(scoreBackground(score: score))
            .cornerRadius(CornerRadius.sm)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.sm)
                    .stroke(scoreBorder(score: score), lineWidth: 1)
            )
    }
    
    private func scoreForeground(score: Int) -> Color {
        if score >= 90 {
            return .white
        } else if score >= 70 {
            return .white
        } else {
            return .white
        }
    }
    
    private func scoreBackground(score: Int) -> Color {
        if score >= 90 {
            return Color.green.opacity(0.2)
        } else if score >= 70 {
            return Color.orange.opacity(0.2)
        } else {
            return Color.red.opacity(0.2)
        }
    }
    
    private func scoreBorder(score: Int) -> Color {
        if score >= 90 {
            return Color.green.opacity(0.3)
        } else if score >= 70 {
            return Color.orange.opacity(0.3)
        } else {
            return Color.red.opacity(0.3)
        }
    }
}

struct TopicPerformanceRow: View {
    let topic: TopicPerformance
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack {
                Text(topic.topic)
                    .font(.appBody)
                    .foregroundColor(.foreground)
                
                Spacer()
                
                HStack(spacing: Spacing.md) {
                    Text("\(topic.attempts) attempts")
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                    
                    Text("\(topic.avgScore)%")
                        .font(.appBody)
                        .fontWeight(.medium)
                        .foregroundColor(topicScoreColor(topic.avgScore))
                }
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: CornerRadius.sm)
                        .fill(Color.inputBackground)
                        .frame(height: 8)
                    
                    RoundedRectangle(cornerRadius: CornerRadius.sm)
                        .fill(LinearGradient.primaryGradient)
                        .frame(width: geometry.size.width * CGFloat(topic.avgScore) / 100.0, height: 8)
                }
            }
            .frame(height: 8)
        }
    }
    
    private func topicScoreColor(_ score: Int) -> Color {
        if score >= 90 {
            return Color.green
        } else if score >= 70 {
            return Color.orange
        } else {
            return Color.red
        }
    }
}

// MARK: - Data Models
struct QuizAttempt: Identifiable {
    let id: Int
    let quiz: String
    let score: Int
    let totalQuestions: Int
    let date: String
    let time: String
    let trend: Trend
}

enum Trend {
    case up
    case down
    case same
}

struct TopicPerformance: Identifiable {
    let id = UUID()
    let topic: String
    let attempts: Int
    let avgScore: Int
}

#Preview {
    QuizHistoryView()
        .environmentObject(AppState())
}


