//
//  SettingsView.swift
//  Astronomy Study Coach


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
                headerSection
                tabsSection
                tabContentSection
            }
        }
        .alert("Success", isPresented: $showSaveAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Profile updated successfully!")
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
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
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 13, weight: .medium))
                    if UIDevice.current.userInterfaceIdiom != .phone {
                        Text("Back to Dashboard")
                            .font(.appCaption)
                            .fontWeight(.medium)
                    }
                }
                .foregroundColor(.foreground)
                .padding(.horizontal, Spacing.sm)
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
    }
    
    // MARK: - Tabs Section
    private var tabsSection: some View {
        HStack(spacing: 0) {
            ForEach(SettingsTab.allCases, id: \.self) { tab in
                tabButton(for: tab)
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
    }
    
    private func tabButton(for tab: SettingsTab) -> some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: 4) {
                Image(systemName: tab.icon)
                    .font(.system(size: 16, weight: .medium))
                Text(tab.rawValue)
                    .font(.appSmall)
                    .fontWeight(.medium)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .foregroundColor(selectedTab == tab ? .white : .mutedForeground)
            .frame(maxWidth: .infinity)
            .padding(.vertical, Spacing.sm)
            .background(tabBackground(for: tab))
        }
    }
    
    private func tabBackground(for tab: SettingsTab) -> AnyShapeStyle {
        if selectedTab == tab {
            return AnyShapeStyle(LinearGradient.primaryGradient)
        } else {
            return AnyShapeStyle(Color.clear)
        }
    }
    
    // MARK: - Tab Content Section
    private var tabContentSection: some View {
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
                    FormField(label: "Full Name", icon: "person", text: $profile.name, placeholder: "Enter your name")
                    FormField(label: "Email", icon: "envelope", text: $profile.email, placeholder: "Enter your email")
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        Text("Bio")
                            .font(.appBody)
                            .foregroundColor(.foreground)
                        
                        ZStack(alignment: .topLeading) {
                            if profile.bio.isEmpty {
                                Text("Enter your bio...")
                                    .font(.appBody)
                                    .foregroundColor(.mutedForeground)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 8)
                            }
                            
                            TextEditor(text: $profile.bio)
                                .frame(height: 100)
                                .scrollContentBackground(.hidden)
                                .padding(Spacing.sm)
                                .background(Color.inputBackground)
                                .foregroundColor(.foreground)
                        }
                        .background(Color.inputBackground)
                        .cornerRadius(CornerRadius.md)
                        .overlay(
                            RoundedRectangle(cornerRadius: CornerRadius.md)
                                .stroke(Color.border, lineWidth: 1)
                        )
                    }
                    
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
            
            // Learning Stats Card
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text("Learning Stats")
                    .font(.appHeading)
                    .foregroundColor(.foreground)
                
                Text("Your astronomy learning journey overview")
                    .font(.appCaption)
                    .foregroundColor(.mutedForeground)
                
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: Spacing.md),
                    GridItem(.flexible(), spacing: Spacing.md)
                ], spacing: Spacing.md) {
                    LearningStatItem(label: "Member Since", value: "September 2025")
                    LearningStatItem(label: "Total Study Time", value: "24h 32m")
                    LearningStatItem(label: "Quizzes Completed", value: "18")
                    LearningStatItem(label: "Current Level", value: "Explorer")
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
}

// MARK: - Learning Stats Item
struct LearningStatItem: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(label)
                .font(.appCaption)
                .foregroundColor(.mutedForeground)
            
            Text(value)
                .font(.appBody)
                .fontWeight(.medium)
                .foregroundColor(.foreground)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
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
    @State private var showDeleteAlert: Bool = false
    
    var body: some View {
        VStack(spacing: Spacing.lg) {
            // Password & Security Card
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text("Password & Security")
                    .font(.appHeading)
                    .foregroundColor(.foreground)
                
                Text("Manage your password and account security")
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
            
            // Account Actions Card
            VStack(alignment: .leading, spacing: Spacing.md) {
                Text("Account Actions")
                    .font(.appHeading)
                    .foregroundColor(.foreground)
                
                Text("Manage your account status")
                    .font(.appCaption)
                    .foregroundColor(.mutedForeground)
                
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text("Delete Account")
                        .font(.appBody)
                        .fontWeight(.medium)
                        .foregroundColor(.foreground)
                    
                    Text("Once you delete your account, there is no going back. All your progress and data will be permanently deleted.")
                        .font(.appCaption)
                        .foregroundColor(.mutedForeground)
                    
                    Button(role: .destructive, action: {
                        showDeleteAlert = true
                    }) {
                        Text("Delete Account")
                            .font(.appBody)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(Spacing.md)
                            .background(Color.red)
                            .cornerRadius(CornerRadius.md)
                    }
                    .padding(.top, Spacing.xs)
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
        .alert("Delete Account", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                // Handle account deletion
            }
        } message: {
            Text("Are you sure you want to delete your account? This action cannot be undone.")
        }
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
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(isSelected ? .white : .mutedForeground)
                
                Text(title)
                    .font(.appCaption)
                    .fontWeight(.medium)
                    .foregroundColor(isSelected ? .white : .mutedForeground)
            }
            .frame(maxWidth: .infinity)
            .padding(Spacing.md)
            .background(isSelected ? AnyShapeStyle(LinearGradient.primaryGradient) : AnyShapeStyle(Color.inputBackground))
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


