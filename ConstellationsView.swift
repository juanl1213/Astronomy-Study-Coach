//
//  ConstellationsView.swift
//  Astronomy Study Coach
//
//  Constellation guide for exploring the night sky
//

import SwiftUI

struct Constellation: Identifiable {
    let id: String
    let name: String
    let latinName: String
    let season: String
    let hemisphere: Hemisphere
    let brightness: Double
    let size: ConstellationSize
    let stars: Int
    let mythology: String
    let mainStars: [String]
    let bestViewing: String
    let coordinates: Coordinates
}

enum Hemisphere: String {
    case northern = "Northern"
    case southern = "Southern"
    case both = "Both"
}

enum ConstellationSize: String {
    case large = "Large"
    case medium = "Medium"
    case small = "Small"
}

struct Coordinates {
    let ra: String
    let dec: String
}

struct ConstellationsView: View {
    @EnvironmentObject var appState: AppState
    var onNavigate: ((String) -> Void)?
    
    @State private var selectedConstellation: String? = nil
    @State private var viewMode: ViewMode = .grid
    @State private var selectedTab: DetailTab = .mythology
    
    enum ViewMode {
        case grid
        case detail
    }
    
    enum DetailTab {
        case mythology
        case stars
        case observation
    }
    
    let constellations: [Constellation] = [
        Constellation(
            id: "ursa-major",
            name: "Big Dipper",
            latinName: "Ursa Major",
            season: "Spring",
            hemisphere: .northern,
            brightness: 2.0,
            size: .large,
            stars: 7,
            mythology: "Known as the Great Bear in Greek mythology. Zeus placed Callisto in the sky as a bear after she was transformed by his jealous wife Hera.",
            mainStars: ["Dubhe", "Merak", "Phecda", "Megrez", "Alioth", "Mizar", "Alkaid"],
            bestViewing: "April to June, best seen in evening sky during spring months",
            coordinates: Coordinates(ra: "11h 00m", dec: "+50°")
        ),
        Constellation(
            id: "orion",
            name: "The Hunter",
            latinName: "Orion",
            season: "Winter",
            hemisphere: .both,
            brightness: 1.5,
            size: .large,
            stars: 8,
            mythology: "A great hunter in Greek mythology. Orion boasted he could kill any animal on Earth, which led to his placement in the sky.",
            mainStars: ["Betelgeuse", "Rigel", "Bellatrix", "Mintaka", "Alnilam", "Alnitak", "Saiph", "Meissa"],
            bestViewing: "December to February, visible worldwide during winter months",
            coordinates: Coordinates(ra: "05h 30m", dec: "+00°")
        ),
        Constellation(
            id: "cassiopeia",
            name: "The Queen",
            latinName: "Cassiopeia",
            season: "Autumn",
            hemisphere: .northern,
            brightness: 2.5,
            size: .medium,
            stars: 5,
            mythology: "Named after a vain queen in Greek mythology who boasted about her beauty. She was placed in the sky as punishment.",
            mainStars: ["Schedar", "Caph", "Gamma Cas", "Ruchbah", "Segin"],
            bestViewing: "October to December, circumpolar from northern latitudes",
            coordinates: Coordinates(ra: "01h 00m", dec: "+60°")
        ),
        Constellation(
            id: "leo",
            name: "The Lion",
            latinName: "Leo",
            season: "Spring",
            hemisphere: .both,
            brightness: 1.8,
            size: .large,
            stars: 6,
            mythology: "Represents the Nemean Lion, a monster defeated by Hercules as his first labor. Zeus placed it in the sky to honor the lion.",
            mainStars: ["Regulus", "Algieba", "Denebola", "Zosma", "Ras Elased", "Adhafera"],
            bestViewing: "March to May, best seen during spring evenings",
            coordinates: Coordinates(ra: "10h 30m", dec: "+15°")
        ),
        Constellation(
            id: "cygnus",
            name: "The Swan",
            latinName: "Cygnus",
            season: "Summer",
            hemisphere: .northern,
            brightness: 1.9,
            size: .large,
            stars: 6,
            mythology: "The swan form taken by Zeus in Greek mythology. Also known as the Northern Cross due to its distinctive cross shape.",
            mainStars: ["Deneb", "Sadr", "Gienah", "Delta Cyg", "Albireo", "Fawaris"],
            bestViewing: "July to September, high overhead during summer nights",
            coordinates: Coordinates(ra: "20h 30m", dec: "+40°")
        ),
        Constellation(
            id: "southern-cross",
            name: "Southern Cross",
            latinName: "Crux",
            season: "Year-round",
            hemisphere: .southern,
            brightness: 1.2,
            size: .small,
            stars: 4,
            mythology: "The smallest constellation, known for its distinctive cross shape. Important for navigation in the Southern Hemisphere.",
            mainStars: ["Acrux", "Gacrux", "Imai", "Mimosa"],
            bestViewing: "Visible year-round from southern latitudes, best in autumn",
            coordinates: Coordinates(ra: "12h 30m", dec: "-60°")
        )
    ]
    
