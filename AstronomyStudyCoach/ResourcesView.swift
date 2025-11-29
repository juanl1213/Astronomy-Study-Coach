//
//  ResourcesView.swift
//  Astronomy Study Coach
//
//  Learning Resources page displaying curated astronomy resources
//

import SwiftUI

struct ResourcesView: View {
    let onNavigate: (String) -> Void
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                // Header
                AppHeaderView()
                    .environmentObject(appState)
                
                // Content
                VStack(spacing: Spacing.lg) {
                    // Title Section
                    VStack(alignment: .leading, spacing: Spacing.sm) {
                        Text("Learning Resources")
                            .font(.appTitle)
                            .foregroundStyle(LinearGradient.textGradient)
                        
                        Text("Curated collection of astronomy resources to deepen your knowledge.")
                            .font(.appBody)
                            .foregroundColor(.mutedForeground)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, Spacing.lg)
                    
                    // Astronomy Websites
                    ResourceSection(
                        title: "Astronomy Websites",
                        icon: "GlobeIcon",
                        resources: websites,
                        showExternalLink: true
                    )
                    
                    // Educational Platforms
                    ResourceSection(
                        title: "Educational Platforms",
                        icon: "VideoIcon",
                        resources: educational,
                        showExternalLink: true
                    )
                    
                    // Mobile Apps & Tools
                    ResourceSection(
                        title: "Mobile Apps & Tools",
                        icon: "TelescopeIcon",
                        resources: tools,
                        showExternalLink: false
                    )
                    
                    // Recommended Books
                    ResourceSection(
                        title: "Recommended Books",
                        icon: "BookIcon",
                        resources: books,
                        showExternalLink: false
                    )
                    
                    // Call to Action
                    VStack(spacing: Spacing.md) {
                        Text("Ready to test your knowledge?")
                            .font(.appBody)
                            .foregroundColor(.mutedForeground)
                        
                        Button(action: {
                            Task { @MainActor in
                                appState.navigate(to: "quiz")
                            }
                        }) {
                            Text("Take a Quiz")
                                .font(.appBody)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, Spacing.md)
                                .background(LinearGradient.primaryGradient)
                                .cornerRadius(CornerRadius.md)
                        }
                    }
                    .padding(Spacing.lg)
                    .background(Color.cardBackground)
                    .cornerRadius(CornerRadius.lg)
                    .padding(.horizontal, Spacing.lg)
                }
            }
        }
        .background(Color.background)
    }
    
    // MARK: - Resource Data
    
    private var websites: [ResourceItem] {
        [
            ResourceItem(
                name: "NASA",
                description: "Official NASA website with latest space news and missions",
                url: "https://www.nasa.gov",
                icon: "nasa"
            ),
            ResourceItem(
                name: "ESA (European Space Agency)",
                description: "European space exploration and research",
                url: "https://www.esa.int",
                icon: "esa.svg"
            ),
            ResourceItem(
                name: "Sky & Telescope",
                description: "Astronomy news, observing guides, and resources",
                url: "https://www.skyandtelescope.org",
                icon: "sky&telescope"
            ),
            ResourceItem(
                name: "Astronomy.com",
                description: "Popular astronomy magazine and learning resources",
                url: "https://www.astronomy.com",
                icon: "astronomycom"
            ),
            ResourceItem(
                name: "Space.com",
                description: "Latest space news, exploration, and discoveries",
                url: "https://www.space.com",
                icon: "spacecom"
            )
        ]
    }
    
    private var educational: [ResourceItem] {
        [
            ResourceItem(
                name: "Khan Academy Cosmology",
                description: "Free astronomy and cosmology video lessons",
                url: "https://www.khanacademy.org/science/cosmology-and-astronomy",
                icon: "khanacademy"
            ),
            ResourceItem(
                name: "Crash Course Astronomy",
                description: "Entertaining and educational astronomy video series",
                url: "https://www.youtube.com/playlist?list=PL8dPuuaLjXtPAJr1ysd5yGIyiSFuh0mIL",
                icon: "crashcourse"
            ),
            ResourceItem(
                name: "NASA's Astronomy Picture of the Day",
                description: "Daily astronomical images with explanations",
                url: "https://apod.nasa.gov/apod/",
                icon: "apod"
            ),
            ResourceItem(
                name: "Stellarium Web",
                description: "Online planetarium showing realistic sky",
                url: "https://stellarium-web.org",
                icon: "stellariumweb"
            )
        ]
    }
    
    private var tools: [ResourceItem] {
        [
            ResourceItem(
                name: "SkySafari",
                description: "Planetarium app for stargazing (iOS/Android)",
                icon: "skysafari"
            ),
            ResourceItem(
                name: "Star Walk 2",
                description: "Interactive astronomy guide app",
                icon: "starwalk2"
            ),
            ResourceItem(
                name: "NASA App",
                description: "Official NASA app with missions, images, and videos",
                icon: "nasapp"
            ),
            ResourceItem(
                name: "ISS Detector",
                description: "Track the International Space Station",
                icon: "issdetector"
            )
        ]
    }
    
    private var books: [ResourceItem] {
        [
            ResourceItem(
                name: "Cosmos by Carl Sagan",
                description: "Classic exploration of the universe and our place in it"
            ),
            ResourceItem(
                name: "Astrophysics for People in a Hurry",
                description: "By Neil deGrasse Tyson - Quick introduction to the cosmos"
            ),
            ResourceItem(
                name: "The Elegant Universe by Brian Greene",
                description: "Introduction to string theory and modern physics"
            ),
            ResourceItem(
                name: "A Brief History of Time by Stephen Hawking",
                description: "Cosmology from the Big Bang to black holes"
            ),
            ResourceItem(
                name: "The Order of Time by Carlo Rovelli",
                description: "Fascinating exploration of the nature of time"
            )
        ]
    }
}

