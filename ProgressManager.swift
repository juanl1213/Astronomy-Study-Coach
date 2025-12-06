//
//  ProgressManager.swift
//  Astronomy Study Coach
//
//  Manager class for tracking and persisting user progress
//

import Foundation

class ProgressManager {
    static let shared = ProgressManager()
    
    private init() {}
    
    // MARK: - User-Specific Storage Keys
    private func progressKey(for email: String) -> String {
        return "userProgress_\(email)"
    }
    
    // MARK: - Load User Progress
    func loadUserProgress(email: String) -> UserProgress? {
        guard let data = UserDefaults.standard.data(forKey: progressKey(for: email)),
              let progress = try? JSONDecoder().decode(UserProgress.self, from: data) else {
            return nil
        }
        return progress
    }
    
    // MARK: - Initialize Progress for New User
    func initializeProgress(for email: String) {
        // Check if this is the demo account
        if email == "astronomer@space.edu" {
            initializeDemoProgress(for: email)
        } else {
            let newProgress = UserProgress(
                email: email,
                completedLessons: [],
                completedQuizzes: [],
                quizResults: [],
                studyTime: 0,
                currentStreak: 0,
                longestStreak: 0,
                lastStudyDate: nil,
                topicProgress: [:],
                achievements: []
            )
            saveProgress(newProgress)
        }
    }
    
    // MARK: - Initialize Demo Progress with Dummy Data
    func initializeDemoProgress(for email: String) {
        // Check if progress exists and has data
        if let existingProgress = loadUserProgress(email: email),
           existingProgress.completedLessons.count > 0 {
            // Progress already exists with data, don't overwrite
            return
        }
        
        // Create sample completed lessons (42 lessons completed)
        let completedLessons = [
            "solar-system", "planets", "stars", "galaxies", "cosmology",
            "exoplanets", "black-holes", "nebulae", "asteroids", "space-exploration"
        ]
        
        // Create sample completed quizzes (18 quizzes completed)
        let completedQuizzes = [
            "solar-system", "planets", "stars", "galaxies", "cosmology",
            "exoplanets", "black-holes", "nebulae", "asteroids", "space-exploration"
        ]
        
        // Create sample quiz results
        let calendar = Calendar.current
        var quizResults: [QuizResult] = []
        
        // Add quiz results for completed quizzes
        let quizScores: [(String, Int, Int)] = [
            ("solar-system", 19, 20), // 95%
            ("planets", 17, 20), // 85%
            ("stars", 14, 20), // 70%
            ("galaxies", 18, 20), // 90%
            ("cosmology", 16, 20), // 80%
            ("telescopes-observation", 18, 20), // 90% (88% mentioned)
            ("space-exploration", 18, 20), // 90% (92% mentioned)
            ("stars", 15, 20), // 75% (72% mentioned)
        ]
        
        for (index, (quizId, score, total)) in quizScores.enumerated() {
            let date = calendar.date(byAdding: .day, value: -(index * 2), to: Date()) ?? Date()
            quizResults.append(QuizResult(
                id: UUID(),
                quizId: quizId,
                score: score,
                totalQuestions: total,
                percentage: Int((Double(score) / Double(total)) * 100),
                date: date,
                timeSpent: 600 + (index * 30) // 10-12 minutes per quiz
            ))
        }
        
        // Create topic progress matching the dummy data
        let topicProgress: [String: Int] = [
            "Solar System": 10, // 10 out of 12 lessons (85%)
            "Telescopes & Observation": 8, // 8 out of 10 lessons (75%)
            "Space Exploration": 8, // 8 out of 8 lessons (90%)
            "Stars & Stellar Evolution": 7, // 7 out of 15 lessons (45%)
            "Galaxies & Nebulae": 4, // 4 out of 18 lessons (25%)
            "Cosmology & Big Bang": 3, // 3 out of 20 lessons (15%)
            "Exoplanets": 1, // 1 out of 6 lessons (10%)
            "Black Holes & Relativity": 1 // 1 out of 12 lessons (5%)
        ]
        
        // Create demo progress with dummy data
        let demoProgress = UserProgress(
            email: email,
            completedLessons: completedLessons,
            completedQuizzes: completedQuizzes,
            quizResults: quizResults,
            studyTime: 1472, // 24h 32m in minutes
            currentStreak: 7,
            longestStreak: 12,
            lastStudyDate: calendar.date(byAdding: .day, value: -1, to: Date()),
            topicProgress: topicProgress,
            achievements: [1, 2, 3, 4] // Some achievements unlocked
        )
        
        saveProgress(demoProgress)
    }
    
