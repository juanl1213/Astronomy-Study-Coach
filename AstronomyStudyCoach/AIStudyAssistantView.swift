//
//  AIStudyAssistantView.swift
//  Astronomy Study Coach
//
//  AI Study Assistant chat interface
//

import SwiftUI

struct AIStudyAssistantView: View {
    let onNavigate: (String) -> Void
    @EnvironmentObject var appState: AppState
    
    @State private var messages: [ChatMessage] = [
        ChatMessage(
            id: "1",
            content: "Hello! I'm your Astronomy Study AI Assistant. I'm here to help you learn about space, answer your astronomy questions, and guide you through your cosmic journey. What would you like to explore today?",
            role: .assistant,
            timestamp: Date()
        )
    ]
    @State private var inputText = ""
    @State private var isTyping = false
    
    private let suggestedQuestions = [
        "What is a black hole?",
        "How far is the nearest star?",
        "Explain the Big Bang theory",
        "What are exoplanets?",
        "How do stars form?",
        "What is dark matter?"
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                // Header
                AppHeaderView()
                    .environmentObject(appState)
                
                // Content
                VStack(spacing: Spacing.lg) {
                    // Title Section
                    headerSection
                    
                    // Main Content
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        // Mobile: Stacked layout
                        VStack(spacing: Spacing.lg) {
                            chatSection
                            sidebarSection
                        }
                    } else {
                        // iPad/Mac: Side by side
                        HStack(alignment: .top, spacing: Spacing.lg) {
                            chatSection
                                .frame(maxWidth: .infinity)
                            
                            sidebarSection
                                .frame(width: 300)
                        }
                    }
                }
                .padding(.horizontal, Spacing.lg)
            }
        }
        .background(Color.background)
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        HStack(spacing: Spacing.md) {
            // Bot Icon
            ZStack(alignment: .topTrailing) {
                ZStack {
                    RoundedRectangle(cornerRadius: CornerRadius.md)
                        .fill(LinearGradient(
                            colors: [Color.indigo600, Color.purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 48, height: 48)
                        .shadow(color: Color.indigo600.opacity(0.3), radius: 10, x: 0, y: 4)
                    
                    Image(systemName: "brain.head.profile")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundColor(.white)
                }
                
                // Online indicator
                Circle()
                    .fill(Color.green)
                    .frame(width: 12, height: 12)
                    .overlay(
                        Circle()
                            .stroke(Color.background, lineWidth: 2)
                    )
                    .offset(x: 2, y: -2)
            }
            
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text("AI Study Assistant")
                    .font(.appTitle)
                    .foregroundStyle(LinearGradient.textGradient)
                
                Text("Your personal astronomy tutor")
                    .font(.appSmall)
                    .foregroundColor(.mutedForeground)
            }
            
            Spacer()
        }
    }
    
    // MARK: - Chat Section
    private var chatSection: some View {
        VStack(spacing: 0) {
            // Chat Header
            HStack {
                HStack(spacing: Spacing.sm) {
                    Image(systemName: "message.fill")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.indigo400)
                    
                    Text("Chat Session")
                        .font(.appBody)
                        .foregroundColor(.foreground)
                }
                
                Spacer()
                
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 12, weight: .medium))
                    Text("AI Powered")
                        .font(.appSmall)
                }
                .foregroundColor(.indigo400)
                .padding(.horizontal, Spacing.sm)
                .padding(.vertical, Spacing.xs)
                .background(Color.indigo600.opacity(0.1))
                .cornerRadius(CornerRadius.sm)
                .overlay(
                    RoundedRectangle(cornerRadius: CornerRadius.sm)
                        .stroke(Color.indigo600.opacity(0.2), lineWidth: 1)
                )
            }
            .padding(Spacing.md)
            .background(
                LinearGradient(
                    colors: [Color.indigo600.opacity(0.1), Color.purple.opacity(0.1)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.border),
                alignment: .bottom
            )
            
            // Messages
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: Spacing.md) {
                        ForEach(messages) { message in
                            MessageBubble(message: message)
                                .id(message.id)
                        }
                        
                        if isTyping {
                            TypingIndicator()
                        }
                    }
                    .padding(Spacing.md)
                }
                .frame(height: 500)
                .onChange(of: messages.count) { _ in
                    if let lastMessage = messages.last {
                        withAnimation {
                            proxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
                .onChange(of: isTyping) { _ in
                    if isTyping {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation {
                                proxy.scrollTo("typing", anchor: .bottom)
                            }
                        }
                    }
                }
            }
            
            // Input Area
            HStack(spacing: Spacing.sm) {
                TextField("Ask me anything about astronomy...", text: $inputText)
                    .font(.appBody)
                    .foregroundColor(.foreground)
                    .padding(Spacing.md)
                    .background(Color.inputBackground.opacity(0.5))
                    .cornerRadius(CornerRadius.md)
                    .overlay(
                        RoundedRectangle(cornerRadius: CornerRadius.md)
                            .stroke(Color.indigo600.opacity(0.2), lineWidth: 1)
                    )
                    .disabled(isTyping)
                    .onSubmit {
                        sendMessage()
                    }
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(
                            LinearGradient(
                                colors: [Color.indigo600, Color.purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(CornerRadius.md)
                }
                .disabled(inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isTyping)
            }
            .padding(Spacing.md)
            .background(
                LinearGradient(
                    colors: [Color.indigo600.opacity(0.05), Color.purple.opacity(0.05)],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.border),
                alignment: .top
            )
        }
        .background(Color.cardBackground.opacity(0.5))
        .cornerRadius(CornerRadius.lg)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.lg)
                .stroke(Color.indigo600.opacity(0.2), lineWidth: 1)
        )
    }
    
    // MARK: - Sidebar Section
    private var sidebarSection: some View {
        VStack(spacing: Spacing.lg) {
            // Suggested Questions
            suggestedQuestionsCard
            
            // Quick Actions
            quickActionsCard
            
            // Tips
            tipsCard
        }
    }
    
    // MARK: - Suggested Questions Card
    private var suggestedQuestionsCard: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack(spacing: Spacing.sm) {
                Image(systemName: "lightbulb.fill")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.yellow)
                
                Text("Suggested Questions")
                    .font(.appHeading)
                    .foregroundColor(.foreground)
            }
            
            VStack(spacing: Spacing.sm) {
                ForEach(suggestedQuestions, id: \.self) { question in
                    Button(action: {
                        inputText = question
                    }) {
                        Text(question)
                            .font(.appSmall)
                            .foregroundColor(.foreground)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(Spacing.md)
                            .background(Color.inputBackground)
                            .cornerRadius(CornerRadius.md)
                            .overlay(
                                RoundedRectangle(cornerRadius: CornerRadius.md)
                                    .stroke(Color.indigo600.opacity(0.2), lineWidth: 1)
                            )
                    }
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.cardBackground.opacity(0.5))
        .cornerRadius(CornerRadius.lg)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.lg)
                .stroke(Color.indigo600.opacity(0.2), lineWidth: 1)
        )
    }
    
    // MARK: - Quick Actions Card
    private var quickActionsCard: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack(spacing: Spacing.sm) {
                Image(systemName: "rocket.fill")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.cyan)
                
                Text("Quick Actions")
                    .font(.appHeading)
                    .foregroundColor(.foreground)
            }
            
            VStack(spacing: Spacing.sm) {
                AIQuickActionButton(
                    icon: "book.fill",
                    title: "Browse Study Topics",
                    action: {
                        Task { @MainActor in
                            appState.navigate(to: "study")
                        }
                    }
                )
                
                AIQuickActionButton(
                    icon: "target",
                    title: "Take a Quiz",
                    action: {
                        Task { @MainActor in
                            appState.navigate(to: "quiz")
                        }
                    }
                )
                
                AIQuickActionButton(
                    icon: "brain",
                    title: "Study Flashcards",
                    action: {
                        Task { @MainActor in
                            appState.navigate(to: "flashcards")
                        }
                    }
                )
                
                AIQuickActionButton(
                    icon: "star.fill",
                    title: "Constellation Guide",
                    action: {
                        // Navigate to constellations when implemented
                    }
                )
            }
        }
        .padding(Spacing.md)
        .background(Color.cardBackground.opacity(0.5))
        .cornerRadius(CornerRadius.lg)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.lg)
                .stroke(Color.cyan.opacity(0.2), lineWidth: 1)
        )
    }
    
    // MARK: - Tips Card
    private var tipsCard: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("💡 Tips for Better Learning")
                .font(.appHeading)
                .foregroundColor(.foreground)
            
            VStack(alignment: .leading, spacing: Spacing.sm) {
                TipItem(text: "Ask specific questions for detailed answers")
                TipItem(text: "Request examples or analogies for complex topics")
                TipItem(text: "Follow up with \"explain more\" for deeper understanding")
                TipItem(text: "Ask about current space missions and discoveries")
            }
        }
        .padding(Spacing.md)
        .background(
            LinearGradient(
                colors: [Color.purple.opacity(0.1), Color.indigo600.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(CornerRadius.lg)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.lg)
                .stroke(Color.purple.opacity(0.2), lineWidth: 1)
        )
    }
    
    // MARK: - Actions
    private func sendMessage() {
        let trimmedInput = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedInput.isEmpty else { return }
        
        // Add user message
        let userMessage = ChatMessage(
            id: UUID().uuidString,
            content: trimmedInput,
            role: .user,
            timestamp: Date()
        )
        messages.append(userMessage)
        inputText = ""
        isTyping = true
        
        // Generate AI response after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 1.0...2.0)) {
            let response = generateResponse(for: trimmedInput)
            let assistantMessage = ChatMessage(
                id: UUID().uuidString,
                content: response,
                role: .assistant,
                timestamp: Date()
            )
            messages.append(assistantMessage)
            isTyping = false
        }
    }
    
    private func generateResponse(for question: String) -> String {
        let lowerQuestion = question.lowercased()
        
        // Black hole questions
        if lowerQuestion.contains("black hole") {
            return "A black hole is a region in space where gravity is so strong that nothing, not even light, can escape from it. They form when massive stars collapse at the end of their life cycle. There are different types: stellar black holes (formed from collapsed stars), supermassive black holes (found at galaxy centers), and intermediate black holes. The boundary around a black hole is called the event horizon - once something crosses this point, it cannot escape. Would you like to learn more about how black holes affect nearby objects?"
        }
        
        // Star questions
        if lowerQuestion.contains("star") && (lowerQuestion.contains("form") || lowerQuestion.contains("born")) {
            return "Stars form in giant clouds of gas and dust called nebulae. When a region of the nebula becomes dense enough, gravity causes it to collapse. As the material compresses, it heats up, and eventually the core becomes hot enough (around 10 million degrees Celsius) for nuclear fusion to begin. This fusion of hydrogen into helium releases enormous energy, and a star is born! Our Sun formed this way about 4.6 billion years ago. The process can take millions of years from start to finish."
        }
        
        // Planet questions
        if lowerQuestion.contains("solar system") {
            return "Our solar system has 8 planets orbiting the Sun: Mercury, Venus, Earth, Mars (the rocky terrestrial planets), Jupiter, Saturn, Uranus, and Neptune (the gas and ice giants). Each planet has unique characteristics - for example, Jupiter is the largest and has a giant storm called the Great Red Spot, while Saturn is famous for its spectacular ring system. Would you like to explore a specific planet in detail?"
        }
        
        // Exoplanet questions
        if lowerQuestion.contains("exoplanet") {
            return "Exoplanets are planets that orbit stars other than our Sun. Scientists have discovered over 5,000 confirmed exoplanets! We find them using several methods: the transit method (detecting tiny dips in a star's brightness when a planet passes in front), the radial velocity method (detecting wobbles in a star's motion), and direct imaging. Some exoplanets are in the 'habitable zone' where liquid water could exist. The study of exoplanets helps us understand if Earth-like worlds are common in the universe!"
        }
        
        // Big Bang questions
        if lowerQuestion.contains("big bang") {
            return "The Big Bang theory describes how the universe began approximately 13.8 billion years ago. It wasn't an explosion in space, but rather an expansion of space itself from an incredibly hot, dense point. In the first fractions of a second, the universe expanded rapidly (inflation), then cooled enough for subatomic particles to form, then atoms (mostly hydrogen and helium). Evidence for the Big Bang includes the cosmic microwave background radiation, the abundance of light elements, and the fact that galaxies are moving away from each other. It's the best explanation we have for the origin and evolution of our universe!"
        }
        
        // Dark matter questions
        if lowerQuestion.contains("dark matter") {
            return "Dark matter is a mysterious form of matter that doesn't emit, absorb, or reflect light, making it invisible to telescopes. However, we know it exists because of its gravitational effects on visible matter. Galaxies rotate faster than they should based on visible matter alone, and galaxy clusters are held together by more gravity than we can see. Scientists estimate that dark matter makes up about 27% of the universe's mass-energy content, while ordinary matter is only about 5%. We still don't know what dark matter is made of - it's one of the biggest mysteries in modern astronomy!"
        }
        
        // Galaxy questions
        if lowerQuestion.contains("galaxy") || lowerQuestion.contains("galaxies") {
            return "Galaxies are massive systems of stars, gas, dust, and dark matter bound together by gravity. There are billions of galaxies in the observable universe! They come in different shapes: spiral galaxies (like our Milky Way) have rotating arms, elliptical galaxies are more spherical, and irregular galaxies have no defined shape. Our Milky Way galaxy contains 200-400 billion stars and is about 100,000 light-years across. The nearest large galaxy to us is Andromeda, about 2.5 million light-years away. What aspect of galaxies interests you most?"
        }
        
        // Distance questions
        if lowerQuestion.contains("nearest star") || lowerQuestion.contains("closest star") {
            return "The nearest star to Earth (excluding the Sun) is Proxima Centauri, part of the Alpha Centauri star system. It's about 4.24 light-years away, which means light from this star takes 4.24 years to reach us! That's roughly 40 trillion kilometers (25 trillion miles). Even traveling at the speed of our fastest spacecraft, it would take tens of thousands of years to get there. Interestingly, Proxima Centauri has at least one confirmed exoplanet, called Proxima Centauri b, which orbits in the star's habitable zone!"
        }
        
        // Moon questions
        if lowerQuestion.contains("moon") {
            return "The Moon is Earth's only natural satellite, orbiting our planet at an average distance of 384,400 km (238,855 miles). It formed about 4.5 billion years ago, likely from debris after a Mars-sized object collided with Earth. The Moon's phases occur because we see different amounts of its sunlit side as it orbits Earth. It takes about 27.3 days to orbit Earth and the same time to rotate once, which is why we always see the same face of the Moon. The Moon's gravity causes ocean tides on Earth and has been gradually slowing Earth's rotation over billions of years."
        }
        
        // Constellation questions
        if lowerQuestion.contains("constellation") {
            return "Constellations are patterns of stars in the night sky that humans have recognized and named throughout history. There are 88 officially recognized constellations today. They're useful for navigation and organizing our view of the sky. Important to note: the stars in a constellation usually aren't physically close to each other - they just appear near each other from our viewpoint on Earth. Famous constellations include Orion (the hunter), Ursa Major (containing the Big Dipper), and the zodiac constellations. Different cultures have created different constellation patterns from the same stars!"
        }
        
        // Nebula questions
        if lowerQuestion.contains("nebula") || lowerQuestion.contains("nebulae") {
            return "Nebulae are vast clouds of gas and dust in space. They come in several types: emission nebulae glow with their own light (excited by nearby stars), reflection nebulae reflect light from nearby stars, and dark nebulae block light from behind. Nebulae are stellar nurseries - new stars form within them. When massive stars die, they can create planetary nebulae (from medium stars) or supernova remnants (from massive stars). The famous Orion Nebula, visible to the naked eye, is a stellar nursery about 1,344 light-years away where new stars are being born right now!"
        }
        
        // Default educational response
        return "That's a great question! While I'm focused on astronomy topics, I'd love to help you explore the universe. Here are some fascinating topics we can discuss: the lifecycle of stars, the formation of our solar system, black holes and their mysteries, the search for exoplanets, galaxy types and evolution, the Big Bang theory, dark matter and dark energy, space exploration missions, or astronomical observations and telescope technology. What interests you most?"
    }
}

