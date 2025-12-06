//
//  AppLogo.swift
//  Astronomy Study Coach
//
//  Reusable app logo component with enhanced visual design
//

import SwiftUI

struct AppLogo: View {
    let size: CGFloat
    let showSparkles: Bool
    
    init(size: CGFloat = 28, showSparkles: Bool = true) {
        self.size = size
        self.showSparkles = showSparkles
    }
    
    var body: some View {
        ZStack {
            // Outer glow layer (contained within bounds)
            RoundedRectangle(cornerRadius: size * 0.35)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.indigo600.opacity(0.2),
                            Color.cyan600.opacity(0.15)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: size, height: size)
                .blur(radius: size * 0.15)
            
            // Main gradient background
            RoundedRectangle(cornerRadius: size * 0.35)
                .fill(LinearGradient.primaryGradient)
                .frame(width: size, height: size)
                .overlay(
                    // Inner highlight for depth
                    RoundedRectangle(cornerRadius: size * 0.35)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.3),
                                    Color.clear
                                ],
                                startPoint: .topLeading,
                                endPoint: .center
                            )
                        )
                )
                .logoShadow()
            
            // Sparkles around the star (for larger sizes, contained within square)
            if showSparkles && size >= 40 {
                ForEach(0..<6, id: \.self) { index in
                    let angle = Double(index) * (2 * .pi / 6)
                    // Reduce radius to keep sparkles within bounds (accounting for sparkle size)
                    let radius = size * 0.4
                    let x = cos(angle) * radius
                    let y = sin(angle) * radius
                    
                    Circle()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: size * 0.1, height: size * 0.1)
                        .offset(x: x, y: y)
                        .blur(radius: 1)
                }
            }
            
            // Main star icon
            Image(systemName: "star.fill")
                .font(.system(size: size * 0.5, weight: .semibold))
                .foregroundColor(.white)
                .shadow(color: Color.white.opacity(0.5), radius: 2, x: 0, y: 0)
        }
        .frame(width: size, height: size)
        .clipped()
    }
}

#Preview {
    VStack(spacing: 40) {
        AppLogo(size: 28, showSparkles: false)
        AppLogo(size: 56, showSparkles: true)
        AppLogo(size: 1024, showSparkles: true)
    }
    .padding()
    .background(Color.gray.opacity(0.2))
}