    var selectedConst: Constellation? {
        guard let selectedId = selectedConstellation else { return nil }
        return constellations.first { $0.id == selectedId }
    }
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            if viewMode == .detail, let constellation = selectedConst {
                detailView(for: constellation)
            } else {
                gridView
            }
        }
    }
    
    // MARK: - Grid View
    private var gridView: some View {
        VStack(spacing: 0) {
            // Header
            AppHeaderView()
            
            ScrollView {
                VStack(spacing: Spacing.lg) {
                    // Title Section
                    VStack(alignment: .leading, spacing: Spacing.sm) {
                        Text("Constellation Guide")
                            .font(.appTitle)
                            .foregroundColor(.foreground)
                        
                        Text("Explore the night sky and learn about the patterns of stars that have guided humanity for millennia")
                            .font(.appCaption)
                            .foregroundColor(.mutedForeground)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Night Sky Map Card
                    nightSkyMapCard
                    
                    // Constellation Grid
                    LazyVGrid(columns: UIDevice.current.userInterfaceIdiom == .phone ? [
                        GridItem(.flexible(), spacing: Spacing.lg)
                    ] : [
                        GridItem(.flexible(), spacing: Spacing.lg),
                        GridItem(.flexible(), spacing: Spacing.lg),
                        GridItem(.flexible(), spacing: Spacing.lg)
                    ], spacing: Spacing.lg) {
                        ForEach(constellations) { constellation in
                            ConstellationCard(
                                constellation: constellation,
                                onTap: {
                                    selectedConstellation = constellation.id
                                    viewMode = .detail
                                }
                            )
                        }
                    }
                    
                    // Viewing Tips Card
                    viewingTipsCard
                }
                .padding(Spacing.lg)
            }
        }
    }
    
    // MARK: - Night Sky Map Card
    private var nightSkyMapCard: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                Image(systemName: "star.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.primary)
                Text("Night Sky Map")
                    .font(.appHeading)
                    .foregroundColor(.foreground)
            }
            
            Text("Interactive guide to finding constellations throughout the year")
                .font(.appCaption)
                .foregroundColor(.mutedForeground)
            
            // Placeholder for constellation image
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: CornerRadius.md)
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color(red: 0.1, green: 0.1, blue: 0.2), Color(red: 0.05, green: 0.05, blue: 0.15)]),
                        startPoint: .top,
                        endPoint: .bottom
                    ))
                    .frame(height: 200)
                
                // Star pattern overlay (simplified)
                HStack(spacing: 20) {
                    ForEach(0..<5) { _ in
                        Image(systemName: "star.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.6))
                    }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 60)
                    
                    Text("Current night sky view - constellations visible tonight")
                        .font(.appSmall)
                        .foregroundColor(.white)
                        .padding(Spacing.md)
                }
            }
            
            // Season Legend
            HStack(spacing: Spacing.md) {
                SeasonIndicator(season: "Spring", color: .green)
                SeasonIndicator(season: "Summer", color: .yellow)
                SeasonIndicator(season: "Autumn", color: .orange)
                SeasonIndicator(season: "Winter", color: .blue)
            }
        }
        .padding(Spacing.md)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .stroke(Color.border, lineWidth: 1)
        )
    }
    
    // MARK: - Viewing Tips Card
    private var viewingTipsCard: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Constellation Viewing Tips")
                .font(.appHeading)
                .foregroundColor(.foreground)
            
            if UIDevice.current.userInterfaceIdiom == .phone {
                VStack(alignment: .leading, spacing: Spacing.md) {
                    viewingTipsColumn
                }
            } else {
                HStack(alignment: .top, spacing: Spacing.lg) {
                    viewingTipsColumn
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .stroke(Color.border, lineWidth: 1)
        )
    }
    
    private var viewingTipsColumn: some View {
        Group {
            VStack(alignment: .leading, spacing: Spacing.sm) {
                Text("Best Viewing Conditions")
                    .font(.appBody)
                    .fontWeight(.semibold)
                    .foregroundColor(.foreground)
                
                VStack(alignment: .leading, spacing: 4) {
                    TipItem(text: "Clear, moonless nights provide the best visibility")
                    TipItem(text: "Allow 15-30 minutes for your eyes to adjust to darkness")
                    TipItem(text: "Find a location away from city lights and light pollution")
                    TipItem(text: "Use a red flashlight to preserve your night vision")
                }
            }
            
            VStack(alignment: .leading, spacing: Spacing.sm) {
                Text("Finding Constellations")
                    .font(.appBody)
                    .fontWeight(.semibold)
                    .foregroundColor(.foreground)
                
                VStack(alignment: .leading, spacing: 4) {
                    TipItem(text: "Start with the most recognizable patterns")
                    TipItem(text: "Use bright guide stars to locate fainter constellations")
                    TipItem(text: "Learn seasonal patterns - different constellations appear throughout the year")
                    TipItem(text: "Consider using a star chart or astronomy app")
                }
            }
        }
    }
    
    // MARK: - Detail View
    private func detailView(for constellation: Constellation) -> some View {
        VStack(spacing: 0) {
            // Header
            AppHeaderView()
            
            ScrollView {
                VStack(spacing: Spacing.lg) {
                    // Back Button
                    Button(action: {
                        viewMode = .grid
                        selectedConstellation = nil
                    }) {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("Back to Constellation Guide")
                        }
                        .font(.appBody)
                        .foregroundColor(.foreground)
                        .padding(Spacing.md)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                    // Main Info Card
                    mainInfoCard(for: constellation)
                    
                    // Tabs
                    tabsSection(for: constellation)
                }
                .padding(Spacing.lg)
            }
        }
    }
    
    // MARK: - Main Info Card
    private func mainInfoCard(for constellation: Constellation) -> some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            if UIDevice.current.userInterfaceIdiom == .phone {
                VStack(alignment: .leading, spacing: Spacing.md) {
                    infoSection(for: constellation)
                    imageSection
                }
            } else {
                HStack(alignment: .top, spacing: Spacing.lg) {
                    infoSection(for: constellation)
                    imageSection
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .stroke(Color.border, lineWidth: 1)
        )
    }
    
    private func infoSection(for constellation: Constellation) -> some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(constellation.name)
                    .font(.appTitle)
                    .foregroundColor(.foreground)
                
                Text(constellation.latinName)
                    .font(.appBody)
                    .italic()
                    .foregroundColor(.mutedForeground)
            }
            
            // Badges
            HStack(spacing: Spacing.sm) {
                SizeBadge(size: constellation.size)
                HemisphereBadge(hemisphere: constellation.hemisphere)
                SeasonBadge(season: constellation.season)
            }
            .flexibleWrap()
            
            // Details
            VStack(alignment: .leading, spacing: Spacing.sm) {
                HStack(spacing: Spacing.sm) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.yellow)
                    Text("\(constellation.stars) main stars, brightness \(String(format: "%.1f", constellation.brightness))")
                        .font(.appSmall)
                        .foregroundColor(.foreground)
                }
                
                HStack(spacing: Spacing.sm) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.primary)
                    Text("RA: \(constellation.coordinates.ra), Dec: \(constellation.coordinates.dec)")
                        .font(.appSmall)
                        .foregroundColor(.foreground)
                }
                
                HStack(spacing: Spacing.sm) {
                    Image(systemName: "eye.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.primary)
                    Text(constellation.bestViewing)
                        .font(.appSmall)
                        .foregroundColor(.foreground)
                }
            }
        }
    }
    
    private var imageSection: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [Color(red: 0.1, green: 0.1, blue: 0.2), Color(red: 0.05, green: 0.05, blue: 0.15)]),
                    startPoint: .top,
                    endPoint: .bottom
                ))
                .frame(height: 200)
            
            // Star pattern overlay
            HStack(spacing: 15) {
                ForEach(0..<6) { _ in
                    Image(systemName: "star.fill")
                        .font(.system(size: 10))
                        .foregroundColor(.white.opacity(0.6))
                }
            }
            
            VStack(alignment: .leading, spacing: 0) {
                LinearGradient(
                    gradient: Gradient(colors: [.clear, .black.opacity(0.6)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 50)
                
                Text("Constellation pattern visualization")
                    .font(.appSmall)
                    .foregroundColor(.white)
                    .padding(Spacing.sm)
            }
        }
    }
    
    // MARK: - Tabs Section
    private func tabsSection(for constellation: Constellation) -> some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            // Tab Buttons
            HStack(spacing: 0) {
                TabButton(
                    title: "Mythology",
                    isSelected: selectedTab == .mythology,
                    action: { selectedTab = .mythology }
                )
                TabButton(
                    title: "Main Stars",
                    isSelected: selectedTab == .stars,
                    action: { selectedTab = .stars }
                )
                TabButton(
                    title: "Observation",
                    isSelected: selectedTab == .observation,
                    action: { selectedTab = .observation }
                )
            }
            .background(Color.cardBackground)
            .cornerRadius(CornerRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.md)
                    .stroke(Color.border, lineWidth: 1)
            )
            
            // Tab Content
            Group {
                switch selectedTab {
                case .mythology:
                    mythologyTab(for: constellation)
                case .stars:
                    starsTab(for: constellation)
                case .observation:
                    observationTab(for: constellation)
                }
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
    
    private func mythologyTab(for constellation: Constellation) -> some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                Image(systemName: "info.circle.fill")
                    .font(.system(size: 18))
                    .foregroundColor(.primary)
                Text("Mythology & History")
                    .font(.appHeading)
                    .foregroundColor(.foreground)
            }
            
            Text(constellation.mythology)
                .font(.appBody)
                .foregroundColor(.foreground)
                .lineSpacing(4)
        }
    }
    
    private func starsTab(for constellation: Constellation) -> some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                Image(systemName: "star.fill")
                    .font(.system(size: 18))
                    .foregroundColor(.yellow)
                Text("Main Stars")
                    .font(.appHeading)
                    .foregroundColor(.foreground)
            }
            
            Text("The brightest stars that form the constellation pattern")
                .font(.appCaption)
                .foregroundColor(.mutedForeground)
            
            LazyVGrid(columns: UIDevice.current.userInterfaceIdiom == .phone ? [
                GridItem(.flexible(), spacing: Spacing.sm)
            ] : [
                GridItem(.flexible(), spacing: Spacing.sm),
                GridItem(.flexible(), spacing: Spacing.sm)
            ], spacing: Spacing.sm) {
                ForEach(constellation.mainStars, id: \.self) { star in
                    HStack(spacing: Spacing.sm) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.primary)
                            .frame(width: 24, height: 24)
                            .background(Color.primary.opacity(0.1))
                            .clipShape(Circle())
                        
                        Text(star)
                            .font(.appBody)
                            .fontWeight(.medium)
                            .foregroundColor(.foreground)
                    }
                    .padding(Spacing.sm)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.inputBackground)
                    .cornerRadius(CornerRadius.sm)
                }
            }
        }
    }
    
    private func observationTab(for constellation: Constellation) -> some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                Image(systemName: "eye.fill")
                    .font(.system(size: 18))
                    .foregroundColor(.primary)
                Text("Observation Guide")
                    .font(.appHeading)
                    .foregroundColor(.foreground)
            }
            
            if UIDevice.current.userInterfaceIdiom == .phone {
                VStack(alignment: .leading, spacing: Spacing.md) {
                    observationDetails(for: constellation)
                }
            } else {
                HStack(alignment: .top, spacing: Spacing.lg) {
                    observationDetails(for: constellation)
                }
            }
            
            // Observation Tips Box
            VStack(alignment: .leading, spacing: Spacing.sm) {
                HStack {
                    Image(systemName: "clock.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.blue)
                    Text("Observation Tips")
                        .font(.appBody)
                        .fontWeight(.semibold)
                        .foregroundColor(.foreground)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    TipItem(text: "Find a location away from city lights")
                    TipItem(text: "Allow 15-30 minutes for your eyes to adjust to darkness")
                    TipItem(text: "Use a red flashlight to preserve night vision")
                    TipItem(text: "Look during new moon for best visibility")
                }
            }
            .padding(Spacing.md)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(CornerRadius.sm)
        }
    }
    
    private func observationDetails(for constellation: Constellation) -> some View {
        Group {
            VStack(alignment: .leading, spacing: Spacing.sm) {
                HStack {
                    Image(systemName: "calendar")
                        .font(.system(size: 14))
                        .foregroundColor(.primary)
                    Text("Best Viewing Time")
                        .font(.appBody)
                        .fontWeight(.semibold)
                        .foregroundColor(.foreground)
                }
                
                Text(constellation.bestViewing)
                    .font(.appSmall)
                    .foregroundColor(.mutedForeground)
            }
            
            VStack(alignment: .leading, spacing: Spacing.sm) {
                HStack {
                    Image(systemName: "location.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.primary)
                    Text("Finding Tips")
                        .font(.appBody)
                        .fontWeight(.semibold)
                        .foregroundColor(.foreground)
                }
                
                Text("Look for the distinctive pattern of \(constellation.stars) bright stars. Best viewed from \(constellation.hemisphere.rawValue.lowercased()) hemisphere locations.")
                    .font(.appSmall)
                    .foregroundColor(.mutedForeground)
            }
        }
    }
}

