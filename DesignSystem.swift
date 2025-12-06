//
//  DesignSystem.swift
//  Astronomy Study Coach
//
//  Design system matching the React application's UI
//

import SwiftUI

// MARK: - Colors
extension Color {
    // Primary gradient colors (Indigo to Cyan) - same for both modes
    static let indigo600 = Color(red: 0.388, green: 0.404, blue: 0.945) // #6366f1
    static let cyan600 = Color(red: 0.024, green: 0.714, blue: 0.831) // #06b6d4
    static let indigo400 = Color(red: 0.557, green: 0.573, blue: 0.973) // #818cf8
    static let cyan400 = Color(red: 0.133, green: 0.827, blue: 0.933) // #22d3ee
    
    // Background colors - adapt to color scheme
    static var background: Color {
        Color(light: Color(red: 0.98, green: 0.98, blue: 0.99), dark: Color(red: 0.039, green: 0.055, blue: 0.102))
    }
    
    static var cardBackground: Color {
        Color(light: Color.white, dark: Color(red: 0.059, green: 0.078, blue: 0.098))
    }
    
    static var mutedBackground: Color {
        Color(light: Color(red: 0.95, green: 0.96, blue: 0.97), dark: Color(red: 0.118, green: 0.161, blue: 0.231))
    }
    
    // Text colors - adapt to color scheme with proper contrast
    static var foreground: Color {
        Color(light: Color(red: 0.1, green: 0.1, blue: 0.15), dark: Color(red: 0.910, green: 0.929, blue: 0.957))
    }
    
    static var mutedForeground: Color {
        Color(light: Color(red: 0.4, green: 0.4, blue: 0.45), dark: Color(red: 0.580, green: 0.639, blue: 0.722))
    }
    
    // Border colors - adapt to color scheme
    static var border: Color {
        Color(light: Color(red: 0.85, green: 0.85, blue: 0.9), dark: Color(red: 0.118, green: 0.161, blue: 0.231))
    }
    
    // Input colors - adapt to color scheme
    static var inputBackground: Color {
        Color(light: Color(red: 0.96, green: 0.97, blue: 0.98), dark: Color(red: 0.118, green: 0.161, blue: 0.231))
    }
    
    // Helper initializer for light/dark mode colors
    init(light: Color, dark: Color) {
        #if os(iOS)
        self.init(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .light, .unspecified:
                return UIColor(light)
            case .dark:
                return UIColor(dark)
            @unknown default:
                return UIColor(light)
            }
        })
        #else
        self = light // Fallback for other platforms
        #endif
    }
}

// MARK: - Gradients
extension LinearGradient {
    static var primaryGradient: LinearGradient {
        LinearGradient(
            colors: [Color.indigo600, Color.cyan600],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    static var textGradient: LinearGradient {
        LinearGradient(
            colors: [Color.indigo400, Color.cyan400],
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    static var backgroundGradient: LinearGradient {
        LinearGradient(
            colors: [Color(red: 0.039, green: 0.055, blue: 0.102), Color(red: 0.039, green: 0.055, blue: 0.102).opacity(0.9)],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

// MARK: - Shadows
extension View {
    func cardShadow() -> some View {
        self.shadow(color: Color.indigo600.opacity(0.2), radius: 10, x: 0, y: 4)
    }
    
    func logoShadow() -> some View {
        self.shadow(color: Color.indigo600.opacity(0.3), radius: 8, x: 0, y: 2)
    }
}

// MARK: - Typography
extension Font {
    // Dynamic fonts that scale with user's accessibility settings
    static let appTitle = Font.system(.title, design: .rounded).weight(.bold)
    static let appHeading = Font.system(.title2, design: .rounded).weight(.semibold)
    static let appBody = Font.system(.body, design: .rounded)
    static let appCaption = Font.system(.subheadline, design: .rounded)
    static let appSmall = Font.system(.caption, design: .rounded)
    
    // Fixed sizes for specific use cases (icons, etc.)
    static func appIcon(size: CGFloat) -> Font {
        Font.system(size: size, weight: .regular, design: .rounded)
    }
}

// MARK: - Spacing
struct Spacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    
    // Responsive spacing that adapts to screen size
    @MainActor
    static func responsive(_ base: CGFloat) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        // Scale down slightly on smaller screens (iPhone SE, etc.)
        if screenWidth < 375 {
            return base * 0.9
        }
        return base
    }
}

// MARK: - Corner Radius
struct CornerRadius {
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 20
}


