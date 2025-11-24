//
//  QuizSessionView.swift
//  Astronomy Study Coach


import SwiftUI

struct QuizQuestion {
    let id: Int
    let question: String
    let options: [String]
    let correctAnswer: Int
    let explanation: String
    let topic: String
}

struct QuizSessionView: View {
    @EnvironmentObject var appState: AppState
    var onNavigate: ((String) -> Void)?
    @Binding var isActive: Bool
    
    @State private var currentQuestion = 0
    @State private var selectedAnswer: Int? = nil
    @State private var showResult = false
    @State private var answers: [Int] = []
    @State private var quizComplete = false
    
    // 2 difficult astronomy questions
    private let questions: [QuizQuestion] = [
        QuizQuestion(
            id: 1,
            question: "What is the primary mechanism responsible for the observed redshift of distant galaxies, and what does this phenomenon tell us about the universe?",
            options: [
                "Doppler effect due to galaxy motion; indicates galaxies are moving away",
                "Cosmological redshift due to space expansion; provides evidence for the Big Bang and universe expansion",
                "Gravitational redshift from black holes; shows dark matter distribution",
                "Stellar redshift from star composition; reveals galaxy age"
            ],
            correctAnswer: 1,
            explanation: "The cosmological redshift is caused by the expansion of space itself, stretching the wavelength of light as it travels through the expanding universe. This is fundamentally different from the Doppler effect. Hubble's observations of redshift-distance relationships provided key evidence for the Big Bang theory and the accelerating expansion of the universe, leading to the discovery of dark energy.",
            topic: "Cosmology"
        ),
        QuizQuestion(
            id: 2,
            question: "In stellar nucleosynthesis, what is the primary process that prevents elements heavier than iron from being formed in main-sequence stars, and where do these heavier elements originate?",
            options: [
                "Fusion becomes exothermic; formed in supernova explosions",
                "Fusion becomes endothermic requiring more energy than produced; formed in supernovae and neutron star mergers",
                "Nuclear binding energy decreases; formed in red giant atmospheres",
                "Temperature limits prevent fusion; formed in white dwarf accretion"
            ],
            correctAnswer: 1,
            explanation: "Elements up to iron (Fe-56) are formed through exothermic fusion processes that release energy. Beyond iron, fusion becomes endothermic, requiring more energy input than it produces, making it unsustainable in stable stars. Heavier elements (iron through uranium) are primarily synthesized in supernova explosions (r-process) and neutron star mergers, where extreme temperatures and neutron densities allow rapid neutron capture and subsequent beta decay.",
            topic: "Stellar Evolution"
        )
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
                        if quizComplete {
                            completionView
                        } else {
                            progressSection
                            questionSection
                        }
                    }
                    .padding(Spacing.lg)
                }
            }
        }
    }
    
    // MARK: - Progress Section
    private var progressSection: some View {
        VStack(spacing: Spacing.md) {
            HStack {
                Text(questions[currentQuestion].topic)
                    .font(.appCaption)
                    .foregroundColor(.mutedForeground)
                    .padding(.horizontal, Spacing.sm)
                    .padding(.vertical, Spacing.xs)
                    .background(Color.cardBackground)
                    .cornerRadius(CornerRadius.sm)
                    .overlay(
                        RoundedRectangle(cornerRadius: CornerRadius.sm)
                            .stroke(Color.border, lineWidth: 1)
                    )
                
                Spacer()
                
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "clock")
                        .font(.system(size: 14))
                        .foregroundColor(.mutedForeground)
                    Text("Question \(currentQuestion + 1) of \(questions.count)")
                        .font(.appCaption)
                        .foregroundColor(.mutedForeground)
                }
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: CornerRadius.sm)
                        .fill(Color.inputBackground)
                        .frame(height: 8)
                    
                    RoundedRectangle(cornerRadius: CornerRadius.sm)
                        .fill(LinearGradient.primaryGradient)
                        .frame(width: geometry.size.width * CGFloat(currentQuestion + 1) / CGFloat(questions.count), height: 8)
                }
            }
            .frame(height: 8)
        }
        .padding(Spacing.md)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .stroke(Color.border, lineWidth: 1)
        )
    }
    
    // MARK: - Question Section
    private var questionSection: some View {
        VStack(alignment: .leading, spacing: Spacing.lg) {
            // Question
            HStack(alignment: .top, spacing: Spacing.sm) {
                Image(systemName: "target")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.indigo600)
                    .padding(.top, 2)
                
                Text(questions[currentQuestion].question)
                    .font(.appHeading)
                    .foregroundColor(.foreground)
            }
            
            // Options
            VStack(spacing: Spacing.sm) {
                ForEach(0..<questions[currentQuestion].options.count, id: \.self) { index in
                    optionButton(index: index)
                }
            }
            
            // Result Feedback
            if showResult {
                resultFeedback
            }
            
            // Navigation Buttons
            HStack {
                Button(action: {
                    handlePrevQuestion()
                }) {
                    HStack {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 14, weight: .medium))
                        Text("Previous")
                            .font(.appBody)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.foreground)
                    .padding(.horizontal, Spacing.md)
                    .padding(.vertical, Spacing.sm)
                    .background(Color.cardBackground)
                    .cornerRadius(CornerRadius.md)
                    .overlay(
                        RoundedRectangle(cornerRadius: CornerRadius.md)
                            .stroke(Color.border, lineWidth: 1)
                    )
                }
                .disabled(currentQuestion == 0)
                .opacity(currentQuestion == 0 ? 0.5 : 1.0)
                
                Spacer()
                
                if !showResult {
                    Button(action: {
                        handleSubmitAnswer()
                    }) {
                        Text("Submit Answer")
                            .font(.appBody)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, Spacing.lg)
                            .padding(.vertical, Spacing.sm)
                            .background(
                                selectedAnswer != nil
                                    ? LinearGradient.primaryGradient
                                    : LinearGradient(
                                        gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.gray.opacity(0.3)]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                            )
                            .cornerRadius(CornerRadius.md)
                    }
                    .disabled(selectedAnswer == nil)
                } else {
                    Button(action: {
                        handleNextQuestion()
                    }) {
                        HStack {
                            Text(currentQuestion == questions.count - 1 ? "Finish Quiz" : "Next Question")
                                .font(.appBody)
                                .fontWeight(.semibold)
                            Image(systemName: "arrow.right")
                                .font(.system(size: 14, weight: .medium))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, Spacing.lg)
                        .padding(.vertical, Spacing.sm)
                        .background(LinearGradient.primaryGradient)
                        .cornerRadius(CornerRadius.md)
                    }
                }
            }
        }
        .padding(Spacing.lg)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .stroke(Color.border, lineWidth: 1)
        )
    }
    
    // MARK: - Option Button
    private func optionButton(index: Int) -> some View {
        let isSelected = selectedAnswer == index
        let isCorrect = index == questions[currentQuestion].correctAnswer
        let isWrong = showResult && isSelected && !isCorrect
        
        return Button(action: {
            if !showResult {
                selectedAnswer = index
            }
        }) {
            HStack {
                Text(questions[currentQuestion].options[index])
                    .font(.appBody)
                    .foregroundColor(
                        showResult
                            ? (isCorrect ? .white : (isWrong ? .white : .foreground))
                            : (isSelected ? .white : .foreground)
                    )
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                if showResult && isCorrect {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                } else if showResult && isWrong {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
            }
            .padding(Spacing.md)
            .background(optionBackground(isSelected: isSelected, isCorrect: isCorrect, isWrong: isWrong))
            .cornerRadius(CornerRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.md)
                    .stroke(
                        showResult
                            ? (isCorrect ? Color.green : (isWrong ? Color.red : Color.border))
                            : (isSelected ? Color.clear : Color.border),
                        lineWidth: 1
                    )
            )
        }
        .disabled(showResult)
    }
    
    // MARK: - Option Background Helper
    private func optionBackground(isSelected: Bool, isCorrect: Bool, isWrong: Bool) -> AnyShapeStyle {
        if showResult {
            if isCorrect {
                return AnyShapeStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.green.opacity(0.8), Color.green.opacity(0.6)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            } else if isWrong {
                return AnyShapeStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.red.opacity(0.8), Color.red.opacity(0.6)]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            } else {
                return AnyShapeStyle(Color.inputBackground)
            }
        } else {
            if isSelected {
                return AnyShapeStyle(LinearGradient.primaryGradient)
            } else {
                return AnyShapeStyle(Color.inputBackground)
            }
        }
    }
    
    // MARK: - Result Feedback
    private var resultFeedback: some View {
        let isCorrect = selectedAnswer == questions[currentQuestion].correctAnswer
        
        return HStack(alignment: .top, spacing: Spacing.sm) {
            Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                .font(.system(size: 20))
                .foregroundColor(isCorrect ? Color.green : Color.red)
            
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(isCorrect ? "Correct!" : "Incorrect")
                    .font(.appBody)
                    .fontWeight(.semibold)
                    .foregroundColor(isCorrect ? Color.green : Color.red)
                
                Text(questions[currentQuestion].explanation)
                    .font(.appCaption)
                    .foregroundColor(.mutedForeground)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.md)
        .background(
            isCorrect
                ? Color.green.opacity(0.1)
                : Color.red.opacity(0.1)
        )
        .cornerRadius(CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .stroke(isCorrect ? Color.green.opacity(0.3) : Color.red.opacity(0.3), lineWidth: 1)
        )
    }
    
    // MARK: - Completion View
    private var completionView: some View {
        let score = calculateScore()
        let percentage = getScorePercentage()
        
        return VStack(spacing: Spacing.lg) {
            // Trophy Icon
            ZStack {
                Circle()
                    .fill(LinearGradient.primaryGradient.opacity(0.2))
                    .frame(width: 80, height: 80)
                
                Image(systemName: "trophy.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(LinearGradient.primaryGradient)
            }
            
            Text("Quiz Complete!")
                .font(.appTitle)
                .foregroundColor(.foreground)
            
            Text("You've finished the astronomy quiz. Here are your results.")
                .font(.appCaption)
                .foregroundColor(.mutedForeground)
                .multilineTextAlignment(.center)
            
            // Score
            VStack(spacing: Spacing.xs) {
                Text("\(percentage)%")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundStyle(LinearGradient.primaryGradient)
                
                Text("You scored \(score) out of \(questions.count) questions correctly")
                    .font(.appCaption)
                    .foregroundColor(.mutedForeground)
            }
            .padding(.vertical, Spacing.md)
            
            // Progress Bar
            VStack(alignment: .leading, spacing: Spacing.xs) {
                HStack {
                    Text("Overall Performance")
                        .font(.appCaption)
                        .foregroundColor(.mutedForeground)
                    Spacer()
                    Text("\(percentage)%")
                        .font(.appCaption)
                        .foregroundColor(.mutedForeground)
                }
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: CornerRadius.sm)
                            .fill(Color.inputBackground)
                            .frame(height: 12)
                        
                        RoundedRectangle(cornerRadius: CornerRadius.sm)
                            .fill(LinearGradient.primaryGradient)
                            .frame(width: geometry.size.width * CGFloat(percentage) / 100, height: 12)
                    }
                }
                .frame(height: 12)
            }
            .padding(Spacing.md)
            .background(Color.cardBackground)
            .cornerRadius(CornerRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.md)
                    .stroke(Color.border, lineWidth: 1)
            )
            
            // Stats Grid
            HStack(spacing: Spacing.md) {
                statBox(value: "\(score)", label: "Correct", color: Color.green)
                statBox(value: "\(questions.count - score)", label: "Incorrect", color: Color.red)
                statBox(value: "\(questions.count)", label: "Total", color: Color.blue)
            }
            
            // Action Buttons
            VStack(spacing: Spacing.sm) {
                Button(action: {
                    resetQuiz()
                }) {
                    HStack {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 16, weight: .medium))
                        Text("Retake Quiz")
                            .font(.appBody)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.foreground)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, Spacing.sm)
                    .background(Color.cardBackground)
                    .cornerRadius(CornerRadius.md)
                    .overlay(
                        RoundedRectangle(cornerRadius: CornerRadius.md)
                            .stroke(Color.border, lineWidth: 1)
                    )
                }
                
                Button(action: {
                    isActive = false
                }) {
                    Text("Back to Quizzes")
                        .font(.appBody)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, Spacing.sm)
                        .background(LinearGradient.primaryGradient)
                        .cornerRadius(CornerRadius.md)
                }
            }
        }
        .padding(Spacing.lg)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .stroke(Color.border, lineWidth: 1)
        )
    }
    
    private func statBox(value: String, label: String, color: Color) -> some View {
        VStack(spacing: Spacing.xs) {
            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(color)
            Text(label)
                .font(.appSmall)
                .foregroundColor(.mutedForeground)
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
    
    // MARK: - Helper Functions
    private func handleSubmitAnswer() {
        if let answer = selectedAnswer {
            var newAnswers = answers
            if newAnswers.count <= currentQuestion {
                newAnswers.append(answer)
            } else {
                newAnswers[currentQuestion] = answer
            }
            answers = newAnswers
            showResult = true
        }
    }
    
    private func handleNextQuestion() {
        if currentQuestion < questions.count - 1 {
            currentQuestion += 1
            selectedAnswer = answers.count > currentQuestion ? answers[currentQuestion] : nil
            showResult = false
        } else {
            quizComplete = true
        }
    }
    
    private func handlePrevQuestion() {
        if currentQuestion > 0 {
            currentQuestion -= 1
            selectedAnswer = answers.count > currentQuestion ? answers[currentQuestion] : nil
            showResult = false
        }
    }
    
    private func resetQuiz() {
        currentQuestion = 0
        selectedAnswer = nil
        showResult = false
        answers = []
        quizComplete = false
    }
    
    private func calculateScore() -> Int {
        return answers.enumerated().reduce(0) { score, item in
            let (index, answer) = item
            return score + (answer == questions[index].correctAnswer ? 1 : 0)
        }
    }
    
    private func getScorePercentage() -> Int {
        guard questions.count > 0 else { return 0 }
        return Int((Double(calculateScore()) / Double(questions.count)) * 100)
    }
}

#Preview {
    QuizSessionView(isActive: .constant(true))
        .environmentObject(AppState())
        .preferredColorScheme(.dark)
}