// MARK: - Supporting Views

struct ConstellationCard: View {
    let constellation: Constellation
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: Spacing.md) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        Text(constellation.name)
                            .font(.appHeading)
                            .foregroundColor(.foreground)
                        
                        Text(constellation.latinName)
                            .font(.appCaption)
                            .italic()
                            .foregroundColor(.mutedForeground)
                    }
                    
                    Spacer()
                    
                    SizeBadge(size: constellation.size)
                }
                
                HStack {
                    HStack(spacing: 4) {
                        Circle()
                            .fill(seasonColor(constellation.season))
                            .frame(width: 8, height: 8)
                        Text(constellation.season)
                            .font(.appSmall)
                            .foregroundColor(.foreground)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.yellow)
                        Text("\(constellation.stars)")
                            .font(.appSmall)
                            .foregroundColor(.foreground)
                    }
                }
                
                Text(constellation.mythology.prefix(100) + "...")
                    .font(.appSmall)
                    .foregroundColor(.mutedForeground)
                    .lineLimit(2)
                
                HStack {
                    HemisphereBadge(hemisphere: constellation.hemisphere)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Text("Learn More")
                            .font(.appSmall)
                            .foregroundColor(.primary)
                        Image(systemName: "arrow.right")
                            .font(.system(size: 10))
                            .foregroundColor(.primary)
                    }
                }
            }
            .padding(Spacing.md)
            .background(Color.cardBackground)
            .cornerRadius(CornerRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.md)
                    .stroke(Color.border, lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func seasonColor(_ season: String) -> Color {
        switch season {
        case "Spring": return .green
        case "Summer": return .yellow
        case "Autumn": return .orange
        case "Winter": return .blue
        default: return .purple
        }
    }
}

