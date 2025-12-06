//
//  AppIconGenerator.swift
//  Astronomy Study Coach
//
//  Temporary view to generate app icon at 1024x1024
//  Use this in preview to export the icon image
//

import SwiftUI

struct AppIconGeneratorView: View {
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width - 100
            let iconSize = screenWidth // Use full screen width for square icon
            let scale = iconSize / 1024 // Scale factor from 1024 base size
            
            ZStack {
                // Background
                Color.white
                    .ignoresSafeArea()
                
                // Outer glow layer (contained within square bounds)
                RoundedRectangle(cornerRadius: 200 * scale)
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.indigo600.opacity(0.15),
                                Color.cyan600.opacity(0.1)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: iconSize, height: iconSize)
                    .blur(radius: 40 * scale)
                
                // Main gradient background
                RoundedRectangle(cornerRadius: 200 * scale)
                    .fill(LinearGradient.primaryGradient)
                    .frame(width: iconSize, height: iconSize)
                    .overlay(
                        // Inner highlight for depth
                        RoundedRectangle(cornerRadius: 200 * scale)
                            .fill(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0.25),
                                        Color.clear
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .center
                                )
                            )
                    )
                    .shadow(color: Color.indigo600.opacity(0.3), radius: 50 * scale, x: 0, y: 20 * scale)
                
                // Sparkles around the star (adjusted to fit within square)
                ForEach(0..<8, id: \.self) { index in
                    let angle = Double(index) * (2 * .pi / 8)
                    // Reduced radius to keep sparkles within bounds (accounting for sparkle size)
                    let radius: CGFloat = 350 * scale
                    let x = cos(angle) * radius
                    let y = sin(angle) * radius
                    
                    Circle()
                        .fill(Color.white.opacity(0.9))
                        .frame(width: 50 * scale, height: 50 * scale)
                        .blur(radius: 3 * scale)
                        .offset(x: x, y: y)
                }
                
                // Additional smaller sparkles (adjusted to fit within square)
                ForEach(0..<12, id: \.self) { index in
                    let angle = Double(index) * (2 * .pi / 12) + .pi / 12
                    // Reduced radius to keep sparkles within bounds (accounting for sparkle size)
                    let radius: CGFloat = 300 * scale
                    let x = cos(angle) * radius
                    let y = sin(angle) * radius
                    
                    Circle()
                        .fill(Color.white.opacity(0.6))
                        .frame(width: 25 * scale, height: 25 * scale)
                        .blur(radius: 2 * scale)
                        .offset(x: x, y: y)
                }
                
                // Main star icon with glow
                ZStack {
                    // Star glow
                    Image(systemName: "star.fill")
                        .font(.system(size: 550 * scale, weight: .semibold))
                        .foregroundColor(.white.opacity(0.3))
                        .blur(radius: 20 * scale)
                    
                    // Main star
                    Image(systemName: "star.fill")
                        .font(.system(size: 480 * scale, weight: .semibold))
                        .foregroundColor(.white)
                        .shadow(color: Color.white.opacity(0.8), radius: 10 * scale, x: 0, y: 0)
                }
            }
            .frame(width: iconSize, height: iconSize)
            .clipped()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    AppIconGeneratorView()
        .preferredColorScheme(.light)
}


