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
    
    @State private var messages: [ChatMessage] = []
    @State private var inputText = ""
    @State private var isTyping = false
    @State private var errorMessage: String?
    @State private var showError = false
    @State private var currentSessionId: String?
    @State private var showChatHistory = false
    @State private var pastSessions: [ChatSession] = []
    @State private var currentTask: Task<Void, Never>?
    
    // Initial greeting message
    private let initialGreeting = ChatMessage(
        id: "1",
        content: "Hello! I'm your Astronomy Study AI Assistant. I'm here to help you learn about space, answer your astronomy questions, and guide you through your cosmic journey. What would you like to explore today?",
        role: .assistant,
        timestamp: Date()
    )
    
    // Google Gemini API Configuration
    // TODO: Store API key securely in Keychain for production
    private var geminiAPIKey: String {
        // Replace with your actual Gemini API key
        return "API_KEY_HERE"
    }
    
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
        .alert("Error", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage ?? "An unknown error occurred")
        }
        .onAppear {
            loadChatHistory()
        }
        .onDisappear {
            // Cancel any ongoing requests when view disappears
            currentTask?.cancel()
        }
        .onChange(of: appState.userEmail) { _ in
            // When user logs in, start with blank conversation
            if !appState.userEmail.isEmpty {
                loadChatHistory()
            } else {
                // Cancel requests when user logs out
                currentTask?.cancel()
            }
        }
        .onChange(of: messages.count) { _ in
            // Save chat history when messages change (but not during typing)
            if !isTyping && !messages.isEmpty {
                saveChatHistory()
            }
        }
        .sheet(isPresented: $showChatHistory) {
            ChatHistoryView(
                sessions: pastSessions,
                onSelectSession: { session in
                    loadPastSession(session)
                },
                onDismiss: {
                    showChatHistory = false
                }
            )
        }
    }
    
    // MARK: - Load Chat History
    private func loadChatHistory() {
        // Always start with a blank conversation (just the greeting)
        // Past conversations are accessible via the history button
        messages = [initialGreeting]
        currentSessionId = nil
        
        // Load past sessions for the history view
        pastSessions = ChatHistoryManager.shared.getAllChatSessions(email: appState.userEmail)
    }
    
    // MARK: - Load Past Session
    private func loadPastSession(_ session: ChatSession) {
        messages = [initialGreeting] + session.messages
        currentSessionId = session.id
        showChatHistory = false
    }
    
    // MARK: - Start New Conversation
    private func startNewConversation() {
        // Save current conversation before starting new one
        if messages.contains(where: { $0.role == .user }) {
            saveChatHistory()
        }
        
        messages = [initialGreeting]
        currentSessionId = nil
        
        // Reload past sessions
        pastSessions = ChatHistoryManager.shared.getAllChatSessions(email: appState.userEmail)
    }
    
    // MARK: - Save Chat History
    private func saveChatHistory() {
        // Only save if there are user messages (actual conversation)
        let hasUserMessages = messages.contains { $0.role == .user }
        guard hasUserMessages else { return }
        
        // Update current session or create new one
        if currentSessionId != nil {
            ChatHistoryManager.shared.updateCurrentChatSession(email: appState.userEmail, messages: messages)
        } else {
            ChatHistoryManager.shared.saveChatSession(email: appState.userEmail, messages: messages)
            // After saving, get the session ID for future updates
            if let session = ChatHistoryManager.shared.getMostRecentChatSession(email: appState.userEmail) {
                currentSessionId = session.id
            }
        }
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
            // Chat History Button
            chatHistoryCard
            
            // Suggested Questions
            suggestedQuestionsCard
            
            // Quick Actions
            quickActionsCard
            
            // Tips
            tipsCard
        }
    }
    
    // MARK: - Chat History Card
    private var chatHistoryCard: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack(spacing: Spacing.sm) {
                Image(systemName: "clock.fill")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.indigo600)
                
                Text("Chat History")
                    .font(.appHeading)
                    .foregroundColor(.foreground)
            }
            
            VStack(spacing: Spacing.sm) {
                if pastSessions.isEmpty {
                    Text("No past conversations")
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(Spacing.md)
                } else {
                    Text("\(pastSessions.count) conversation\(pastSessions.count == 1 ? "" : "s") available")
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, Spacing.md)
                }
                
                Button(action: {
                    pastSessions = ChatHistoryManager.shared.getAllChatSessions(email: appState.userEmail)
                    showChatHistory = true
                }) {
                    HStack {
                        Image(systemName: "clock.arrow.circlepath")
                            .font(.system(size: 14, weight: .medium))
                        Text(pastSessions.isEmpty ? "View History" : "View \(pastSessions.count) Conversation\(pastSessions.count == 1 ? "" : "s")")
                            .font(.appBody)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, Spacing.sm)
                    .background(LinearGradient.primaryGradient)
                    .cornerRadius(CornerRadius.md)
                }
                
                if !messages.isEmpty && messages.contains(where: { $0.role == .user }) {
                    Button(action: startNewConversation) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 14, weight: .medium))
                            Text("New Conversation")
                                .font(.appBody)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(.indigo600)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, Spacing.sm)
                        .background(Color.indigo600.opacity(0.1))
                        .cornerRadius(CornerRadius.md)
                        .overlay(
                            RoundedRectangle(cornerRadius: CornerRadius.md)
                                .stroke(Color.indigo600.opacity(0.3), lineWidth: 1)
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
        
        // Cancel any existing request to prevent overlapping requests
        currentTask?.cancel()
        
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
        errorMessage = nil
        
        // Generate AI response with cancellation support
        currentTask = Task {
            do {
                let response = try await generateGeminiResponse(for: trimmedInput)
                
                // Check if task was cancelled
                guard !Task.isCancelled else { return }
                
                await MainActor.run {
                    let assistantMessage = ChatMessage(
                        id: UUID().uuidString,
                        content: response,
                        role: .assistant,
                        timestamp: Date()
                    )
                    messages.append(assistantMessage)
                    isTyping = false
                    // Save chat history after receiving response
                    saveChatHistory()
                }
            } catch {
                // Check if task was cancelled
                guard !Task.isCancelled else { return }
                
                await MainActor.run {
                    isTyping = false
                    
                    // Provide more user-friendly error messages
                    let userFriendlyError: String
                    if let nsError = error as NSError? {
                        switch nsError.code {
                        case NSURLErrorTimedOut:
                            userFriendlyError = "Request timed out. Please check your internet connection and try again."
                        case NSURLErrorNotConnectedToInternet:
                            userFriendlyError = "No internet connection. Please check your network and try again."
                        case NSURLErrorNetworkConnectionLost:
                            userFriendlyError = "Connection lost. Please try again."
                        case 429:
                            userFriendlyError = "Too many requests. Please wait a moment and try again."
                        case 404:
                            userFriendlyError = "Service temporarily unavailable. Please try again in a moment."
                        default:
                            userFriendlyError = error.localizedDescription
                        }
                    } else {
                        userFriendlyError = error.localizedDescription
                    }
                    
                    errorMessage = userFriendlyError
                    showError = true
                    
                    // Add error message to chat
                    let errorChatMessage = ChatMessage(
                        id: UUID().uuidString,
                        content: "I'm sorry, I encountered an error: \(userFriendlyError). Please try again.",
                        role: .assistant,
                        timestamp: Date()
                    )
                    messages.append(errorChatMessage)
                    // Save chat history even with error message
                    saveChatHistory()
                }
            }
        }
    }
    
    // MARK: - Google Gemini API Integration
    private func generateGeminiResponse(for question: String) async throws -> String {
        // Validate API key
        guard !geminiAPIKey.isEmpty && geminiAPIKey != "YOUR_GEMINI_API_KEY_HERE" else {
            throw NSError(domain: "AIError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Gemini API key not configured. Please add your API key in Settings."])
        }
        
        // Build conversation context using structured format
        let systemInstruction = "You are an expert astronomy tutor and study assistant. Your role is to help students learn about space, stars, planets, galaxies, black holes, and all aspects of astronomy. Provide clear, educational, and engaging explanations. IMPORTANT: Keep responses concise - aim for 1-2 short paragraphs maximum (100-200 words). Be direct and to the point. Use **bold** markdown formatting for key terms (e.g., **supernova**, **black hole**). If asked about non-astronomy topics, politely redirect to astronomy-related subjects."
        
        // Build conversation history - capture messages snapshot to avoid race conditions
        var contents: [[String: Any]] = []
        let messagesSnapshot = await MainActor.run { Array(messages.suffix(10)) }
        
        // Add recent conversation history (excluding the initial greeting and current question)
        for msg in messagesSnapshot {
            // Skip the initial greeting message
            if msg.id == "1" && msg.role == .assistant {
                continue
            }
            contents.append([
                "role": msg.role == .user ? "user" : "model",
                "parts": [["text": msg.content]]
            ])
        }
        
        // Add current question (only once)
        contents.append([
            "role": "user",
            "parts": [["text": question]]
        ])
        
        // Try different model names - gemini-2.5-flash might not exist, fallback to 2.0 or 1.5
        let modelNames = ["gemini-2.5-flash", "gemini-2.0-flash", "gemini-1.5-flash"]
        var lastError: Error?
        
        for modelName in modelNames {
            do {
                // Gemini API endpoint
                let urlString = "https://generativelanguage.googleapis.com/v1beta/models/\(modelName):generateContent?key=\(geminiAPIKey)"
                guard let url = URL(string: urlString) else {
                    continue // Try next model
                }
                
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.timeoutInterval = 60.0 // Increased from 30 to 60 seconds
                request.cachePolicy = .reloadIgnoringLocalCacheData // Prevent caching issues
                
                let requestBody: [String: Any] = [
                    "systemInstruction": [
                        "parts": [["text": systemInstruction]]
                    ],
                    "contents": contents,
                    "generationConfig": [
                        "temperature": 0.7,
                        "topP": 0.8,
                        "topK": 40
                    ]
                ]
                
                guard let httpBody = try? JSONSerialization.data(withJSONObject: requestBody) else {
                    throw NSError(domain: "AIError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to encode request body"])
                }
                request.httpBody = httpBody
                
                // Retry logic for transient failures with exponential backoff
                let maxRetries = 3 // Increased from 2 to 3
                
                for attempt in 0...maxRetries {
                    // Check for cancellation before each attempt
                    try Task.checkCancellation()
                    
                    do {
                        // Use URLSession with custom configuration for better reliability
                        let config = URLSessionConfiguration.default
                        config.timeoutIntervalForRequest = 60.0
                        config.timeoutIntervalForResource = 120.0
                        config.waitsForConnectivity = true
                        let session = URLSession(configuration: config)
                        
                        let (data, response) = try await session.data(for: request)
                        
                        guard let httpResponse = response as? HTTPURLResponse else {
                            throw NSError(domain: "AIError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response from server"])
                        }
                        
                        // Always log the response for debugging
                        if let responseString = String(data: data, encoding: .utf8) {
                            print("Gemini API Response (Status \(httpResponse.statusCode), Model: \(modelName)): \(responseString)")
                        }
                        
                        // Handle rate limiting (429) with exponential backoff
                        if httpResponse.statusCode == 429 {
                            if attempt < maxRetries {
                                // Exponential backoff: 2^attempt seconds (1s, 2s, 4s, 8s)
                                let delay = pow(2.0, Double(attempt + 1))
                                print("Rate limited (429). Retrying in \(delay) seconds (attempt \(attempt + 1)/\(maxRetries + 1))")
                                try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                                continue
                            } else {
                                throw NSError(domain: "AIError", code: 429, userInfo: [NSLocalizedDescriptionKey: "API rate limit exceeded. Please wait a moment and try again."])
                            }
                        }
                        
                        guard httpResponse.statusCode == 200 else {
                            let errorData = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                            let errorMessage = errorData?["error"] as? [String: Any]
                            let message = errorMessage?["message"] as? String ?? "API request failed with status \(httpResponse.statusCode)"
                            
                            // If it's a 404, the model doesn't exist - try next model
                            if httpResponse.statusCode == 404 {
                                throw NSError(domain: "AIError", code: 404, userInfo: [NSLocalizedDescriptionKey: "Model not found"])
                            }
                            
                            throw NSError(domain: "AIError", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: message])
                        }
                        
                        // Enhanced JSON parsing with better error handling
                        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            // Log raw response for debugging
                            if let responseString = String(data: data, encoding: .utf8) {
                                print("Failed to parse JSON. Raw response: \(responseString.prefix(500))")
                            }
                            throw NSError(domain: "AIError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON response from API"])
                        }
                        
                        // Log response structure for debugging
                        print("Response JSON keys: \(Array(json.keys))")
                        
                        // Check for error in response first
                        if let error = json["error"] as? [String: Any] {
                            let errorMessage = error["message"] as? String ?? "Unknown API error"
                            let errorCode = error["code"] as? Int ?? -1
                            print("API Error: \(errorMessage) (code: \(errorCode))")
                            throw NSError(domain: "AIError", code: errorCode, userInfo: [NSLocalizedDescriptionKey: errorMessage])
                        }
                        
                        // Check for candidates
                        guard let candidates = json["candidates"] as? [[String: Any]] else {
                            // Try alternative response structure
                            if let promptFeedback = json["promptFeedback"] as? [String: Any] {
                                let blockReason = promptFeedback["blockReason"] as? String
                                let blockReasonMessage = promptFeedback["blockReasonMessage"] as? String
                                let reason = blockReasonMessage ?? blockReason ?? "unknown"
                                print("Response blocked. Reason: \(reason)")
                                throw NSError(domain: "AIError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Response was blocked. Reason: \(reason)"])
                            }
                            
                            // Log full response structure for debugging
                            print("No candidates found. Full response structure: \(json)")
                            throw NSError(domain: "AIError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No candidates in API response. The response may have been filtered or blocked."])
                        }
                        
                        guard !candidates.isEmpty else {
                            throw NSError(domain: "AIError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Empty candidates array. The response may have been filtered by safety settings."])
                        }
                        
                        let firstCandidate = candidates[0]
                        
                        // Log candidate structure
                        print("First candidate keys: \(firstCandidate.keys)")
                        
                        // Handle finish reasons
                        if let finishReason = firstCandidate["finishReason"] as? String {
                            switch finishReason {
                            case "SAFETY":
                                throw NSError(domain: "AIError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Response was blocked by safety filters. Please try rephrasing your question."])
                            case "MAX_TOKENS":
                                // Response was truncated but still valid - continue to extract text
                                break
                            case "STOP":
                                // Normal completion
                                break
                            default:
                                print("Unhandled finish reason: \(finishReason)")
                            }
                        }
                        
                        // Enhanced content extraction with multiple fallback paths
                        var text: String?
                        
                        // Standard structure: content.parts[0].text
                        if let content = firstCandidate["content"] as? [String: Any] {
                            // Try parts array
                            if let parts = content["parts"] as? [[String: Any]] {
                                for part in parts {
                                    if let extractedText = part["text"] as? String {
                                        text = extractedText
                                        break
                                    }
                                    // Try alternative part structures
                                    if text == nil {
                                        if let partText = part["content"] as? String {
                                            text = partText
                                            break
                                        }
                                        if let partDict = part as? [String: Any],
                                           let partText = partDict["text"] as? String {
                                            text = partText
                                            break
                                        }
                                    }
                                }
                            }
                            // Try direct text in content
                            if text == nil, let directText = content["text"] as? String {
                                text = directText
                            }
                            // Try content as string directly
                            if text == nil, let contentString = content["text"] as? String {
                                text = contentString
                            }
                        }
                        
                        // Alternative structure: direct text field in candidate
                        if text == nil, let directText = firstCandidate["text"] as? String {
                            text = directText
                        }
                        
                        // Another alternative: output field
                        if text == nil, let output = firstCandidate["output"] as? String {
                            text = output
                        }
                        
                        // Try message field
                        if text == nil, let message = firstCandidate["message"] as? [String: Any] {
                            if let messageText = message["text"] as? String {
                                text = messageText
                            }
                            if text == nil, let messageContent = message["content"] as? String {
                                text = messageContent
                            }
                            if text == nil, let messageParts = message["parts"] as? [[String: Any]] {
                                for part in messageParts {
                                    if let partText = part["text"] as? String {
                                        text = partText
                                        break
                                    }
                                }
                            }
                        }
                        
                        // Try parts array directly in candidate
                        if text == nil, let parts = firstCandidate["parts"] as? [[String: Any]] {
                            for part in parts {
                                if let extractedText = part["text"] as? String {
                                    text = extractedText
                                    break
                                }
                                if let extractedText = part["content"] as? String {
                                    text = extractedText
                                    break
                                }
                            }
                        }
                        
                        // Try nested structures
                        if text == nil {
                            // Try recursively searching for "text" key
                            func findText(in dict: [String: Any]) -> String? {
                                for (key, value) in dict {
                                    if key == "text", let stringValue = value as? String {
                                        return stringValue
                                    }
                                    if let nestedDict = value as? [String: Any], let found = findText(in: nestedDict) {
                                        return found
                                    }
                                    if let nestedArray = value as? [[String: Any]] {
                                        for item in nestedArray {
                                            if let found = findText(in: item) {
                                                return found
                                            }
                                        }
                                    }
                                }
                                return nil
                            }
                            text = findText(in: firstCandidate)
                        }
                        
                        guard let finalText = text, !finalText.isEmpty else {
                            // Log the full candidate structure for debugging
                            print("❌ Failed to extract text. Candidate structure:")
                            print("   Keys: \(Array(firstCandidate.keys))")
                            print("   Full candidate: \(firstCandidate)")
                            
                            // Try to provide a more helpful error message
                            if let content = firstCandidate["content"] {
                                print("   Content type: \(type(of: content))")
                                print("   Content value: \(content)")
                            }
                            
                            throw NSError(domain: "AIError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response format from API. The API response structure may have changed. Please try again."])
                        }
                        
                        print("Successfully extracted response text (length: \(finalText.count) characters)")
                        return finalText.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                    } catch let error as NSError {
                        // Check for cancellation
                        if error.domain == NSCocoaErrorDomain && error.code == NSUserCancelledError {
                            throw error
                        }
                        // If model not found (404), try next model
                        if error.code == 404 && modelName != modelNames.last {
                            lastError = error
                            break // Break out of retry loop to try next model
                        }
                        
                        // Retry on network errors or 5xx server errors with exponential backoff
                        if attempt < maxRetries {
                            let shouldRetry = error.code == NSURLErrorTimedOut ||
                                             error.code == NSURLErrorNetworkConnectionLost ||
                                             error.code == NSURLErrorNotConnectedToInternet ||
                                             error.code == NSURLErrorCannotFindHost ||
                                             error.code == NSURLErrorCannotConnectToHost ||
                                             error.code == NSURLErrorDNSLookupFailed ||
                                             (error.domain == "AIError" && error.code >= 500 && error.code < 600)
                            
                            if shouldRetry {
                                // Exponential backoff: 2^attempt seconds (1s, 2s, 4s, 8s)
                                let delay = pow(2.0, Double(attempt + 1))
                                print("Network error (code: \(error.code)). Retrying in \(delay) seconds (attempt \(attempt + 1)/\(maxRetries + 1))")
                                try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
                                continue
                            }
                        }
                        
                        // Don't retry for client errors (4xx) except 429 and 404
                        lastError = error
                        throw error
                    }
                }
            } catch let error as NSError {
                // If it's a 404 (model not found), try next model
                if error.code == 404 && modelName != modelNames.last {
                    lastError = error
                    continue // Try next model
                }
                throw error
            }
        }
        
        // If we get here, all models failed
        throw lastError ?? NSError(domain: "AIError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Request failed after trying all available models. Please check your API key and try again."])
    }
    
    // MARK: - Fallback Keyword-Based Responses
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
        if lowerQuestion.contains("planet") || lowerQuestion.contains("solar system") {
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
struct ChatMessage: Identifiable, Codable {
    let id: String
    let content: String
    let role: MessageRole
    let timestamp: Date
    
    enum MessageRole: String, Codable {
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
                    // Parse markdown for assistant messages, plain text for user messages
                    Group {
                        if message.role == .assistant {
                            parseMarkdown(message.content)
                                .font(.appBody)
                                .foregroundColor(.foreground)
                        } else {
                            Text(message.content)
                                .font(.appBody)
                                .foregroundColor(.white)
                        }
                    }
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
    
    // MARK: - Markdown Parsing
    private func parseMarkdown(_ text: String) -> Text {
        let parts = text.components(separatedBy: "**")
        var result = Text("")
        
        for (index, part) in parts.enumerated() {
            if index % 2 == 0 {
                // Regular text
                result = result + Text(part)
            } else {
                // Bold text (between **)
                result = result + Text(part).fontWeight(.semibold)
            }
        }
        
        return result
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

// MARK: - Chat History View
struct ChatHistoryView: View {
    let sessions: [ChatSession]
    let onSelectSession: (ChatSession) -> Void
    let onDismiss: () -> Void
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func getPreviewText(from session: ChatSession) -> String {
        // Get the first user message as preview
        if let firstUserMessage = session.messages.first(where: { $0.role == .user }) {
            return firstUserMessage.content
        }
        return "No messages"
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                if sessions.isEmpty {
                    VStack(spacing: Spacing.lg) {
                        Image(systemName: "clock")
                            .font(.system(size: 48))
                            .foregroundColor(.mutedForeground)
                        
                        Text("No Past Conversations")
                            .font(.appHeading)
                            .foregroundColor(.foreground)
                        
                        Text("Your conversation history will appear here")
                            .font(.appBody)
                            .foregroundColor(.mutedForeground)
                            .multilineTextAlignment(.center)
                    }
                    .padding(Spacing.xl)
                } else {
                    ScrollView {
                        VStack(spacing: Spacing.md) {
                            ForEach(sessions) { session in
                                Button(action: {
                                    onSelectSession(session)
                                }) {
                                    VStack(alignment: .leading, spacing: Spacing.sm) {
                                        HStack {
                                            Text(formatDate(session.createdAt))
                                                .font(.appSmall)
                                                .foregroundColor(.mutedForeground)
                                            
                                            Spacer()
                                            
                                            Text("\(session.messages.count) message\(session.messages.count == 1 ? "" : "s")")
                                                .font(.appSmall)
                                                .foregroundColor(.mutedForeground)
                                        }
                                        
                                        Text(getPreviewText(from: session))
                                            .font(.appBody)
                                            .foregroundColor(.foreground)
                                            .lineLimit(2)
                                            .multilineTextAlignment(.leading)
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
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(Spacing.lg)
                    }
                }
            }
            .navigationTitle("Chat History")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        onDismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AIStudyAssistantView(onNavigate: { _ in })
        .environmentObject(AppState())
        .preferredColorScheme(.dark)
}