// MARK: - Resource Section
struct ResourceSection: View {
    let title: String
    let icon: String
    let resources: [ResourceItem]
    let showExternalLink: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            // Section Header
            HStack(spacing: Spacing.sm) {
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundStyle(LinearGradient.textGradient)
                
                Text(title)
                    .font(.appHeading)
                    .foregroundColor(.foreground)
            }
            .padding(.horizontal, Spacing.lg)
            
            // Resources List
            VStack(spacing: Spacing.sm) {
                ForEach(Array(resources.enumerated()), id: \.offset) { index, resource in
                    ResourceCard(
                        resource: resource,
                        showExternalLink: showExternalLink
                    )
                }
            }
            .padding(.horizontal, Spacing.lg)
        }
    }
}

// MARK: - Resource Card
struct ResourceCard: View {
    let resource: ResourceItem
    let showExternalLink: Bool
    
    var body: some View {
        Group {
            if let urlString = resource.url,
               let url = URL(string: urlString),
               showExternalLink {
                Link(destination: url) {
                    cardContent
                }
            } else {
                cardContent
            }
        }
    }
    
    private var cardContent: some View {
        HStack(alignment: .top, spacing: Spacing.md) {
            // Icon
            ZStack {
                RoundedRectangle(cornerRadius: CornerRadius.sm)
                    .fill(Color.indigo600.opacity(0.1))
                    .frame(width: 36, height: 36)
                
                if let iconName = resource.icon {
                    Image(iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundStyle(LinearGradient.textGradient)
                } else {
                    Image(systemName: "link")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(LinearGradient.textGradient)
                }
            }
            
            // Content
            VStack(alignment: .leading, spacing: Spacing.xs) {
                HStack(spacing: Spacing.xs) {
                    Text(resource.name)
                        .font(.appBody)
                        .fontWeight(.semibold)
                        .foregroundColor(.foreground)
                        .lineLimit(2)
                    
                    if showExternalLink, resource.url != nil {
                        Image(systemName: "arrow.up.right.square")
                            .font(.system(size: 12))
                            .foregroundColor(.mutedForeground)
                    }
                }
                
                Text(resource.description)
                    .font(.appSmall)
                    .foregroundColor(.mutedForeground)
                    .lineLimit(3)
            }
            
            Spacer()
        }
        .padding(Spacing.md)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .stroke(Color.border, lineWidth: 1)
        )
    }
}

// MARK: - Resource Item Model
struct ResourceItem {
    let name: String
    let description: String
    let url: String?
    let icon: String?
    
    init(name: String, description: String, url: String? = nil, icon: String? = nil) {
        self.name = name
        self.description = description
        self.url = url
        self.icon = icon
    }
}

#Preview {
    ResourcesView(onNavigate: { _ in })
        .environmentObject(AppState())
        .preferredColorScheme(.dark)
}