// MARK: - Chat Message Model
struct ChatMessage: Identifiable {
    let id: String
    let content: String
    let role: MessageRole
    let timestamp: Date
    
    enum MessageRole {
        case user
        case assistant
    }
}

// MARK: - Message Bubble
struct MessageBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            HStack(alignment: .top, spacing: Spacing.sm) {
                if message.role == .assistant {
                    // Bot avatar
                    ZStack {
                        Circle()
                            .fill(Color.indigo600.opacity(0.2))
                            .frame(width: 32, height: 32)
                        
                        Image(systemName: "brain.head.profile")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.indigo400)
                    }
                }
                
                if message.role == .user {
                    // User avatar
                    ZStack {
                        Circle()
                            .fill(Color.cyan.opacity(0.2))
                            .frame(width: 32, height: 32)
                        
                        Text("U")
                            .font(.appSmall)
                            .fontWeight(.semibold)
                            .foregroundColor(.cyan)
                    }
                }
                
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text(message.content)
                        .font(.appBody)
                        .foregroundColor(message.role == .user ? .white : .foreground)
                        .padding(Spacing.md)
                        .background(
                            message.role == .user
                                ? LinearGradient(
                                    colors: [Color.cyan, Color.cyan600],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                                : LinearGradient(
                                    colors: [Color.indigo600.opacity(0.2), Color.purple.opacity(0.2)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                        )
                        .cornerRadius(CornerRadius.lg)
                        .overlay(
                            RoundedRectangle(cornerRadius: CornerRadius.lg)
                                .stroke(
                                    message.role == .user
                                        ? Color.clear
                                        : Color.indigo600.opacity(0.2),
                                    lineWidth: 1
                                )
                        )
                    
                    Text(formatTime(message.timestamp))
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                }
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.85, alignment: .leading)
            
            Spacer()
        }
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

