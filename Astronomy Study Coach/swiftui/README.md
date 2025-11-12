# SwiftUI Design Files

This folder contains SwiftUI implementations of the Astronomy Study Coach application's UI design, matching the React application's visual style and components.

## Files Overview

### DesignSystem.swift
The design system file that defines:
- **Colors**: Indigo to cyan gradient colors, background colors, text colors matching the React app
- **Gradients**: Primary gradient, text gradient, and background gradients
- **Typography**: Font styles and sizes
- **Spacing**: Consistent spacing values (xs, sm, md, lg, xl)
- **Corner Radius**: Standard corner radius values
- **Shadow Extensions**: Card and logo shadow modifiers

### LoginView.swift
The login screen featuring:
- Star logo with gradient background
- Email and password input fields with icons
- "Forgot password" link
- Sign in button with loading state
- Demo account quick login
- Link to sign up page
- Matches the React Login component design

### SignUpView.swift
The sign up screen featuring:
- Star logo with gradient background
- Full name, email, password, and confirm password fields
- Terms and conditions checkbox
- Password validation (minimum 8 characters)
- Create account button with loading state
- Link to login page
- Matches the React SignUp component design

### DashboardView.swift
The main dashboard screen featuring:
- Hero section with welcome message and gradient background
- Quick stats cards (Study Time, Quizzes, Streak, Topics)
- Study progress section with progress bars
- Recent achievements section
- Two-column responsive layout
- Matches the React Dashboard component design

### SettingsView.swift
The settings screen featuring:
- Tabbed interface (Profile, Notifications, Preferences, Security)
- Profile information form
- Notification toggles
- Theme selection (Light, Dark, System)
- App preferences toggles
- Security settings with password change
- Matches the React Settings component design

### AstronomyStudyCoachApp.swift
The main app entry point featuring:
- `@main` attribute for app initialization
- App state management using `ObservableObject`
- Dark theme preference matching the React app
- Centralized authentication and navigation state

### ContentView.swift
The main content view that handles:
- Navigation between all screens (Login, SignUp, Dashboard, Settings)
- Authentication state management
- Header navigation bar with logo and user menu
- Bottom tab bar for mobile devices
- Responsive layout for iPhone, iPad, and Mac
- Protected routes (requires authentication for dashboard/settings)

## Design Features

All views maintain consistency with the React application:

1. **Color Scheme**: Indigo (#6366f1) to Cyan (#06b6d4) gradients
2. **Dark Theme**: Dark background (#0a0e1a) with light text (#e8edf4)
3. **Card Design**: Rounded corners (16px), subtle borders, shadow effects
4. **Typography**: System fonts with consistent sizing
5. **Icons**: SF Symbols matching Lucide React icons where possible
6. **Spacing**: Consistent padding and margins throughout
7. **Interactive Elements**: Buttons, inputs, and toggles with proper states

## Usage

These SwiftUI files are ready to run as a complete iOS/macOS application. To use them:

1. Copy all files into your Xcode project
2. Ensure all files are added to your target
3. Set `AstronomyStudyCoachApp` as the app entry point (it has the `@main` attribute)
4. Build and run - the app will start with the login screen

### Quick Start

The app is fully integrated and ready to run:

1. **AstronomyStudyCoachApp.swift** - This is your main entry point. Xcode will automatically recognize it because of the `@main` attribute.

2. **ContentView.swift** - Handles all navigation and authentication logic automatically.

3. **AppState** - A shared `ObservableObject` that manages:
   - Authentication state
   - Current view navigation
   - User information (email, name)
   - Login/logout functionality

### Navigation Flow

```
App Launch
    ↓
LoginView (default)
    ↓
[User logs in or signs up]
    ↓
DashboardView (authenticated)
    ↓
[User can navigate to Settings or other views]
```

### Features

- **Automatic Authentication**: Login and signup automatically authenticate and navigate to dashboard
- **Protected Routes**: Dashboard and Settings require authentication
- **State Management**: Centralized app state using `@EnvironmentObject`
- **Responsive Design**: Adapts to iPhone, iPad, and Mac with appropriate navigation
- **Dark Theme**: Matches the React app's dark theme by default

## Notes

- All views use the shared `DesignSystem.swift` for consistent styling
- Views are designed to be responsive and work on different screen sizes
- The design matches the React application's visual appearance as closely as possible
- Some functionality (like actual authentication) would need to be implemented separately
- Images and assets referenced in the React app would need to be added to the iOS project