struct SizeBadge: View {
    let size: ConstellationSize
    
    var body: some View {
        Text(size.rawValue)
            .font(.appSmall)
            .padding(.horizontal, Spacing.xs)
            .padding(.vertical, 4)
            .background(sizeColor(size))
            .foregroundColor(sizeTextColor(size))
            .cornerRadius(CornerRadius.sm)
    }
    
    private func sizeColor(_ size: ConstellationSize) -> Color {
        switch size {
        case .large: return Color.blue.opacity(0.2)
        case .medium: return Color.green.opacity(0.2)
        case .small: return Color.yellow.opacity(0.2)
        }
    }
    
    private func sizeTextColor(_ size: ConstellationSize) -> Color {
        switch size {
        case .large: return .blue
        case .medium: return .green
        case .small: return .yellow
        }
    }
}

struct HemisphereBadge: View {
    let hemisphere: Hemisphere
    
    var body: some View {
        Text("\(hemisphere.rawValue) Hemisphere")
            .font(.appSmall)
            .padding(.horizontal, Spacing.xs)
            .padding(.vertical, 4)
            .background(Color.inputBackground)
            .foregroundColor(.foreground)
            .cornerRadius(CornerRadius.sm)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.sm)
                    .stroke(Color.border, lineWidth: 1)
            )
    }
}

