//
//  ProgressView.swift
//  Astronomy Study Coach
//
//  Progress tracking view for learning journey
//

import SwiftUI

struct ProgressView: View {
    @EnvironmentObject var appState: AppState
    var onNavigate: ((String) -> Void)?
    
    @State private var selectedTab: ProgressTab = .progress
    
    enum ProgressTab {
        case progress
        case achievements
        case statistics
    }
    
    // Overall Progress Data - computed from ProgressManager
    private var overallProgress: OverallProgress {
        ProgressManager.shared.getOverallProgress(email: appState.userEmail)
    }
    
    // Topic Progress Data - computed from ProgressManager
    private var topicProgress: [TopicProgress] {
        ProgressManager.shared.getTopicProgress(email: appState.userEmail)
    }
    
    // Achievements Data
    let achievements: [AchievementItem] = [
        AchievementItem(id: 1, title: "Solar System Expert", description: "Completed all solar system lessons", icon: "trophy.fill", earned: true, date: "2025-01-15", rarity: .gold),
        AchievementItem(id: 2, title: "Quiz Master", description: "Scored 90%+ on 5 consecutive quizzes", icon: "target", earned: true, date: "2025-01-20", rarity: .silver),
        AchievementItem(id: 3, title: "Dedicated Learner", description: "Maintained a 7-day study streak", icon: "flame.fill", earned: true, date: "2025-01-22", rarity: .bronze),
        AchievementItem(id: 4, title: "Star Gazer", description: "Learned 10 constellation patterns", icon: "star.fill", earned: true, date: "2025-01-18", rarity: .bronze),
        AchievementItem(id: 5, title: "Time Traveler", description: "Study cosmology for 5 hours", icon: "clock.fill", earned: false, date: nil, rarity: .gold),
        AchievementItem(id: 6, title: "Stellar Scholar", description: "Complete all stellar evolution lessons", icon: "book.fill", earned: false, date: nil, rarity: .silver)
    ]
    
    // Study Stats Data
    let studyStats: [StudyStat] = [
        StudyStat(period: "This Week", studyTime: 320, lessonsCompleted: 8, quizzesCompleted: 3, averageScore: 88),
        StudyStat(period: "This Month", studyTime: 1472, lessonsCompleted: 24, quizzesCompleted: 12, averageScore: 85),
        StudyStat(period: "All Time", studyTime: 2940, lessonsCompleted: 42, quizzesCompleted: 18, averageScore: 87)
    ]
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                AppHeaderView()
                
