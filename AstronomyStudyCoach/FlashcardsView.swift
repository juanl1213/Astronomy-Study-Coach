//
//  FlashcardsView.swift
//  Astronomy Study Coach
//
//  Flashcards page for studying astronomy concepts
//

import SwiftUI

struct FlashcardsView: View {
    let onNavigate: (String) -> Void
    @EnvironmentObject var appState: AppState
    
    @State private var currentCard = 0
    @State private var isFlipped = false
    @State private var knownCards: Set<Int> = []
    @State private var difficultCards: Set<Int> = []
    @State private var studyMode: StudyMode = .all
    
    enum StudyMode {
        case all
        case difficult
    }
    
    private let allFlashcards: [Flashcard] = [
        Flashcard(
            id: 1,
            front: "What is a light-year?",
            back: "A light-year is the distance that light travels in one year in a vacuum, approximately 9.46 trillion kilometers (5.88 trillion miles). It's used to measure vast distances in space.",
            topic: "Basic Concepts",
            difficulty: .easy
        ),
        Flashcard(
            id: 2,
            front: "What causes the phases of the Moon?",
            back: "Moon phases are caused by the changing positions of the Moon relative to Earth and the Sun. As the Moon orbits Earth, different portions of its sunlit surface are visible from Earth.",
            topic: "Solar System",
            difficulty: .easy
        ),
        Flashcard(
            id: 3,
            front: "What is a supernova?",
            back: "A supernova is the explosive death of a massive star (at least 8 times the mass of our Sun). It occurs when the star's core collapses and then rebounds, creating an extremely bright explosion that can outshine an entire galaxy.",
            topic: "Stellar Evolution",
            difficulty: .medium
        ),
        Flashcard(
            id: 4,
            front: "What is dark matter?",
            back: "Dark matter is a form of matter that makes up approximately 27% of the universe. It doesn't emit, absorb, or reflect light, making it invisible to direct observation. Its presence is inferred through its gravitational effects on visible matter.",
            topic: "Cosmology",
            difficulty: .hard
        ),
        Flashcard(
            id: 5,
            front: "What is the difference between a planet and a dwarf planet?",
            back: "A planet must: 1) orbit the Sun, 2) have enough mass to be roughly round, and 3) have cleared its orbital neighborhood of other objects. A dwarf planet meets the first two criteria but has not cleared its orbital neighborhood.",
            topic: "Solar System",
            difficulty: .medium
        ),
        Flashcard(
            id: 6,
            front: "What is redshift?",
            back: "Redshift is the phenomenon where light from distant objects appears shifted toward longer (redder) wavelengths. It's caused by the expansion of the universe and is key evidence for the Big Bang theory.",
            topic: "Cosmology",
            difficulty: .hard
        ),
        Flashcard(
            id: 7,
            front: "What is the main sequence of stellar evolution?",
            back: "The main sequence is the longest phase of a star's life, where it fuses hydrogen into helium in its core. Stars spend about 90% of their lifetime in this stable phase, including our Sun.",
            topic: "Stellar Evolution",
            difficulty: .medium
        ),
        Flashcard(
            id: 8,
            front: "What is the Goldilocks Zone?",
            back: "The Goldilocks Zone (or habitable zone) is the region around a star where conditions are 'just right' for liquid water to exist on a planet's surface - not too hot and not too cold.",
            topic: "Exoplanets",
            difficulty: .easy
        )
    ]
    
    private var displayCards: [Flashcard] {
        studyMode == .difficult
            ? allFlashcards.filter { difficultCards.contains($0.id) }
            : allFlashcards
    }
    
    private var currentFlashcard: Flashcard? {
        guard currentCard < displayCards.count else { return nil }
        return displayCards[currentCard]
    }
    