    // MARK: - Save Progress
    private func saveProgress(_ progress: UserProgress) {
        if let encoded = try? JSONEncoder().encode(progress) {
            UserDefaults.standard.set(encoded, forKey: progressKey(for: progress.email))
        }
    }
    
    // MARK: - Lesson Completion
    func markLessonComplete(email: String, lessonId: String) {
        var progress = loadUserProgress(email: email) ?? UserProgress(email: email)
        
        if !progress.completedLessons.contains(lessonId) {
            progress.completedLessons.append(lessonId)
            updateTopicProgress(email: email, lessonId: lessonId)
            saveProgress(progress)
        }
    }
    
    func isLessonComplete(email: String, lessonId: String) -> Bool {
        return loadUserProgress(email: email)?.completedLessons.contains(lessonId) ?? false
    }
    
    // MARK: - Quiz Results
    func saveQuizResult(email: String, quizId: String, score: Int, totalQuestions: Int, timeSpent: Int) {
        var progress = loadUserProgress(email: email) ?? UserProgress(email: email)
        
        let result = QuizResult(
            id: UUID(),
            quizId: quizId,
            score: score,
            totalQuestions: totalQuestions,
            percentage: Int((Double(score) / Double(totalQuestions)) * 100),
            date: Date(),
            timeSpent: timeSpent
        )
        
        progress.quizResults.append(result)
        
        // Update completed quizzes if first time
        if !progress.completedQuizzes.contains(quizId) {
            progress.completedQuizzes.append(quizId)
        }
        
        saveProgress(progress)
    }
    
    func getQuizResults(email: String) -> [QuizResult] {
        return loadUserProgress(email: email)?.quizResults ?? []
    }
    
    // MARK: - Study Time Tracking
    func addStudyTime(email: String, minutes: Int) {
        var progress = loadUserProgress(email: email) ?? UserProgress(email: email)
        progress.studyTime += minutes
        updateStreak(email: email, progress: &progress)
        saveProgress(progress)
    }
    
    // MARK: - Streak Management
    private func updateStreak(email: String, progress: inout UserProgress) {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        if let lastDate = progress.lastStudyDate {
            let lastStudyDay = calendar.startOfDay(for: lastDate)
            let daysDifference = calendar.dateComponents([.day], from: lastStudyDay, to: today).day ?? 0
            
            if daysDifference == 1 {
                // Consecutive day
                progress.currentStreak += 1
            } else if daysDifference > 1 {
                // Streak broken
                progress.currentStreak = 1
            }
            // If daysDifference == 0, same day, don't update streak
        } else {
            // First study session
            progress.currentStreak = 1
        }
        
        if progress.currentStreak > progress.longestStreak {
            progress.longestStreak = progress.currentStreak
        }
        
        progress.lastStudyDate = Date()
    }
    
    // MARK: - Topic Progress
    private func updateTopicProgress(email: String, lessonId: String) {
        // Map lessonId to topic (e.g., "lesson-solar-system" -> "Solar System")
        let topic = mapLessonToTopic(lessonId: lessonId)
        var progress = loadUserProgress(email: email) ?? UserProgress(email: email)
        
        let currentCount = progress.topicProgress[topic] ?? 0
        progress.topicProgress[topic] = currentCount + 1
        
        saveProgress(progress)
    }
    
    private func mapLessonToTopic(lessonId: String) -> String {
        // Remove "lesson-" prefix if present
        let cleanId = lessonId.replacingOccurrences(of: "lesson-", with: "")
        
        // Map lesson IDs to topic names
        let mapping: [String: String] = [
            "solar-system": "Solar System",
            "planets": "Solar System",
            "stars": "Stars & Stellar Evolution",
            "galaxies": "Galaxies & Nebulae",
            "cosmology": "Cosmology & Big Bang",
            "exoplanets": "Exoplanets",
            "black-holes": "Black Holes & Relativity",
            "nebulae": "Galaxies & Nebulae",
            "asteroids": "Space Exploration",
            "space-exploration": "Space Exploration"
        ]
        return mapping[cleanId] ?? "Other"
    }
    
