//
//  SettingsView.swift
//  Astronomy Study Coach
//
//  Settings screen matching the React application design
//

import SwiftUI

struct SettingsView: View {
    @State private var selectedTab: SettingsTab = .profile
    @State private var profile = ProfileData()
    @State private var notifications = NotificationSettings()
    @State private var preferences = Preferences()
    @State private var showSaveAlert = false
    
    var onNavigate: ((String) -> Void)?
    var userEmail: String = "astronomer@space.edu"
    var userName: String = "Space Explorer"
    
    enum SettingsTab: String, CaseIterable {
        case profile = "Profile"
        case notifications = "Notifications"
        case preferences = "Preferences"
        case security = "Security"
        
        var icon: String {
            switch self {
            case .profile: return "person.fill"
            case .notifications: return "bell.fill"
            case .preferences: return "paintbrush.fill"
            case .security: return "shield.fill"
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        Text("Settings")
                            .font(.appTitle)
                            .foregroundColor(.foreground)
                        
                        Text("Manage your account settings and preferences")
                            .font(.appCaption)
                            .foregroundColor(.mutedForeground)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        onNavigate?("dashboard")
                    }) {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("Back to Dashboard")
                        }
                        .font(.appBody)
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
                }
                .padding(Spacing.lg)
                
                // Tabs
                HStack(spacing: 0) {
                    ForEach(SettingsTab.allCases, id: \.self) { tab in
                        Button(action: {
                            selectedTab = tab
                        }) {
                            HStack(spacing: Spacing.sm) {
                                Image(systemName: tab.icon)
                                    .font(.system(size: 14))
                                Text(tab.rawValue)
                                    .font(.appBody)
                            }
                            .foregroundColor(selectedTab == tab ? .white : .mutedForeground)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, Spacing.md)
                            .background(selectedTab == tab ? LinearGradient.primaryGradient : Color.clear)
                        }
                    }
                }
                .background(Color.cardBackground)
                .cornerRadius(CornerRadius.md)
                .overlay(
                    RoundedRectangle(cornerRadius: CornerRadius.md)
                        .stroke(Color.border, lineWidth: 1)
                )
                .padding(.horizontal, Spacing.lg)
                .padding(.bottom, Spacing.lg)
                
                // Tab Content
                ScrollView {
                    VStack(spacing: Spacing.lg) {
                        switch selectedTab {
                        case .profile:
                            ProfileTabContent(profile: $profile, onSave: {
                                showSaveAlert = true
                            })
                        case .notifications:
                            NotificationsTabContent(notifications: $notifications)
                        case .preferences:
                            PreferencesTabContent(preferences: $preferences)
                        case .security:
                            SecurityTabContent()
                        }
                    }
                    .padding(Spacing.lg)
                }
            }
        }
        .alert("Success", isPresented: $showSaveAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Profile updated successfully!")
        }
    }
}

// MARK: - Profile Tab
struct ProfileTabContent: View {
    @Binding var profile: ProfileData
    var onSave: () -> Void
    
    var body: some View {
        VStack(spacing: Spacing.lg) {
            // Profile Information Card
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text("Profile Information")
                    .font(.appHeading)
                    .foregroundColor(.foreground)
                
                Text("Update your personal information and profile details")
                    .font(.appCaption)
                    .foregroundColor(.mutedForeground)
                
                VStack(spacing: Spacing.md) {
                    // Name Field
                    FormField(label: "Full Name", icon: "person", text: $profile.name, placeholder: "Enter your name")
                    
                    // Email Field
                    FormField(label: "Email", icon: "envelope", text: $profile.email, placeholder: "Enter your email")
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    // Bio Field
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        Text("Bio")
                            .font(.appBody)
                            .foregroundColor(.foreground)
                        
                        TextEditor(text: $profile.bio)
                            .frame(height: 100)
                            .padding(Spacing.sm)
                            .background(Color.inputBackground)
                            .cornerRadius(CornerRadius.md)
                            .overlay(
                                RoundedRectangle(cornerRadius: CornerRadius.md)
                                    .stroke(Color.border, lineWidth: 1)
                            )
                            .foregroundColor(.foreground)
                    }
                    
                    // Location Field
                    FormField(label: "Location", icon: "mappin", text: $profile.location, placeholder: "Enter your location")
                }
                .padding(.top, Spacing.sm)
                
                Button(action: onSave) {
                    HStack {
                        Image(systemName: "checkmark")
                        Text("Save Changes")
                    }
                    .font(.appBody)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(Spacing.md)
                    .background(LinearGradient.primaryGradient)
                    .cornerRadius(CornerRadius.md)
                }
                .padding(.top, Spacing.md)
            }
            .padding(Spacing.lg)
            .background(Color.cardBackground)
            .cornerRadius(CornerRadius.lg)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.lg)
                    .stroke(Color.border, lineWidth: 1)
            )
        }
    }
}

// MARK: - Notifications Tab
struct NotificationsTabContent: View {
    @Binding var notifications: NotificationSettings
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Notification Preferences")
                .font(.appHeading)
                .foregroundColor(.foreground)
            
            Text("Choose what notifications you want to receive")
                .font(.appCaption)
                .foregroundColor(.mutedForeground)
            