struct SeasonBadge: View {
    let season: String
    
    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(seasonColor(season))
                .frame(width: 8, height: 8)
            Text(season)
                .font(.appSmall)
                .foregroundColor(.foreground)
        }
        .padding(.horizontal, Spacing.xs)
        .padding(.vertical, 4)
        .background(Color.inputBackground)
        .cornerRadius(CornerRadius.sm)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.sm)
                .stroke(Color.border, lineWidth: 1)
        )
    }
    
    private func seasonColor(_ season: String) -> Color {
        switch season {
        case "Spring": return .green
        case "Summer": return .yellow
        case "Autumn": return .orange
        case "Winter": return .blue
        default: return .purple
        }
    }
}

struct SeasonIndicator: View {
    let season: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
            Text(season)
                .font(.appSmall)
                .foregroundColor(.foreground)
        }
    }
}

struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.appBody)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundColor(isSelected ? .foreground : .mutedForeground)
                .frame(maxWidth: .infinity)
                .padding(.vertical, Spacing.sm)
                .background(isSelected ? Color.inputBackground : Color.clear)
        }
    }
}

// MARK: - Helper Extension
extension View {
    func flexibleWrap() -> some View {
        self.modifier(FlexibleWrapModifier())
    }
}

struct FlexibleWrapModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    ConstellationsView()
        .environmentObject(AppState())
        .preferredColorScheme(.dark)
}