    private var progress: Double {
        guard !displayCards.isEmpty else { return 0 }
        return Double(currentCard + 1) / Double(displayCards.count) * 100
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                // Header
                AppHeaderView()
                    .environmentObject(appState)
                
                // Content
                VStack(spacing: Spacing.lg) {
                    if displayCards.isEmpty {
                        emptyStateView
                    } else if let card = currentFlashcard {
                        // Control Card
                        controlCard
                        
                        // Flashcard
                        flashcardView(card: card)
                        
                        // Navigation and Actions
                        navigationAndActionsView
                        
                        // Study Tips
                        studyTipsView
                    }
                }
                .padding(.horizontal, Spacing.lg)
            }
        }
        .background(Color.background)
        .onChange(of: studyMode) { _ in
            currentCard = 0
            isFlipped = false
        }
    }
    
    // MARK: - Empty State
    private var emptyStateView: some View {
        VStack(spacing: Spacing.md) {
            Text("No Cards to Study")
                .font(.appHeading)
                .foregroundColor(.foreground)
            
            Text("You haven't marked any cards as difficult yet. Study all cards first to build your difficult cards collection.")
                .font(.appBody)
                .foregroundColor(.mutedForeground)
                .multilineTextAlignment(.center)
            
            Button(action: {
                studyMode = .all
            }) {
                Text("Study All Cards")
                    .font(.appBody)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, Spacing.md)
                    .background(LinearGradient.primaryGradient)
                    .cornerRadius(CornerRadius.md)
            }
        }
        .padding(Spacing.xl)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.lg)
    }
    
    // MARK: - Control Card
    private var controlCard: some View {
        VStack(spacing: Spacing.md) {
            // Header with mode toggle
            VStack(alignment: .leading, spacing: Spacing.md) {
                // Flashcards title
                HStack(spacing: Spacing.sm) {
                    Image(systemName: "book.fill")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(LinearGradient.textGradient)
                    
                    Text("Flashcards")
                        .font(.appHeading)
                        .foregroundColor(.foreground)
                }
                
                // Card counter and mode buttons
                HStack {
                    Text("\(currentCard + 1) of \(displayCards.count)")
                        .font(.appSmall)
                        .padding(.horizontal, Spacing.sm)
                        .padding(.vertical, Spacing.xs)
                        .background(Color.inputBackground)
                        .cornerRadius(CornerRadius.sm)
                        .overlay(
                            RoundedRectangle(cornerRadius: CornerRadius.sm)
                                .stroke(Color.border, lineWidth: 1)
                        )
                    
                    Spacer()
                    
                    // Mode buttons
                    HStack(spacing: Spacing.sm) {
                        Button(action: {
                            studyMode = .all
                        }) {
                            Text("All Cards")
                                .font(.appSmall)
                                .fontWeight(.medium)
                                .foregroundColor(studyMode == .all ? .white : .foreground)
                                .padding(.horizontal, Spacing.md)
                                .padding(.vertical, Spacing.xs)
                                .background(studyMode == .all ? AnyShapeStyle(LinearGradient.primaryGradient) : AnyShapeStyle(Color.inputBackground))
                                .cornerRadius(CornerRadius.sm)
                                .overlay(
                                    RoundedRectangle(cornerRadius: CornerRadius.sm)
                                        .stroke(studyMode == .all ? Color.clear : Color.border, lineWidth: 1)
                                )
                        }
                        
                        Button(action: {
                            studyMode = .difficult
                        }) {
                            Text("Difficult (\(difficultCards.count))")
                                .font(.appSmall)
                                .fontWeight(.medium)
                                .foregroundColor(studyMode == .difficult ? .white : .foreground)
                                .padding(.horizontal, Spacing.md)
                                .padding(.vertical, Spacing.xs)
                                .background(studyMode == .difficult ? AnyShapeStyle(LinearGradient.primaryGradient) : AnyShapeStyle(Color.inputBackground))
                                .cornerRadius(CornerRadius.sm)
                                .overlay(
                                    RoundedRectangle(cornerRadius: CornerRadius.sm)
                                        .stroke(studyMode == .difficult ? Color.clear : Color.border, lineWidth: 1)
                                )
                        }
                        .disabled(difficultCards.isEmpty)
                    }
                }
            }
            
            // Progress bar
            VStack(spacing: Spacing.xs) {
                HStack {
                    Text("Progress")
                        .font(.appSmall)
                        .foregroundColor(.foreground)
                    
                    Spacer()
                    
                    Text("\(Int(progress))%")
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                }
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.inputBackground)
                            .frame(height: 8)
                        
                        RoundedRectangle(cornerRadius: 4)
                            .fill(LinearGradient.primaryGradient)
                            .frame(width: geometry.size.width * CGFloat(progress / 100), height: 8)
                    }
                }
                .frame(height: 8)
            }
            
            // Stats and actions
            HStack {
                // Stats
                HStack(spacing: Spacing.md) {
                    HStack(spacing: Spacing.xs) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.green)
                        
                        Text("Known: \(knownCards.count)")
                            .font(.appSmall)
                            .foregroundColor(.foreground)
                    }
                    
                    HStack(spacing: Spacing.xs) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                        
                        Text("Difficult: \(difficultCards.count)")
                            .font(.appSmall)
                            .foregroundColor(.foreground)
                    }
                }
                
                Spacer()
                
                // Action buttons
                HStack(spacing: Spacing.sm) {
                    Button(action: shuffleCards) {
                        Image(systemName: "shuffle")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.foreground)
                            .padding(Spacing.sm)
                            .background(Color.inputBackground)
                            .cornerRadius(CornerRadius.sm)
                            .overlay(
                                RoundedRectangle(cornerRadius: CornerRadius.sm)
                                    .stroke(Color.border, lineWidth: 1)
                            )
                    }
                    
                    Button(action: resetProgress) {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.foreground)
                            .padding(Spacing.sm)
                            .background(Color.inputBackground)
                            .cornerRadius(CornerRadius.sm)
                            .overlay(
                                RoundedRectangle(cornerRadius: CornerRadius.sm)
                                    .stroke(Color.border, lineWidth: 1)
                            )
                    }
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.lg)
    }
    
    // MARK: - Flashcard View
    private func flashcardView(card: Flashcard) -> some View {
        Button(action: handleFlip) {
            VStack(spacing: Spacing.md) {
                // Header with badges
                HStack {
                    FlashcardDifficultyBadge(difficulty: card.difficulty)
                    
                    Spacer()
                    
                    Text(card.topic)
                        .font(.appSmall)
                        .fontWeight(.medium)
                        .foregroundColor(.foreground)
                        .padding(.horizontal, Spacing.sm)
                        .padding(.vertical, Spacing.xs)
                        .background(Color.inputBackground)
                        .cornerRadius(CornerRadius.sm)
                        .overlay(
                            RoundedRectangle(cornerRadius: CornerRadius.sm)
                                .stroke(Color.border, lineWidth: 1)
                        )
                }
                
                // Card content
                VStack(spacing: Spacing.md) {
                    if !isFlipped {
                        VStack(spacing: Spacing.md) {
                            Image(systemName: "star.fill")
                                .font(.system(size: 32, weight: .medium))
                                .foregroundStyle(LinearGradient.textGradient)
                            
                            Text(card.front)
                                .font(.appHeading)
                                .foregroundColor(.foreground)
                                .multilineTextAlignment(.center)
                            
                            Text("Tap to reveal answer")
                                .font(.appSmall)
                                .foregroundColor(.mutedForeground)
                        }
                    } else {
                        VStack(spacing: Spacing.md) {
                            Text(card.front)
                                .font(.appHeading)
                                .foregroundColor(.foreground)
                                .multilineTextAlignment(.center)
                            
                            Divider()
                                .background(Color.border)
                            
                            Text(card.back)
                                .font(.appBody)
                                .foregroundColor(.mutedForeground)
                                .multilineTextAlignment(.center)
                                .lineSpacing(4)
                        }
                    }
                }
                .frame(minHeight: 200)
                .frame(maxWidth: .infinity)
            }
            .padding(Spacing.lg)
            .scaleEffect(x: isFlipped ? -1 : 1, y: 1)
        }
        .buttonStyle(PlainButtonStyle())
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.lg)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.lg)
                .stroke(Color.border, lineWidth: 1)
        )
        .rotation3DEffect(
            .degrees(isFlipped ? 180 : 0),
            axis: (x: 0, y: 1, z: 0)
        )
        .animation(.spring(response: 0.5, dampingFraction: 0.7), value: isFlipped)
    }
    
    // MARK: - Navigation and Actions
    private var navigationAndActionsView: some View {
        VStack(spacing: Spacing.md) {
            // Navigation
            HStack {
                Button(action: handlePrevious) {
                    HStack(spacing: Spacing.xs) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 14, weight: .medium))
                        Text("Previous")
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
                
                Spacer()
                
                Text("\(currentCard + 1) / \(displayCards.count)")
                    .font(.appSmall)
                    .foregroundColor(.mutedForeground)
                
                Spacer()
                
                Button(action: handleNext) {
                    HStack(spacing: Spacing.xs) {
                        Text("Next")
                            .font(.appBody)
                        Image(systemName: "arrow.right")
                            .font(.system(size: 14, weight: .medium))
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
            .padding(Spacing.md)
            .background(Color.cardBackground)
            .cornerRadius(CornerRadius.lg)
            
            // Knowledge Assessment
            VStack(spacing: Spacing.sm) {
                HStack(spacing: Spacing.sm) {
                    Button(action: handleKnown) {
                        HStack(spacing: Spacing.xs) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 16, weight: .medium))
                            Text("Know It")
                                .font(.appBody)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.green)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, Spacing.sm)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(CornerRadius.md)
                        .overlay(
                            RoundedRectangle(cornerRadius: CornerRadius.md)
                                .stroke(Color.green.opacity(0.3), lineWidth: 1)
                        )
                    }
                    .disabled(!isFlipped)
                    
                    Button(action: handleDifficult) {
                        HStack(spacing: Spacing.xs) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 16, weight: .medium))
                            Text("Need Practice")
                                .font(.appBody)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, Spacing.sm)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(CornerRadius.md)
                        .overlay(
                            RoundedRectangle(cornerRadius: CornerRadius.md)
                                .stroke(Color.red.opacity(0.3), lineWidth: 1)
                        )
                    }
                    .disabled(!isFlipped)
                }
                
                if !isFlipped {
                    Text("Flip card to rate your knowledge")
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                }
            }
            .padding(Spacing.md)
            .background(Color.cardBackground)
            .cornerRadius(CornerRadius.lg)
        }
    }
    
    // MARK: - Study Tips
    private var studyTipsView: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Study Tips")
                .font(.appHeading)
                .foregroundColor(.foreground)
            
            VStack(alignment: .leading, spacing: Spacing.md) {
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text("Effective Studying:")
                        .font(.appBody)
                        .fontWeight(.semibold)
                        .foregroundColor(.foreground)
                    
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        TipItem(text: "Try to answer before flipping")
                        TipItem(text: "Mark cards honestly")
                        TipItem(text: "Review difficult cards frequently")
                    }
                }
                
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text("Memory Techniques:")
                        .font(.appBody)
                        .fontWeight(.semibold)
                        .foregroundColor(.foreground)
                    
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        TipItem(text: "Create mental associations")
                        TipItem(text: "Use the shuffle feature")
                        TipItem(text: "Study in short sessions")
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.md)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.lg)
    }
    
    // MARK: - Actions
    private func handleFlip() {
        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
            isFlipped.toggle()
        }
    }
    
    private func handleNext() {
        if currentCard < displayCards.count - 1 {
            currentCard += 1
        } else {
            currentCard = 0
        }
        isFlipped = false
    }
    
    private func handlePrevious() {
        if currentCard > 0 {
            currentCard -= 1
        } else {
            currentCard = displayCards.count - 1
        }
        isFlipped = false
    }
    
    private func handleKnown() {
        guard let card = currentFlashcard else { return }
        knownCards.insert(card.id)
        handleNext()
    }
    
    private func handleDifficult() {
        guard let card = currentFlashcard else { return }
        difficultCards.insert(card.id)
        handleNext()
    }
    
    private func shuffleCards() {
        currentCard = Int.random(in: 0..<displayCards.count)
        isFlipped = false
    }
    
    private func resetProgress() {
        knownCards.removeAll()
        difficultCards.removeAll()
        currentCard = 0
        isFlipped = false
    }
}

