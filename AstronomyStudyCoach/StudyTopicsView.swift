//
//  StudyTopicsView.swift
//  Astronomy Study Coach

import SwiftUI

struct StudyTopicsView: View {
    @EnvironmentObject var appState: AppState
    var onNavigate: ((String) -> Void)?
    
    let topics = [
        TopicData(
            id: "solar-system",
            title: "Solar System",
            description: "Explore planets, moons, and other celestial bodies in our solar system",
            icon: "globe",
            difficulty: "Beginner",
            progress: 100,
            lessons: 1,
            completedLessons: 1,
            estimatedTime: "15 min",
            imageName: "globe"
        ),
        TopicData(
            id: "planets",
            title: "Planets in Detail",
            description: "Deep dive into the characteristics of each planet",
            icon: "globe",
            difficulty: "Beginner",
            progress: 100,
            lessons: 1,
            completedLessons: 1,
            estimatedTime: "20 min",
            imageName: "globe"
        ),
        TopicData(
            id: "stars",
            title: "Stars & Stellar Evolution",
            description: "Learn about star formation, life cycles, and stellar classifications",
            icon: "star.fill",
            difficulty: "Intermediate",
            progress: 100,
            lessons: 1,
            completedLessons: 1,
            estimatedTime: "20 min",
            imageName: "star.fill"
        ),
        TopicData(
            id: "galaxies",
            title: "Galaxies",
            description: "Discover different types of galaxies and cosmic structures",
            icon: "circle.grid.2x2.fill",
            difficulty: "Intermediate",
            progress: 100,
            lessons: 1,
            completedLessons: 1,
            estimatedTime: "18 min",
            imageName: "circle.grid.2x2.fill"
        ),
        TopicData(
            id: "cosmology",
            title: "Cosmology & The Universe",
            description: "Understand the origin and evolution of the universe",
            icon: "bolt.fill",
            difficulty: "Advanced",
            progress: 100,
            lessons: 1,
            completedLessons: 1,
            estimatedTime: "22 min",
            imageName: "bolt.fill"
        ),
        TopicData(
            id: "exoplanets",
            title: "Exoplanets",
            description: "Discover planets beyond our Solar System",
            icon: "globe",
            difficulty: "Intermediate",
            progress: 100,
            lessons: 1,
            completedLessons: 1,
            estimatedTime: "18 min",
            imageName: "globe"
        ),
        TopicData(
            id: "black-holes",
            title: "Black Holes",
            description: "Explore the most extreme objects in the universe",
            icon: "bolt.fill",
            difficulty: "Advanced",
            progress: 100,
            lessons: 1,
            completedLessons: 1,
            estimatedTime: "20 min",
            imageName: "bolt.fill"
        ),
        TopicData(
            id: "nebulae",
            title: "Nebulae",
            description: "Beautiful clouds of gas and dust where stars are born",
            icon: "star.fill",
            difficulty: "Beginner",
            progress: 100,
            lessons: 1,
            completedLessons: 1,
            estimatedTime: "16 min",
            imageName: "star.fill"
        ),
        TopicData(
            id: "asteroids",
            title: "Asteroids & Comets",
            description: "Rocky and icy remnants from the Solar System's formation",
            icon: "globe",
            difficulty: "Beginner",
            progress: 100,
            lessons: 1,
            completedLessons: 1,
            estimatedTime: "18 min",
            imageName: "globe"
        ),
        TopicData(
            id: "space-exploration",
            title: "Space Exploration",
            description: "Journey through humanity's ventures beyond Earth",
            icon: "airplane",
            difficulty: "Beginner",
            progress: 100,
            lessons: 1,
            completedLessons: 1,
            estimatedTime: "20 min",
            imageName: "airplane"
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
                        
                        // Topics Grid
                        topicsGrid
                        
                        // Learning Path Recommendations
                        learningPathSection
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
        VStack(spacing: Spacing.sm) {
            Text("Study Topics")
                .font(.appTitle)
                .foregroundColor(.foreground)
            
            Text("Choose a topic to begin your astronomical journey through the cosmos")
                .font(.appCaption)
                .foregroundColor(.mutedForeground)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: - Topics Grid
    private var topicsGrid: some View {
        LazyVGrid(columns: UIDevice.current.userInterfaceIdiom == .phone ? [
            GridItem(.flexible(), spacing: Spacing.lg)
        ] : UIDevice.current.userInterfaceIdiom == .pad ? [
            GridItem(.flexible(), spacing: Spacing.lg),
            GridItem(.flexible(), spacing: Spacing.lg)
        ] : [
            GridItem(.flexible(), spacing: Spacing.lg),
            GridItem(.flexible(), spacing: Spacing.lg),
            GridItem(.flexible(), spacing: Spacing.lg)
        ], spacing: Spacing.lg) {
            ForEach(topics) { topic in
                TopicCard(topic: topic, onNavigate: onNavigate)
                    .environmentObject(appState)
            }
        }
    }
    
    // MARK: - Learning Path Section
    private var learningPathSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack(spacing: Spacing.sm) {
                Image(systemName: "sun.max.fill")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.foreground)
                Text("Learning Path Recommendations")
                    .font(.appHeading)
                    .foregroundColor(.foreground)
            }
            
            Text("Suggested order for optimal learning experience")
                .font(.appCaption)
                .foregroundColor(.mutedForeground)
            
            VStack(alignment: .leading, spacing: Spacing.md) {
                LearningPathItem(
                    number: 1,
                    text: "Start with **Solar System** to build foundation knowledge"
                )
                
                LearningPathItem(
                    number: 2,
                    text: "Learn about **Telescopes & Observation** for practical skills"
                )
                
                LearningPathItem(
                    number: 3,
                    text: "Explore **Stars & Stellar Evolution** to understand stellar physics"
                )
                
                LearningPathItem(
                    number: 4,
                    text: "Study **Galaxies & Nebulae** for large-scale structures"
                )
                
                LearningPathItem(
                    number: 5,
                    text: "Conclude with **Cosmology** for the complete picture"
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

// MARK: - Topic Card
struct TopicCard: View {
    @EnvironmentObject var appState: AppState
    let topic: TopicData
    var onNavigate: ((String) -> Void)?
    
    var body: some View {
        VStack(spacing: 0) {
            imageSection
            contentSection
        }
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.lg)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.lg)
                .stroke(Color.border, lineWidth: 1)
        )
    }
    
    // MARK: - Content Section
    private var contentSection: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            titleSection
            descriptionText
            progressSection
            statsSection
            actionButtons
        }
        .padding(Spacing.md)
    }
    