    // MARK: - Achievements
    func unlockAchievement(email: String, achievementId: Int) {
        var progress = loadUserProgress(email: email) ?? UserProgress(email: email)
        
        if !progress.achievements.contains(achievementId) {
            progress.achievements.append(achievementId)
            saveProgress(progress)
            // Could trigger notification here
        }
    }
    
    // MARK: - Get Overall Progress
    func getOverallProgress(email: String) -> OverallProgress {
        let progress = loadUserProgress(email: email) ?? UserProgress(email: email)
        
        // Calculate totals
        let totalLessons = 10 // Total number of lessons
        let totalQuizzes = 10 // Total number of quizzes
        let totalTopics = 8
        
        let completedTopics = Set(progress.topicProgress.values.map { $0 > 0 }).count
        
        return OverallProgress(
            totalTopics: totalTopics,
            completedTopics: completedTopics,
            totalLessons: totalLessons,
            completedLessons: progress.completedLessons.count,
            totalQuizzes: totalQuizzes,
            completedQuizzes: progress.completedQuizzes.count,
            studyTime: progress.studyTime,
            currentStreak: progress.currentStreak,
            longestStreak: progress.longestStreak
        )
    }
    
    // MARK: - Get Topic Progress
    func getTopicProgress(email: String) -> [TopicProgress] {
        let progress = loadUserProgress(email: email) ?? UserProgress(email: email)
        
        // Define all topics with their lesson counts
        let topics: [(String, Int)] = [
            ("Solar System", 12),
            ("Telescopes & Observation", 10),
            ("Space Exploration", 8),
            ("Stars & Stellar Evolution", 15),
            ("Galaxies & Nebulae", 18),
            ("Cosmology & Big Bang", 20),
            ("Exoplanets", 6),
            ("Black Holes & Relativity", 12)
        ]
        
        return topics.map { topicName, totalLessons in
            let completed = progress.topicProgress[topicName] ?? 0
            let progressPercent = totalLessons > 0 ? Int((Double(completed) / Double(totalLessons)) * 100) : 0
            
            // Get best quiz score for this topic
            let topicQuizzes = progress.quizResults.filter { result in
                let quizIdLower = result.quizId.lowercased()
                let topicLower = topicName.lowercased().replacingOccurrences(of: " ", with: "-")
                return quizIdLower.contains(topicLower) || quizIdLower.contains(topicName.lowercased().components(separatedBy: " ").first ?? "")
            }
            let bestQuizScore = topicQuizzes.map { $0.percentage }.max() ?? 0
            
            return TopicProgress(
                name: topicName,
                progress: progressPercent,
                lessons: totalLessons,
                completed: completed,
                quiz: bestQuizScore
            )
        }
    }
}

// MARK: - Data Models
struct UserProgress: Codable {
    var email: String
    var completedLessons: [String]
    var completedQuizzes: [String]
    var quizResults: [QuizResult]
    var studyTime: Int // in minutes
    var currentStreak: Int
    var longestStreak: Int
    var lastStudyDate: Date?
    var topicProgress: [String: Int] // Topic name -> completed lessons count
    var achievements: [Int] // Achievement IDs
    
    init(email: String, completedLessons: [String] = [], completedQuizzes: [String] = [],
         quizResults: [QuizResult] = [], studyTime: Int = 0, currentStreak: Int = 0,
         longestStreak: Int = 0, lastStudyDate: Date? = nil, topicProgress: [String: Int] = [:],
         achievements: [Int] = []) {
        self.email = email
        self.completedLessons = completedLessons
        self.completedQuizzes = completedQuizzes
        self.quizResults = quizResults
        self.studyTime = studyTime
        self.currentStreak = currentStreak
        self.longestStreak = longestStreak
        self.lastStudyDate = lastStudyDate
        self.topicProgress = topicProgress
        self.achievements = achievements
    }
}

struct QuizResult: Codable, Identifiable {
    let id: UUID
    let quizId: String
    let score: Int
    let totalQuestions: Int
    let percentage: Int
    let date: Date
    let timeSpent: Int // in seconds
}

// MARK: - Progress Data Models (matching existing ProgressView models)
struct OverallProgress {
    let totalTopics: Int
    let completedTopics: Int
    let totalLessons: Int
    let completedLessons: Int
    let totalQuizzes: Int
    let completedQuizzes: Int
    let studyTime: Int
    let currentStreak: Int
    let longestStreak: Int
}

struct TopicProgress {
    let name: String
    let progress: Int
    let lessons: Int
    let completed: Int
    let quiz: Int
}