                ScrollView {
                    VStack(spacing: Spacing.lg) {
                        // Title Section
                        VStack(spacing: Spacing.sm) {
                            Text("Learning Progress")
                                .font(.appTitle)
                                .foregroundColor(.foreground)
                            
                            Text("Track your astronomy learning journey and celebrate your achievements")
                                .font(.appCaption)
                                .foregroundColor(.mutedForeground)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, Spacing.md)
                        
                        // Overall Stats
                        overallStatsSection
                        
                        // Tabs
                        tabsSection
                    }
                    .padding(Spacing.lg)
                }
            }
        }
    }
    
    // MARK: - Overall Stats Section
    private var overallStatsSection: some View {
        LazyVGrid(columns: UIDevice.current.userInterfaceIdiom == .phone ? [
            GridItem(.flexible(), spacing: Spacing.md),
            GridItem(.flexible(), spacing: Spacing.md)
        ] : [
            GridItem(.flexible(), spacing: Spacing.md),
            GridItem(.flexible(), spacing: Spacing.md),
            GridItem(.flexible(), spacing: Spacing.md),
            GridItem(.flexible(), spacing: Spacing.md)
        ], spacing: Spacing.md) {
            OverallStatCard(
                icon: "book.fill",
                label: "Topics Completed",
                value: "\(overallProgress.completedTopics)/\(overallProgress.totalTopics)"
            )
            
            OverallStatCard(
                icon: "target",
                label: "Quizzes Passed",
                value: "\(overallProgress.completedQuizzes)/\(overallProgress.totalQuizzes)"
            )
            
            OverallStatCard(
                icon: "clock.fill",
                label: "Total Study Time",
                value: formatTime(overallProgress.studyTime)
            )
            
            OverallStatCard(
                icon: "flame.fill",
                label: "Current Streak",
                value: "\(overallProgress.currentStreak) days",
                iconColor: .orange
            )
        }
    }
    
    // MARK: - Tabs Section
    private var tabsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            // Tab Buttons
            HStack(spacing: 0) {
                ProgressTabButton(
                    title: "Topic Progress",
                    isSelected: selectedTab == .progress,
                    action: { selectedTab = .progress }
                )
                ProgressTabButton(
                    title: "Achievements",
                    isSelected: selectedTab == .achievements,
                    action: { selectedTab = .achievements }
                )
                ProgressTabButton(
                    title: "Statistics",
                    isSelected: selectedTab == .statistics,
                    action: { selectedTab = .statistics }
                )
            }
            .background(Color.cardBackground)
            .cornerRadius(CornerRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.md)
                    .stroke(Color.border, lineWidth: 1)
            )
            
            // Tab Content
            Group {
                switch selectedTab {
                case .progress:
                    topicProgressTab
                case .achievements:
                    achievementsTab
                case .statistics:
                    statisticsTab
                }
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
    
    // MARK: - Topic Progress Tab
    private var topicProgressTab: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .font(.system(size: 18))
                    .foregroundColor(.primary)
                Text("Learning Progress by Topic")
                    .font(.appHeading)
                    .foregroundColor(.foreground)
            }
            
            Text("Your advancement through each astronomy topic")
                .font(.appCaption)
                .foregroundColor(.mutedForeground)
            
            VStack(spacing: Spacing.lg) {
                ForEach(topicProgress, id: \.name) { topic in
                    TopicProgressRow(topic: topic)
                }
            }
            .padding(.top, Spacing.sm)
        }
    }
    
    // MARK: - Achievements Tab
    private var achievementsTab: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                Image(systemName: "trophy.fill")
                    .font(.system(size: 18))
                    .foregroundColor(.yellow)
                Text("Achievements & Badges")
                    .font(.appHeading)
                    .foregroundColor(.foreground)
            }
            
            Text("Milestones you've reached in your astronomy studies")
                .font(.appCaption)
                .foregroundColor(.mutedForeground)
            
            LazyVGrid(columns: UIDevice.current.userInterfaceIdiom == .phone ? [
                GridItem(.flexible(), spacing: Spacing.md)
            ] : [
                GridItem(.flexible(), spacing: Spacing.md),
                GridItem(.flexible(), spacing: Spacing.md)
            ], spacing: Spacing.md) {
                ForEach(achievements) { achievement in
                    ProgressAchievementCard(achievement: achievement)
                }
            }
            .padding(.top, Spacing.sm)
            
            // Achievement Progress
            VStack(alignment: .leading, spacing: Spacing.sm) {
                Text("Achievement Progress")
                    .font(.appBody)
                    .fontWeight(.semibold)
                    .foregroundColor(.foreground)
                
                HStack {
                    Text("Achievements Earned")
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                    Spacer()
                    Text("\(achievements.filter { $0.earned }.count)/\(achievements.count)")
                        .font(.appSmall)
                        .foregroundColor(.foreground)
                }
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.mutedBackground)
                            .frame(height: 8)
                        
                        RoundedRectangle(cornerRadius: 4)
                            .fill(LinearGradient.primaryGradient)
                            .frame(
                                width: geometry.size.width * CGFloat(achievements.filter { $0.earned }.count) / CGFloat(achievements.count),
                                height: 8
                            )
                    }
                }
                .frame(height: 8)
                
                Button(action: {
                    onNavigate?("achievements")
                }) {
                    HStack {
                        Text("View All Achievements")
                            .font(.appBody)
                            .fontWeight(.medium)
                        Spacer()
                        Image(systemName: "arrow.right")
                            .font(.system(size: 14))
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
                .padding(.top, Spacing.sm)
            }
            .padding(Spacing.md)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(CornerRadius.sm)
            .padding(.top, Spacing.md)
        }
    }
    
    // MARK: - Statistics Tab
    private var statisticsTab: some View {
        VStack(alignment: .leading, spacing: Spacing.lg) {
            // Study Stats Cards
            LazyVGrid(columns: UIDevice.current.userInterfaceIdiom == .phone ? [
                GridItem(.flexible(), spacing: Spacing.md)
            ] : [
                GridItem(.flexible(), spacing: Spacing.md),
                GridItem(.flexible(), spacing: Spacing.md),
                GridItem(.flexible(), spacing: Spacing.md)
            ], spacing: Spacing.md) {
                ForEach(studyStats, id: \.period) { stat in
                    StudyStatCard(stat: stat)
                }
            }
            
            // Study Streak Card
            VStack(alignment: .center, spacing: Spacing.md) {
                HStack {
                    Spacer()
                    Image(systemName: "calendar")
                        .font(.system(size: 18))
                        .foregroundColor(.primary)
                    Text("Study Streak")
                        .font(.appHeading)
                        .foregroundColor(.foreground)
                    Spacer()
                }
                
                if UIDevice.current.userInterfaceIdiom == .phone {
                    VStack(alignment: .center, spacing: Spacing.md) {
                        streakContent
                    }
                } else {
                    HStack(alignment: .top, spacing: Spacing.lg) {
                        streakContent
                    }
                }
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
    
    private var streakContent: some View {
        Group {
            VStack(alignment: .center, spacing: Spacing.md) {
                VStack(alignment: .center, spacing: Spacing.xs) {
                    Text("\(overallProgress.currentStreak)")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                    Text("Current Streak")
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                }
                
                VStack(alignment: .center, spacing: Spacing.xs) {
                    Text("\(overallProgress.longestStreak)")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.mutedForeground)
                    Text("Longest Streak")
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                }
            }
            
            VStack(alignment: .leading, spacing: Spacing.sm) {
                Text("Keep Your Streak Going!")
                    .font(.appBody)
                    .fontWeight(.semibold)
                    .foregroundColor(.foreground)
                
                VStack(alignment: .leading, spacing: 4) {
                    TipItem(text: "Study for at least 15 minutes daily")
                    TipItem(text: "Complete one lesson or take a quiz")
                    TipItem(text: "Review flashcards during breaks")
                    TipItem(text: "Set reminders to maintain consistency")
                }
            }
        }
    }
    
    // MARK: - Helper Functions
    private func formatTime(_ minutes: Int) -> String {
        let hours = minutes / 60
        let mins = minutes % 60
        return "\(hours)h \(mins)m"
    }
}

// MARK: - Data Models
// OverallProgress and TopicProgress are now defined in ProgressManager.swift

struct AchievementItem: Identifiable {
    let id: Int
    let title: String
    let description: String
    let icon: String
    let earned: Bool
    let date: String?
    let rarity: Rarity
    
    enum Rarity {
        case gold
        case silver
        case bronze
        
        var color: Color {
            switch self {
            case .gold: return .yellow
            case .silver: return .gray
            case .bronze: return .orange
            }
        }
        
        var displayName: String {
            switch self {
            case .gold: return "Gold"
            case .silver: return "Silver"
            case .bronze: return "Bronze"
            }
        }
    }
}

struct StudyStat {
    let period: String
    let studyTime: Int
    let lessonsCompleted: Int
    let quizzesCompleted: Int
    let averageScore: Int
}

// MARK: - Supporting Views
struct OverallStatCard: View {
    let icon: String
    let label: String
    let value: String
    var iconColor: Color = .primary
    
    var body: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundColor(iconColor)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.appSmall)
                    .foregroundColor(.mutedForeground)
                
                Text(value)
                    .font(.appBody)
                    .fontWeight(.medium)
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

struct TopicProgressRow: View {
    let topic: TopicProgress
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack {
                Text(topic.name)
                    .font(.appBody)
                    .fontWeight(.medium)
                    .foregroundColor(.foreground)
                
                Spacer()
                
                HStack(spacing: Spacing.sm) {
                    Text("\(topic.completed)/\(topic.lessons) lessons")
                        .font(.appSmall)
                        .padding(.horizontal, Spacing.xs)
                        .padding(.vertical, 4)
                        .background(Color.inputBackground)
                        .foregroundColor(.foreground)
                        .cornerRadius(CornerRadius.sm)
                        .overlay(
                            RoundedRectangle(cornerRadius: CornerRadius.sm)
                                .stroke(Color.border, lineWidth: 1)
                        )
                    
                    if topic.quiz > 0 {
                        Text("Quiz: \(topic.quiz)%")
                            .font(.appSmall)
                            .padding(.horizontal, Spacing.xs)
                            .padding(.vertical, 4)
                            .background(Color.primary.opacity(0.1))
                            .foregroundColor(.primary)
                            .cornerRadius(CornerRadius.sm)
                    }
                }
            }
            
            HStack(spacing: Spacing.sm) {
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.mutedBackground)
                            .frame(height: 8)
                        
                        RoundedRectangle(cornerRadius: 4)
                            .fill(LinearGradient.primaryGradient)
                            .frame(width: geometry.size.width * CGFloat(topic.progress) / 100, height: 8)
                    }
                }
                .frame(height: 8)
                
                Text("\(topic.progress)%")
                    .font(.appSmall)
                    .foregroundColor(.mutedForeground)
                    .frame(width: 40, alignment: .trailing)
            }
        }
    }
}

