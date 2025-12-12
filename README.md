
# Astro Learn - Astronomy Study Coach

A comprehensive iOS application built with SwiftUI for learning astronomy through interactive lessons, quizzes, flashcards, and an AI-powered study assistant.

## 📱 App Overview

Astro Learn is an educational astronomy app designed to help users explore and learn about the cosmos. The app features interactive lessons, quizzes, flashcards, progress tracking, and an AI-powered study assistant powered by Google's Gemini API.

### Key Features

- **📚 Interactive Lessons**: Comprehensive lessons covering topics like the Solar System, Planets, Stars, Galaxies, Black Holes, and more
- **🎯 Quizzes**: Test your knowledge with topic-specific quizzes and track your scores
- **🧠 Flashcards**: Study with customizable flashcard sets
- **🤖 AI Study Assistant**: Get instant answers to astronomy questions using Google Gemini AI
- **📊 Progress Tracking**: Monitor your learning progress, study streaks, and achievements
- **⭐ Constellations Guide**: Explore constellations with detailed information
- **🔍 Global Search**: Search across all content types (lessons, quizzes, flashcards, glossary, constellations)
- **📰 Dynamic Content**: Real-time astronomy news and daily Astronomy Picture of the Day (APOD) from NASA
- **🎨 Modern UI**: Beautiful, dark-themed interface with smooth animations


## 🚀 Setup Instructions

### Prerequisites

- **Xcode 14.0 or later**
- **iOS 16.0 or later** (for deployment target)
- **macOS 13.0 or later** (for development)
- **Google Gemini API Key** (for AI Study Assistant feature)

### Step 1: Clone the Repository

```bash
cd "/Users/user/Documents/Astronomy-Study-Coach"
```

### Step 2: Open in Xcode

1. Open Xcode
2. Select `File > Open`
3. Navigate to the project directory
4. Open the `.xcodeproj` or `.xcworkspace` file (if using CocoaPods)


### Step 3: Configure Signing & Capabilities

1. Select your project in Xcode
2. Go to the **Signing & Capabilities** tab
3. Select your development team
4. Ensure **Keychain Sharing** capability is enabled (for password storage)

### Step 4: Build and Run

1. Select your target device or simulator
2. Press `Cmd + R` or click the **Run** button
3. The app should build and launch

## 🔑 Demo Account

For testing purposes, a demo account is available:

- **Email**: `astronomer@space.edu`
- **Password**: Any password (demo account bypasses validation)

This account comes pre-populated with:
- Completed lessons and quizzes
- Study progress data
- Quiz history
- Sample achievements

## 📦 Dependencies

The app uses only native iOS frameworks:

- **SwiftUI**: UI framework
- **Foundation**: Core functionality
- **Combine**: Reactive programming (via SwiftUI)
- **Security**: Keychain Services for password storage
- **URLSession**: Network requests for NASA APIs and Gemini AI

No external dependencies or package managers required!

## 🌐 External APIs

### NASA APIs

The app fetches real-time content from NASA's public APIs:

- **APOD API**: Astronomy Picture of the Day (daily updates)
  - Endpoint: `https://api.nasa.gov/planetary/apod`
  - No API key required (uses DEMO_KEY)
  
- **NASA Search API**: Astronomy articles and images
  - Endpoint: `https://images-api.nasa.gov/search`
  - No API key required

### Google Gemini API

- **Endpoint**: `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent`
- **API Key Required**: Yes (see Setup Step 3)
- **Usage**: AI Study Assistant for answering astronomy questions

## 🎨 Design System

The app uses a custom design system defined in `Design/DesignSystem.swift`:

- **Colors**: Dark theme with indigo/cyan accents
- **Typography**: Custom font styles (`.appHeading`, `.appBody`, `.appCaption`, etc.)
- **Spacing**: Consistent spacing scale
- **Corner Radius**: Standardized border radius values
- **Gradients**: Reusable gradient definitions

## 💾 Data Persistence

The app uses the following storage mechanisms:

- **UserDefaults**: User profiles, progress data, flashcard sets, chat history
- **Keychain**: Secure password storage
- **Codable**: JSON encoding/decoding for complex data structures

All data is stored locally on the device.

## 🔐 Security

- Passwords are stored securely using iOS Keychain Services
- User data is isolated per account
- API keys should be kept secure (not committed to version control)

## 🧪 Testing

### Demo Account Testing

1. Log in with `astronomer@space.edu`
2. Explore pre-populated content
3. Test all features with existing data

### New User Testing

1. Create a new account via Sign Up
2. Start with empty progress
3. Complete lessons and quizzes to see progress tracking

## 🐛 Troubleshooting

### Build Errors

- **"No such module"**: Ensure all files are included in the target
- **Signing errors**: Check your development team and provisioning profile
- **API errors**: Verify your Gemini API key is correct and has proper permissions

### Runtime Issues

- **AI Chat not working**: Check API key configuration and internet connection
- **NASA content not loading**: Verify internet connection
- **Progress not saving**: Check UserDefaults permissions

### Common Issues

1. **API Key Issues**
   - Ensure the Gemini API key is correctly set
   - Check API key has proper permissions
   - Verify internet connectivity

2. **Data Not Persisting**
   - Check UserDefaults is accessible
   - Verify Keychain access permissions
   - Ensure proper app state management

## 📝 Notes

- The app uses a singleton pattern for managers (`UserManager`, `ProgressManager`, etc.)
- All managers are thread-safe and use `@MainActor` for UI updates
- The app supports both iPhone and iPad layouts
- Dark mode is the default theme


---