    private var titleSection: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: topic.icon)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.foreground)
            Text(topic.title)
                .font(.appHeading)
                .foregroundColor(.foreground)
        }
    }
    
    private var descriptionText: some View {
        Text(topic.description)
            .font(.appCaption)
            .foregroundColor(.mutedForeground)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    private var progressSection: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            HStack {
                Text("Progress")
                    .font(.appSmall)
                    .foregroundColor(.mutedForeground)
                Spacer()
                Text("\(topic.progress)%")
                    .font(.appSmall)
                    .foregroundColor(.mutedForeground)
            }
            progressBar
        }
    }
    
    private var progressBar: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: CornerRadius.sm)
                    .fill(Color.inputBackground)
                    .frame(height: 8)
                
                RoundedRectangle(cornerRadius: CornerRadius.sm)
                    .fill(LinearGradient.primaryGradient)
                    .frame(width: geometry.size.width * CGFloat(topic.progress) / 100.0, height: 8)
            }
        }
        .frame(height: 8)
    }
    
    private var statsSection: some View {
        HStack(spacing: Spacing.lg) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Lessons")
                    .font(.appSmall)
                    .foregroundColor(.mutedForeground)
                Text("\(topic.completedLessons)/\(topic.lessons)")
                    .font(.appBody)
                    .fontWeight(.medium)
                    .foregroundColor(.foreground)
            }
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Est. Time")
                    .font(.appSmall)
                    .foregroundColor(.mutedForeground)
                Text(topic.estimatedTime)
                    .font(.appBody)
                    .fontWeight(.medium)
                    .foregroundColor(.foreground)
            }
            
            Spacer()
        }
    }
    
    private var actionButtons: some View {
        HStack(spacing: Spacing.sm) {
            startLearningButton
            quizButton
        }
    }
    
    private var startLearningButton: some View {
        Button(action: {
            onNavigate?("lesson-\(topic.id)")
        }) {
            Text(topic.progress > 0 ? "Review" : "Start Learning")
                .font(.appBody)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(Spacing.md)
                .background(buttonBackground)
                .cornerRadius(CornerRadius.md)
                .overlay(
                    RoundedRectangle(cornerRadius: CornerRadius.md)
                        .stroke(buttonBorder, lineWidth: 1)
                )
        }
    }
    
    private var quizButton: some View {
        Button(action: {
            Task { @MainActor in
                appState.navigate(to: "quiz")
            }
        }) {
            Text("Quiz")
                .font(.appBody)
                .fontWeight(.semibold)
                .foregroundColor(.foreground)
                .padding(.horizontal, Spacing.md)
                .padding(.vertical, Spacing.md)
                .background(Color.inputBackground)
                .cornerRadius(CornerRadius.md)
                .overlay(
                    RoundedRectangle(cornerRadius: CornerRadius.md)
                        .stroke(Color.border, lineWidth: 1)
                )
        }
    }
    
    private var buttonBackground: AnyShapeStyle {
        if topic.progress > 0 {
            return AnyShapeStyle(LinearGradient.primaryGradient)
        } else {
            return AnyShapeStyle(Color.inputBackground)
        }
    }
    
    private var buttonBorder: Color {
        topic.progress > 0 ? Color.clear : Color.border
    }
    
    // MARK: - Image Section
    private var imageSection: some View {
        ZStack(alignment: .topTrailing) {
            backgroundGradientSection
            
            overlayGradient
            
            DifficultyBadge(difficulty: topic.difficulty)
                .padding(Spacing.md)
        }
    }
    
    private var backgroundGradientSection: some View {
        ZStack {
            if topic.id == "solar-system" {
                Image("SolarSystem")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if topic.id == "planets" {
                Image("Planets")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if topic.id == "stars" {
                Image("starevolution")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if topic.id == "galaxies" {
                Image("galaxy")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }else if topic.id == "exoplanets" {
                Image("exoplanets")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if topic.id == "cosmology" {
                Image("cosmology")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if topic.id == "black-holes" {
                Image("blackhole")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if topic.id == "nebulae" {
                Image("nebula")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if topic.id == "asteroids" {
                Image("asteroid")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else if topic.id == "space-exploration" {
                Image("spaceexploration")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            else {
                LinearGradient(
                    colors: [
                        Color.indigo600.opacity(0.6),
                        Color.cyan600.opacity(0.4)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                Image(systemName: topic.imageName)
                    .font(.system(size: 60, weight: .light))
                    .foregroundColor(.white.opacity(0.3))
            }
        }
        .frame(height: 160)
        .clipped()
    }
    
    private var overlayGradient: some View {
        LinearGradient(
            colors: [
                Color.clear,
                Color.black.opacity(0.6)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

// MARK: - Difficulty Badge
struct DifficultyBadge: View {
    let difficulty: String
    
    var body: some View {
        Text(difficulty)
            .font(.appSmall)
            .fontWeight(.medium)
            .foregroundColor(difficultyForeground)
            .padding(.horizontal, Spacing.sm)
            .padding(.vertical, Spacing.xs)
            .background(difficultyBackground)
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

// MARK: - Learning Path Item
struct LearningPathItem: View {
    let number: Int
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: Spacing.md) {
            ZStack {
                Circle()
                    .fill(LinearGradient.primaryGradient)
                    .frame(width: 24, height: 24)
                
                Text("\(number)")
                    .font(.appSmall)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            
            parseMarkdown(text)
                .font(.appBody)
                .foregroundColor(.foreground)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    private func parseMarkdown(_ text: String) -> Text {
        let parts = text.components(separatedBy: "**")
        var result = Text("")
        
        for (index, part) in parts.enumerated() {
            if index % 2 == 0 {
                result = result + Text(part)
            } else {
                result = result + Text(part).fontWeight(.semibold)
            }
        }
        
        return result
    }
}

// MARK: - Data Models
struct TopicData: Identifiable {
    let id: String
    let title: String
    let description: String
    let icon: String
    let difficulty: String
    let progress: Int
    let lessons: Int
    let completedLessons: Int
    let estimatedTime: String
    let imageName: String
}

#Preview {
    StudyTopicsView()
        .environmentObject(AppState())
}


