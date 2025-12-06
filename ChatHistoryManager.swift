//
//  ChatHistoryManager.swift
//  AstronomyStudyCoach
//
//  Created by user on 12/3/25.
//


import Foundation

class ChatHistoryManager {
    static let shared = ChatHistoryManager()
    
    private init() {}
    
    // MARK: - User-Specific Storage Keys
    private func chatHistoryKey(for email: String) -> String {
        return "chatHistory_\(email)"
    }
    
    // MARK: - Load Chat History
    func loadChatHistory(email: String) -> [ChatSession] {
        guard let data = UserDefaults.standard.data(forKey: chatHistoryKey(for: email)),
              let sessions = try? JSONDecoder().decode([ChatSession].self, from: data) else {
            return []
        }
        return sessions
    }
    
    // MARK: - Save Chat History
    private func saveChatHistory(email: String, sessions: [ChatSession]) {
        if let encoded = try? JSONEncoder().encode(sessions) {
            UserDefaults.standard.set(encoded, forKey: chatHistoryKey(for: email))
        }
    }
    
    // MARK: - Get Most Recent Chat Session
    func getMostRecentChatSession(email: String) -> ChatSession? {
        let sessions = loadChatHistory(email: email)
        return sessions.first // Most recent is first in the array
    }
    
    // MARK: - Save Current Chat Session
    func saveChatSession(email: String, messages: [ChatMessage]) {
        // Filter out the initial greeting message
        let conversationMessages = messages.filter { message in
            // Keep all messages except the initial greeting
            !(message.role == .assistant && message.id == "1")
        }
        
        // Only save if there are actual conversation messages (user messages)
        guard conversationMessages.contains(where: { $0.role == .user }) else {
            return
        }
        
        var sessions = loadChatHistory(email: email)
        
        // Check if we should create a new session or update existing
        // Create new session if:
        // 1. No sessions exist
        // 2. Most recent session is older than 24 hours (new day = new session)
        let shouldCreateNewSession: Bool
        if sessions.isEmpty {
            shouldCreateNewSession = true
        } else if let mostRecent = sessions.first {
            let hoursSinceLastUpdate = Calendar.current.dateComponents([.hour], from: mostRecent.lastUpdated, to: Date()).hour ?? 0
            shouldCreateNewSession = hoursSinceLastUpdate >= 24
        } else {
            shouldCreateNewSession = true
        }
        
        if shouldCreateNewSession {
            // Create new session with current messages
            let newSession = ChatSession(
                id: UUID().uuidString,
                messages: conversationMessages,
                createdAt: Date(),
                lastUpdated: Date()
            )
            
            // Add to beginning of array (most recent first)
            sessions.insert(newSession, at: 0)
        } else {
            // Update most recent session
            var mostRecent = sessions[0]
            mostRecent.messages = conversationMessages
            mostRecent.lastUpdated = Date()
            sessions[0] = mostRecent
        }
        
        // Keep only the 3 most recent sessions
        if sessions.count > 3 {
            sessions = Array(sessions.prefix(3))
        }
        
        saveChatHistory(email: email, sessions: sessions)
    }
    
    // MARK: - Update Current Chat Session
    func updateCurrentChatSession(email: String, messages: [ChatMessage]) {
        var sessions = loadChatHistory(email: email)
        
        // If no sessions exist, create a new one
        if sessions.isEmpty {
            saveChatSession(email: email, messages: messages)
            return
        }
        
        // Update the most recent session
        var mostRecent = sessions[0]
        
        // Filter out the initial greeting message
        let conversationMessages = messages.filter { message in
            !(message.role == .assistant && message.id == "1")
        }
        
        mostRecent.messages = conversationMessages
        mostRecent.lastUpdated = Date()
        
        sessions[0] = mostRecent
        saveChatHistory(email: email, sessions: sessions)
    }
    
    // MARK: - Get All Chat Sessions (for history view)
    func getAllChatSessions(email: String) -> [ChatSession] {
        return loadChatHistory(email: email)
    }
    
    // MARK: - Clear Chat History
    func clearChatHistory(email: String) {
        UserDefaults.standard.removeObject(forKey: chatHistoryKey(for: email))
    }
}

// MARK: - Data Models
struct ChatSession: Codable, Identifiable {
    let id: String
    var messages: [ChatMessage]
    let createdAt: Date
    var lastUpdated: Date
}