// MARK: - Typing Indicator
struct TypingIndicator: View {
    @State private var animationPhase = 0
    
    var body: some View {
        HStack {
            Spacer(minLength: 100)
            
            HStack(alignment: .top, spacing: Spacing.sm) {
                ZStack {
                    Circle()
                        .fill(Color.indigo600.opacity(0.2))
                        .frame(width: 32, height: 32)
                    
                    Image(systemName: "brain.head.profile")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.indigo400)
                }
                
                HStack(spacing: 4) {
                    ForEach(0..<3) { index in
                        Circle()
                            .fill(Color.indigo400)
                            .frame(width: 8, height: 8)
                            .offset(y: animationPhase == index ? -4 : 0)
                            .animation(
                                Animation.easeInOut(duration: 0.6)
                                    .repeatForever()
                                    .delay(Double(index) * 0.2),
                                value: animationPhase
                            )
                    }
                }
                .padding(Spacing.md)
                .background(
                    LinearGradient(
                        colors: [Color.indigo600.opacity(0.2), Color.purple.opacity(0.2)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(CornerRadius.lg)
                .overlay(
                    RoundedRectangle(cornerRadius: CornerRadius.lg)
                        .stroke(Color.indigo600.opacity(0.2), lineWidth: 1)
                )
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.85, alignment: .leading)
            
            Spacer(minLength: 100)
        }
        .id("typing")
        .onAppear {
            animationPhase = 1
        }
    }
}

// MARK: - Quick Action Button
struct AIQuickActionButton: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: Spacing.sm) {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.cyan)
                
                Text(title)
                    .font(.appSmall)
                    .foregroundColor(.foreground)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(Spacing.md)
            .background(Color.inputBackground)
            .cornerRadius(CornerRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.md)
                    .stroke(Color.cyan.opacity(0.2), lineWidth: 1)
            )
        }
    }
}

#Preview {
    AIStudyAssistantView(onNavigate: { _ in })
        .environmentObject(AppState())
        .preferredColorScheme(.dark)
}