struct ProgressAchievementCard: View {
    let achievement: AchievementItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack(alignment: .top, spacing: Spacing.sm) {
                ZStack {
                    RoundedRectangle(cornerRadius: CornerRadius.sm)
                        .fill(achievement.earned ? Color.primary.opacity(0.1) : Color.mutedBackground)
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: achievement.icon)
                        .font(.system(size: 18))
                        .foregroundColor(achievement.earned ? .primary : .mutedForeground)
                }
                
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(achievement.title)
                                .font(.appBody)
                                .fontWeight(.medium)
                                .foregroundColor(.foreground)
                            
                            Text(achievement.description)
                                .font(.appSmall)
                                .foregroundColor(.mutedForeground)
                        }
                        
                        Spacer()
                        
                        Text(achievement.rarity.displayName)
                            .font(.appSmall)
                            .fontWeight(.medium)
                            .padding(.horizontal, Spacing.xs)
                            .padding(.vertical, 4)
                            .background(achievement.rarity.color.opacity(0.2))
                            .foregroundColor(achievement.rarity.color)
                            .cornerRadius(CornerRadius.sm)
                    }
                    
                    if achievement.earned, let date = achievement.date {
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 12))
                                .foregroundColor(.green)
                            Text("Earned on \(formatDate(date))")
                                .font(.appSmall)
                                .foregroundColor(.mutedForeground)
                        }
                    }
                }
            }
        }
        .padding(Spacing.md)
        .background(achievement.earned ? Color.cardBackground : Color.mutedBackground.opacity(0.5))
        .cornerRadius(CornerRadius.md)
        .overlay(
            Group {
                if achievement.earned {
                    RoundedRectangle(cornerRadius: CornerRadius.md)
                        .stroke(Color.border, lineWidth: 1)
                } else {
                    RoundedRectangle(cornerRadius: CornerRadius.md)
                        .stroke(Color.border.opacity(0.5), style: StrokeStyle(lineWidth: 1, dash: [5]))
                }
            }
        )
        .opacity(achievement.earned ? 1.0 : 0.6)
    }
    
    private func formatDate(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: dateString) {
            formatter.dateStyle = .medium
            return formatter.string(from: date)
        }
        return dateString
    }
}

