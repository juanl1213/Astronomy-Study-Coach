//
//  UserManager.swift
//  AstronomyStudyCoach
//
//  Created by user on 12/3/25.
//


import Foundation

class UserManager {
    static let shared = UserManager()
    
    private let registeredUsersKey = "registeredUsers"
    private let keychainManager = KeychainManager.shared
    
    private init() {}
    
    // MARK: - Register User
    func registerUser(email: String, name: String, password: String) -> Bool {
        // Validate email format (basic)
        guard isValidEmail(email) else {
            return false
        }
        
        // Validate password length
        guard password.count >= 8 else {
            return false
        }
        
        // Check if user already exists
        guard !userExists(email: email) else {
            return false
        }
        
        // Save password to Keychain
        guard keychainManager.savePassword(password, for: email) else {
            return false
        }
        
        // Save user data to UserDefaults
        var users = getRegisteredUsers()
        let newUser: [String: String] = [
            "email": email,
            "name": name
        ]
        users.append(newUser)
        
        if let encoded = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encoded, forKey: registeredUsersKey)
            return true
        }
        
        return false
    }
    
    // MARK: - Validate Login
    func validateLogin(email: String, password: String) -> Bool {
        guard let storedPassword = keychainManager.getPassword(for: email) else {
            return false
        }
        
        return storedPassword == password
    }
    
    // MARK: - Check User Exists
    func userExists(email: String) -> Bool {
        let users = getRegisteredUsers()
        return users.contains { $0["email"]?.lowercased() == email.lowercased() }
    }
    
    // MARK: - Get User Name
    func getUserName(email: String) -> String? {
        let users = getRegisteredUsers()
        return users.first { $0["email"]?.lowercased() == email.lowercased() }?["name"]
    }
    
    // MARK: - Get Registered Users
    private func getRegisteredUsers() -> [[String: String]] {
        guard let data = UserDefaults.standard.data(forKey: registeredUsersKey),
              let users = try? JSONDecoder().decode([[String: String]].self, from: data) else {
            return []
        }
        return users
    }
    
    // MARK: - Email Validation
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}