// MARK: - Flashcard Model
struct Flashcard {
    let id: Int
    let front: String
    let back: String
    let topic: String
    let difficulty: Difficulty
    
    enum Difficulty {
        case easy
        case medium
        case hard
        
        var color: Color {
            switch self {
            case .easy: return .green
            case .medium: return .yellow
            case .hard: return .red
            }
        }
        
        var displayName: String {
            switch self {
            case .easy: return "Easy"
            case .medium: return "Medium"
            case .hard: return "Hard"
            }
        }
    }
}

// MARK: - Difficulty Badge
struct FlashcardDifficultyBadge: View {
    let difficulty: Flashcard.Difficulty
    
    var body: some View {
        Text(difficulty.displayName)
            .font(.appSmall)
            .fontWeight(.medium)
            .foregroundColor(difficulty.color)
            .padding(.horizontal, Spacing.sm)
            .padding(.vertical, Spacing.xs)
            .background(difficulty.color.opacity(0.1))
            .cornerRadius(CornerRadius.sm)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.sm)
                    .stroke(difficulty.color.opacity(0.3), lineWidth: 1)
            )
    }
}

// MARK: - Tip Item
struct TipItem: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: Spacing.xs) {
            Text("•")
                .font(.appBody)
                .foregroundColor(.mutedForeground)
            
            Text(text)
                .font(.appSmall)
                .foregroundColor(.mutedForeground)
        }
    }
}

#Preview {
    FlashcardsView(onNavigate: { _ in })
        .environmentObject(AppState())
        .preferredColorScheme(.dark)
}