            VStack(spacing: Spacing.md) {
                ToggleRow(title: "Email Notifications", isOn: $notifications.emailNotifications)
                ToggleRow(title: "Quiz Reminders", isOn: $notifications.quizReminders)
                ToggleRow(title: "Achievement Alerts", isOn: $notifications.achievementAlerts)
                ToggleRow(title: "Weekly Progress Reports", isOn: $notifications.weeklyProgress)
                ToggleRow(title: "Study Streak Reminders", isOn: $notifications.studyStreaks)
            }
            .padding(.top, Spacing.sm)
        }
        .padding(Spacing.lg)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.lg)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.lg)
                .stroke(Color.border, lineWidth: 1)
        )
    }
}

// MARK: - Preferences Tab
struct PreferencesTabContent: View {
    @Binding var preferences: Preferences
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("App Preferences")
                .font(.appHeading)
                .foregroundColor(.foreground)
            
            VStack(spacing: Spacing.lg) {
                // Theme Selection
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text("Theme")
                        .font(.appBody)
                        .foregroundColor(.foreground)
                    
                    HStack(spacing: Spacing.md) {
                        ThemeOption(icon: "sun.max.fill", title: "Light", isSelected: preferences.theme == "light") {
                            preferences.theme = "light"
                        }
                        
                        ThemeOption(icon: "moon.fill", title: "Dark", isSelected: preferences.theme == "dark") {
                            preferences.theme = "dark"
                        }
                        
                        ThemeOption(icon: "display", title: "System", isSelected: preferences.theme == "system") {
                            preferences.theme = "system"
                        }
                    }
                }
                
                // Other Preferences
                VStack(spacing: Spacing.md) {
                    ToggleRow(title: "Auto-play Videos", isOn: $preferences.autoPlay)
                    ToggleRow(title: "Sound Effects", isOn: $preferences.soundEffects)
                    ToggleRow(title: "Animations", isOn: $preferences.animations)
                }
            }
            .padding(.top, Spacing.sm)
        }
        .padding(Spacing.lg)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.lg)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.lg)
                .stroke(Color.border, lineWidth: 1)
        )
    }
}

// MARK: - Security Tab
struct SecurityTabContent: View {
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Security Settings")
                .font(.appHeading)
                .foregroundColor(.foreground)
            
            Text("Manage your account security and password")
                .font(.appCaption)
                .foregroundColor(.mutedForeground)
            
            VStack(spacing: Spacing.md) {
                FormField(label: "Current Password", icon: "lock", text: $currentPassword, placeholder: "Enter current password", isSecure: true)
                
                FormField(label: "New Password", icon: "lock.fill", text: $newPassword, placeholder: "Enter new password", isSecure: true)
                
                FormField(label: "Confirm New Password", icon: "lock.fill", text: $confirmPassword, placeholder: "Confirm new password", isSecure: true)
                
                Button(action: {
                    // Handle password change
                }) {
                    HStack {
                        Image(systemName: "key.fill")
                        Text("Update Password")
                    }
                    .font(.appBody)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(Spacing.md)
                    .background(LinearGradient.primaryGradient)
                    .cornerRadius(CornerRadius.md)
                }
                .padding(.top, Spacing.sm)
            }
            .padding(.top, Spacing.sm)
        }
        .padding(Spacing.lg)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.lg)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.lg)
                .stroke(Color.border, lineWidth: 1)
        )
    }
}

// MARK: - Supporting Views
struct FormField: View {
    let label: String
    let icon: String
    @Binding var text: String
    let placeholder: String
    var isSecure: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(label)
                .font(.appBody)
                .foregroundColor(.foreground)
            
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.mutedForeground)
                    .frame(width: 20)
                
                if isSecure {
                    SecureField(placeholder, text: $text)
                        .foregroundColor(.foreground)
                } else {
                    TextField(placeholder, text: $text)
                        .foregroundColor(.foreground)
                }
            }
            .padding(Spacing.md)
            .background(Color.inputBackground)
            .cornerRadius(CornerRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.md)
                    .stroke(Color.border, lineWidth: 1)
            )
        }
    }
}

struct ToggleRow: View {
    let title: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .font(.appBody)
                .foregroundColor(.foreground)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .tint(.indigo600)
        }
        .padding(Spacing.md)
        .background(Color.inputBackground)
        .cornerRadius(CornerRadius.md)
    }
}

struct ThemeOption: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: Spacing.sm) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .white : .mutedForeground)
                
                Text(title)
                    .font(.appSmall)
                    .foregroundColor(isSelected ? .white : .mutedForeground)
            }
            .frame(maxWidth: .infinity)
            .padding(Spacing.md)
            .background(isSelected ? LinearGradient.primaryGradient : Color.inputBackground)
            .cornerRadius(CornerRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.md)
                    .stroke(isSelected ? Color.clear : Color.border, lineWidth: 1)
            )
        }
    }
}

// MARK: - Data Models
struct ProfileData {
    var name: String = "Space Explorer"
    var email: String = "astronomer@space.edu"
    var bio: String = "Passionate about exploring the wonders of the universe"
    var location: String = "Earth, Milky Way Galaxy"
}

struct NotificationSettings {
    var emailNotifications: Bool = true
    var quizReminders: Bool = true
    var achievementAlerts: Bool = true
    var weeklyProgress: Bool = false
    var studyStreaks: Bool = true
}

struct Preferences {
    var theme: String = "dark"
    var language: String = "english"
    var autoPlay: Bool = false
    var soundEffects: Bool = true
    var animations: Bool = true
}

#Preview {
    SettingsView()
}

