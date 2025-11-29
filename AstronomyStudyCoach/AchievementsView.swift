//
//  AchievementsView.swift
//  Astronomy Study Coach


import SwiftUI

struct AchievementsView: View {
    @EnvironmentObject var appState: AppState
    var onNavigate: ((String) -> Void)?
    
    let achievements = [
        AchievementData(
            id: 1,
            title: "First Steps",
            description: "Complete your first quiz",
            icon: "star.fill",
            earned: true,
            earnedDate: "2025-09-15",
            points: 10,
            rarity: .common
        ),
        AchievementData(
            id: 2,
            title: "Perfect Score",
            description: "Score 100% on any quiz",
            icon: "trophy.fill",
            earned: false,
            earnedDate: nil,
            points: 50,
            rarity: .rare
        ),
        AchievementData(
            id: 3,
            title: "Quiz Master",
            description: "Complete all available quizzes",
            icon: "crown.fill",
            earned: false,
            earnedDate: nil,
            points: 100,
            rarity: .legendary
        ),
        AchievementData(
            id: 4,
            title: "Speed Demon",
            description: "Complete a quiz in under 5 minutes",
            icon: "bolt.fill",
            earned: true,
            earnedDate: "2025-09-20",
            points: 25,
            rarity: .uncommon
        ),
        AchievementData(
            id: 5,
            title: "Consistent Learner",
            description: "Study for 7 days in a row",
            icon: "flame.fill",
            earned: true,
            earnedDate: "2025-09-28",
            points: 30,
            rarity: .uncommon
        ),
        AchievementData(
            id: 6,
            title: "Flashcard Pro",
            description: "Review 100 flashcards",
            icon: "brain.head.profile",
            earned: false,
            earnedDate: nil,
            points: 40,
            rarity: .rare
        ),
        AchievementData(
            id: 7,
            title: "Constellation Explorer",
            description: "View all constellations",
            icon: "sparkles",
            earned: true,
            earnedDate: "2025-09-25",
            points: 20,
            rarity: .common
        ),
        AchievementData(
            id: 8,
            title: "Scholar",
            description: "Complete all lessons",
            icon: "book.fill",
            earned: false,
            earnedDate: nil,
            points: 75,
            rarity: .epic
        ),
        AchievementData(
            id: 9,
            title: "Sharp Shooter",
            description: "Answer 10 questions correctly in a row",
            icon: "target",
            earned: true,
            earnedDate: "2025-09-22",
            points: 35,
            rarity: .uncommon
        ),
        AchievementData(
            id: 10,
            title: "Knowledge Seeker",
            description: "Spend 10 hours studying",
            icon: "award.fill",
            earned: false,
            earnedDate: nil,
            points: 60,
            rarity: .epic
        ),
        AchievementData(
            id: 11,
            title: "Astronomy Expert",
            description: "Achieve 90%+ average across all quizzes",
            icon: "crown.fill",
            earned: false,
            earnedDate: nil,
            points: 150,
            rarity: .legendary
        ),
        AchievementData(
            id: 12,
            title: "Early Bird",
            description: "Complete a study session before 8 AM",
            icon: "star.fill",
            earned: false,
            earnedDate: nil,
            points: 15,
            rarity: .common
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
                        
                        // Achievements Grid
                        achievementsSection
                        
                        // Progress to Next Rank
                        rankProgressSection
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
        HStack {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text("Achievements")
                    .font(.appTitle)
                    .foregroundColor(.foreground)
                
                Text("Earn badges and track your learning milestones.")
                    .font(.appCaption)
                    .foregroundColor(.mutedForeground)
            }
            
            Spacer()
            
            Button(action: {
                Task { @MainActor in
                    appState.navigate(to: "progress")
                }
            }) {
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 14, weight: .medium))
                    Text("Back to Progress")
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
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Stats Section
    private var statsSection: some View {
        let earnedCount = achievements.filter { $0.earned }.count
        let totalCount = achievements.count
        let totalPoints = achievements.filter { $0.earned }.reduce(0) { $0 + $1.points }
        let completion = Int(round(Double(earnedCount) / Double(totalCount) * 100))
        
        return LazyVGrid(columns: UIDevice.current.userInterfaceIdiom == .phone ? [
            GridItem(.flexible(), spacing: Spacing.md)
        ] : [
            GridItem(.flexible(), spacing: Spacing.md),
            GridItem(.flexible(), spacing: Spacing.md),
            GridItem(.flexible(), spacing: Spacing.md),
            GridItem(.flexible(), spacing: Spacing.md)
        ], spacing: Spacing.md) {
            AchievementStatCard(
                icon: "trophy.fill",
                label: "Unlocked",
                value: "\(earnedCount) / \(totalCount)",
                iconColor: Color.indigo600
            )
            
            AchievementStatCard(
                icon: "star.fill",
                label: "Total Points",
                value: "\(totalPoints)",
                iconColor: Color.cyan600
            )
            
            AchievementStatCard(
                icon: "bolt.fill",
                label: "Completion",
                value: "\(completion)%",
                iconColor: Color.indigo600
            )
            
            AchievementStatCard(
                icon: "crown.fill",
                label: "Rank",
                value: "Explorer",
                iconColor: Color.cyan600
            )
        }
    }
    
    // MARK: - Achievements Section
    private var achievementsSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Your Achievements")
                .font(.appHeading)
                .foregroundColor(.foreground)
            
            LazyVGrid(columns: UIDevice.current.userInterfaceIdiom == .phone ? [
                GridItem(.flexible(), spacing: Spacing.md)
            ] : UIDevice.current.userInterfaceIdiom == .pad ? [
                GridItem(.flexible(), spacing: Spacing.md),
                GridItem(.flexible(), spacing: Spacing.md)
            ] : [
                GridItem(.flexible(), spacing: Spacing.md),
                GridItem(.flexible(), spacing: Spacing.md),
                GridItem(.flexible(), spacing: Spacing.md)
            ], spacing: Spacing.md) {
                ForEach(achievements) { achievement in
                    AchievementCard(achievement: achievement)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - Rank Progress Section
    private var rankProgressSection: some View {
        let totalPoints = achievements.filter { $0.earned }.reduce(0) { $0 + $1.points }
        let progress = min(Double(totalPoints) / 500.0, 1.0)
        
        return VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Progress to Next Rank")
                .font(.appHeading)
                .foregroundColor(.foreground)
            
            VStack(alignment: .leading, spacing: Spacing.md) {
                HStack {
                    Text("Explorer → Astronomer")
                        .font(.appBody)
                        .foregroundColor(.foreground)
                    Spacer()
                    Text("\(totalPoints) / 500 points")
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                }
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: CornerRadius.sm)
                            .fill(Color.inputBackground)
                            .frame(height: 12)
                        
                        RoundedRectangle(cornerRadius: CornerRadius.sm)
                            .fill(LinearGradient.primaryGradient)
                            .frame(width: geometry.size.width * progress, height: 12)
                    }
                }
                .frame(height: 12)
            }
            
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: Spacing.sm),
                GridItem(.flexible(), spacing: Spacing.sm),
                GridItem(.flexible(), spacing: Spacing.sm),
                GridItem(.flexible(), spacing: Spacing.sm)
            ], spacing: Spacing.sm) {
                RankCard(
                    title: "Novice",
                    range: "0-100 pts",
                    isCurrent: false
                )
                
                RankCard(
                    title: "Explorer",
                    range: "101-500 pts",
                    isCurrent: true
                )
                
                RankCard(
                    title: "Astronomer",
                    range: "501-1000 pts",
                    isCurrent: false
                )
                
                RankCard(
                    title: "Astrophysicist",
                    range: "1000+ pts",
                    isCurrent: false
                )
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

// MARK: - Achievement Stat Card
struct AchievementStatCard: View {
    let icon: String
    let label: String
    let value: String
    let iconColor: Color
    
    var body: some View {
        HStack(spacing: Spacing.md) {
            ZStack {
                RoundedRectangle(cornerRadius: CornerRadius.sm)
                    .fill(iconColor.opacity(0.1))
                    .frame(width: 48, height: 48)
                
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(iconColor)
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
        .padding(Spacing.lg)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .stroke(Color.border, lineWidth: 1)
        )
    }
}

// MARK: - Achievement Card
struct AchievementCard: View {
    let achievement: AchievementData
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack(alignment: .top, spacing: Spacing.md) {
                ZStack {
                    RoundedRectangle(cornerRadius: CornerRadius.sm)
                        .fill(achievement.earned ? Color.indigo600.opacity(0.1) : Color.inputBackground)
                        .frame(width: 48, height: 48)
                    
                    Image(systemName: achievement.icon)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(achievement.earned ? Color.indigo600 : .mutedForeground)
                }
                
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text(achievement.title)
                        .font(.appHeading)
                        .foregroundColor(.foreground)
                    
                    RarityBadge(rarity: achievement.rarity)
                }
            }
            
            Text(achievement.description)
                .font(.appCaption)
                .foregroundColor(.mutedForeground)
                .fixedSize(horizontal: false, vertical: true)
            
            HStack {
                Text("\(achievement.points) points")
                    .font(.appSmall)
                    .foregroundColor(.mutedForeground)
                
                Spacer()
                
                if achievement.earned, let date = achievement.earnedDate {
                    Text(formatDate(date))
                        .font(.appSmall)
                        .foregroundColor(Color.indigo600)
                } else {
                    Text("Locked")
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .stroke(achievement.earned ? Color.indigo600.opacity(0.5) : Color.border, lineWidth: 1)
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

// MARK: - Rarity Badge
struct RarityBadge: View {
    let rarity: AchievementRarity
    
    var body: some View {
        Text(rarity.rawValue.capitalized)
            .font(.appSmall)
            .fontWeight(.medium)
            .foregroundColor(rarityColor)
            .padding(.horizontal, Spacing.sm)
            .padding(.vertical, Spacing.xs)
            .background(rarityBackground)
            .cornerRadius(CornerRadius.sm)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.sm)
                    .stroke(rarityBorder, lineWidth: 1)
            )
    }
    
    private var rarityColor: Color {
        switch rarity {
        case .common: return Color.gray
        case .uncommon: return Color.green
        case .rare: return Color.blue
        case .epic: return Color.purple
        case .legendary: return Color.orange
        }
    }
    
    private var rarityBackground: Color {
        switch rarity {
        case .common: return Color.gray.opacity(0.15)
        case .uncommon: return Color.green.opacity(0.15)
        case .rare: return Color.blue.opacity(0.15)
        case .epic: return Color.purple.opacity(0.15)
        case .legendary: return Color.orange.opacity(0.15)
        }
    }
    
    private var rarityBorder: Color {
        switch rarity {
        case .common: return Color.gray.opacity(0.3)
        case .uncommon: return Color.green.opacity(0.3)
        case .rare: return Color.blue.opacity(0.3)
        case .epic: return Color.purple.opacity(0.3)
        case .legendary: return Color.orange.opacity(0.3)
        }
    }
}

// MARK: - Rank Card
struct RankCard: View {
    let title: String
    let range: String
    let isCurrent: Bool
    
    var body: some View {
        VStack(spacing: Spacing.xs) {
            Text(title)
                .font(.appSmall)
                .foregroundColor(.mutedForeground)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .multilineTextAlignment(.center)
            Text(range)
                .font(.appSmall)
                .fontWeight(.medium)
                .foregroundColor(.foreground)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(Spacing.md)
        .background(isCurrent ? Color.indigo600.opacity(0.1) : Color.inputBackground)
        .cornerRadius(CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .stroke(isCurrent ? Color.indigo600.opacity(0.5) : Color.border, lineWidth: isCurrent ? 2 : 1)
        )
    }
}

// MARK: - Data Models
struct AchievementData: Identifiable {
    let id: Int
    let title: String
    let description: String
    let icon: String
    let earned: Bool
    let earnedDate: String?
    let points: Int
    let rarity: AchievementRarity
}

enum AchievementRarity: String {
    case common = "common"
    case uncommon = "uncommon"
    case rare = "rare"
    case epic = "epic"
    case legendary = "legendary"
}

#Preview {
    AchievementsView()
        .environmentObject(AppState())
}