struct StudyStatCard: View {
    let stat: StudyStat
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text(stat.period)
                .font(.appHeading)
                .foregroundColor(.foreground)
            
            VStack(alignment: .leading, spacing: Spacing.sm) {
                StatRow(label: "Study Time", value: formatTime(stat.studyTime))
                StatRow(label: "Lessons", value: "\(stat.lessonsCompleted)")
                StatRow(label: "Quizzes", value: "\(stat.quizzesCompleted)")
                StatRow(label: "Avg. Score", value: "\(stat.averageScore)%")
            }
        }
        .padding(Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .stroke(Color.border, lineWidth: 1)
        )
    }
    
    private func formatTime(_ minutes: Int) -> String {
        let hours = minutes / 60
        let mins = minutes % 60
        return "\(hours)h \(mins)m"
    }
}

struct StatRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.appSmall)
                .foregroundColor(.mutedForeground)
            Spacer()
            Text(value)
                .font(.appSmall)
                .fontWeight(.medium)
                .foregroundColor(.foreground)
        }
    }
}

struct ProgressTabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.appBody)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .foreground : .mutedForeground)
                .frame(maxWidth: .infinity)
                .padding(.vertical, Spacing.sm)
                .background(isSelected ? Color.inputBackground : Color.clear)
        }
    }
}

#Preview {
    ProgressView()
        .environmentObject(AppState())
}


