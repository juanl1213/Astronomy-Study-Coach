//
//  LessonView.swift
//  Astronomy Study Coach
//
//  Reusable lesson view component for all astronomy topics
//

import SwiftUI

struct LessonView: View {
    @EnvironmentObject var appState: AppState
    let lessonId: String
    var onNavigate: ((String) -> Void)?
    
    @State private var sessionStartTime: Date?
    @State private var isLessonComplete: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                // Header
                AppHeaderView()
                    .environmentObject(appState)
                
                // Content
                VStack(spacing: Spacing.lg) {
                    // Navigation buttons
                    HStack {
                        Button(action: {
                            Task { @MainActor in
                                appState.navigate(to: "study")
                            }
                        }) {
                            HStack(spacing: Spacing.xs) {
                                Image(systemName: "arrow.left")
                                    .font(.system(size: 14, weight: .medium))
                                Text("Back to Topics")
                                    .font(.appBody)
                            }
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
                        
                        Spacer()
                        
                        Button(action: {
                            Task { @MainActor in
                                appState.navigate(to: "quiz-\(lessonId)")
                            }
                        }) {
                            HStack(spacing: Spacing.xs) {
                                Text("Take Quiz")
                                    .font(.appBody)
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 14, weight: .medium))
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, Spacing.md)
                            .padding(.vertical, Spacing.sm)
                            .background(LinearGradient.primaryGradient)
                            .cornerRadius(CornerRadius.md)
                        }
                    }
                    
                    // Lesson content
                    if let lesson = LessonData.lessons[lessonId] {
                        lessonContent(lesson)
                    } else {
                        Text("Lesson not found")
                            .foregroundColor(.mutedForeground)
                    }
                    
                    // Bottom navigation
                    bottomNavigation
                }
                .padding(.horizontal, Spacing.lg)
            }
        }
        .id(lessonId) // Reset scroll position when lesson changes
        .background(Color.background)
        .onAppear {
            // Start tracking study time
            sessionStartTime = Date()
            
            // Check if lesson is already complete
            isLessonComplete = ProgressManager.shared.isLessonComplete(email: appState.userEmail, lessonId: lessonId)
        }
        .onDisappear {
            // Save study time when leaving lesson
            if let start = sessionStartTime {
                let minutes = Int(Date().timeIntervalSince(start) / 60)
                if minutes > 0 {
                    ProgressManager.shared.addStudyTime(email: appState.userEmail, minutes: minutes)
                }
            }
        }
    }
    
    @ViewBuilder
    private func lessonContent(_ lesson: LessonData) -> some View {
        VStack(alignment: .leading, spacing: Spacing.lg) {
            // Title and description
            VStack(alignment: .leading, spacing: Spacing.sm) {
                Text(lesson.title)
                    .font(.appTitle)
                    .foregroundStyle(LinearGradient.textGradient)
                
                Text(lesson.subtitle)
                    .font(.appBody)
                    .foregroundColor(.mutedForeground)
            }
            
            // Lesson sections
            ForEach(lesson.sections) { section in
                LessonSectionCard(section: section)
            }
            
            // Key concepts
            if !lesson.keyConcepts.isEmpty {
                KeyConceptsCard(concepts: lesson.keyConcepts)
            }
        }
    }
    
    private var bottomNavigation: some View {
        VStack(spacing: Spacing.md) {
            // Mark as Complete button
            if !isLessonComplete {
                Button(action: {
                    ProgressManager.shared.markLessonComplete(email: appState.userEmail, lessonId: lessonId)
                    isLessonComplete = true
                }) {
                    HStack(spacing: Spacing.xs) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 16, weight: .medium))
                        Text("Mark as Complete")
                            .font(.appBody)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, Spacing.md)
                    .background(LinearGradient.primaryGradient)
                    .cornerRadius(CornerRadius.md)
                }
            } else {
                HStack(spacing: Spacing.xs) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.green)
                    Text("Lesson Completed")
                        .font(.appBody)
                        .fontWeight(.medium)
                        .foregroundColor(.mutedForeground)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, Spacing.md)
                .background(Color.cardBackground)
                .cornerRadius(CornerRadius.md)
                .overlay(
                    RoundedRectangle(cornerRadius: CornerRadius.md)
                        .stroke(Color.border, lineWidth: 1)
                )
            }
            
            HStack {
                Button(action: {
                    Task { @MainActor in
                        appState.navigate(to: "study")
                    }
                }) {
                    HStack(spacing: Spacing.xs) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 14, weight: .medium))
                        Text("Back to Topics")
                            .font(.appBody)
                    }
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
                
                Spacer()
                
                if let nextLessonId = LessonData.lessons[lessonId]?.nextLessonId {
                    Button(action: {
                        Task { @MainActor in
                            appState.navigate(to: "lesson-\(nextLessonId)")
                        }
                    }) {
                        HStack(spacing: Spacing.xs) {
                            Text("Next: \(LessonData.lessons[nextLessonId]?.title ?? "")")
                                .font(.appBody)
                            Image(systemName: "arrow.right")
                                .font(.system(size: 14, weight: .medium))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, Spacing.md)
                        .padding(.vertical, Spacing.sm)
                        .background(LinearGradient.primaryGradient)
                        .cornerRadius(CornerRadius.md)
                    }
                }
            }
        }
        .padding(.top, Spacing.lg)
    }
}

// MARK: - Lesson Section Card
struct LessonSectionCard: View {
    let section: LessonSection
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text(section.title)
                .font(.appHeading)
                .foregroundColor(.foreground)
            
            if let imageName = section.imageName {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(CornerRadius.md)
            }
            
            if !section.content.isEmpty {
                Text(section.content)
                    .font(.appBody)
                    .foregroundColor(.foreground)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            if !section.bulletPoints.isEmpty {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    ForEach(section.bulletPoints, id: \.self) { point in
                        BulletPoint(text: point)
                    }
                }
            }
            
            if !section.subsections.isEmpty {
                VStack(alignment: .leading, spacing: Spacing.md) {
                    ForEach(section.subsections) { subsection in
                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            Text(subsection.title)
                                .font(.appBody)
                                .fontWeight(.semibold)
                                .foregroundColor(.foreground)
                            
                            if !subsection.description.isEmpty {
                                Text(subsection.description)
                                    .font(.appBody)
                                    .foregroundColor(.mutedForeground)
                            }
                            
                            if !subsection.items.isEmpty {
                                VStack(alignment: .leading, spacing: Spacing.xs) {
                                    ForEach(subsection.items, id: \.self) { item in
                                        BulletPoint(text: item)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            if section.gridItems.count > 0 {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: Spacing.md) {
                    ForEach(section.gridItems) { item in
                        GridItemCard(item: item)
                    }
                }
            }
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

// MARK: - Bullet Point
struct BulletPoint: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: Spacing.sm) {
            Circle()
                .fill(Color.indigo400)
                .frame(width: 6, height: 6)
                .padding(.top, 6)
            
            parseMarkdown(text)
                .font(.appBody)
                .foregroundColor(.mutedForeground)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    private func parseMarkdown(_ text: String) -> Text {
        let parts = text.components(separatedBy: "**")
        var result = Text("")
        
        for (index, part) in parts.enumerated() {
            if index % 2 == 0 {
                result = result + Text(part)
            } else {
                result = result + Text(part).fontWeight(.semibold)
            }
        }
        
        return result
    }
}

// MARK: - Grid Item Card
struct GridItemCard: View {
    let item: GridItemData
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text(item.title)
                .font(.appBody)
                .fontWeight(.semibold)
                .foregroundColor(.foreground)
            
            Text(item.description)
                .font(.appSmall)
                .foregroundColor(.mutedForeground)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.md)
        .background(Color.inputBackground.opacity(0.5))
        .cornerRadius(CornerRadius.md)
    }
}

// MARK: - Key Concepts Card
struct KeyConceptsCard: View {
    let concepts: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text("Key Concepts")
                .font(.appHeading)
                .foregroundColor(.foreground)
            
            VStack(alignment: .leading, spacing: Spacing.sm) {
                ForEach(concepts, id: \.self) { concept in
                    HStack(alignment: .top, spacing: Spacing.sm) {
                        Text("•")
                            .font(.appBody)
                            .foregroundColor(.indigo400)
                            .fontWeight(.bold)
                        
                        parseMarkdown(concept)
                            .font(.appBody)
                            .foregroundColor(.foreground)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        }
        .padding(Spacing.lg)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.lg)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.lg)
                .stroke(Color.border, lineWidth: 1)
        )
    }
    
    private func parseMarkdown(_ text: String) -> Text {
        let parts = text.components(separatedBy: "**")
        var result = Text("")
        
        for (index, part) in parts.enumerated() {
            if index % 2 == 0 {
                result = result + Text(part)
            } else {
                result = result + Text(part).fontWeight(.semibold)
            }
        }
        
        return result
    }
}

// MARK: - Data Models
struct LessonData {
    let id: String
    let title: String
    let subtitle: String
    let sections: [LessonSection]
    let keyConcepts: [String]
    let nextLessonId: String?
    
    static let lessons: [String: LessonData] = [
        "solar-system": solarSystemLesson,
        "planets": planetsLesson,
        "stars": starsLesson,
        "galaxies": galaxiesLesson,
        "cosmology": cosmologyLesson,
        "exoplanets": exoplanetsLesson,
        "black-holes": blackHolesLesson,
        "nebulae": nebulaeLesson,
        "asteroids": asteroidsLesson,
        "space-exploration": spaceExplorationLesson
    ]
}

struct LessonSection: Identifiable {
    let id = UUID()
    let title: String
    let content: String
    let imageName: String?
    let bulletPoints: [String]
    let subsections: [Subsection]
    let gridItems: [GridItemData]
}

struct Subsection: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let items: [String]
}

struct GridItemData: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

// MARK: - Lesson Content
// Solar System Lesson
let solarSystemLesson = LessonData(
    id: "solar-system",
    title: "The Solar System",
    subtitle: "Explore our cosmic neighborhood and learn about the Sun and its planetary family.",
    sections: [
        LessonSection(
            title: "Overview",
            content: "The Solar System is a gravitationally bound system consisting of the Sun and the objects that orbit it. It formed approximately 4.6 billion years ago from the gravitational collapse of a giant molecular cloud.\n\nOur Solar System consists of the Sun, eight planets, dwarf planets, moons, asteroids, comets, and other celestial objects. The four inner planets (Mercury, Venus, Earth, and Mars) are terrestrial planets, while the four outer planets (Jupiter, Saturn, Uranus, and Neptune) are gas and ice giants.",
            imageName: "SolarSystem",
            bulletPoints: [],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "The Sun",
            content: "The Sun is a G-type main-sequence star (G2V) that contains 99.86% of the Solar System's mass. It's primarily composed of hydrogen (73%) and helium (25%), with trace amounts of heavier elements.",
            imageName: nil,
            bulletPoints: [
                "Diameter: approximately 1.4 million kilometers",
                "Surface temperature: about 5,500°C (9,932°F)",
                "Core temperature: approximately 15 million°C",
                "Age: about 4.6 billion years old",
                "Expected lifespan: approximately 10 billion years total"
            ],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "The Planets",
            content: "",
            imageName: nil,
            bulletPoints: [],
            subsections: [
                Subsection(
                    title: "Inner (Terrestrial) Planets",
                    description: "Rocky planets with solid surfaces located closer to the Sun.",
                    items: [
                        "**Mercury:** Smallest planet, extreme temperature variations",
                        "**Venus:** Hottest planet due to runaway greenhouse effect",
                        "**Earth:** Only known planet with life",
                        "**Mars:** The Red Planet, has the largest volcano in the Solar System"
                    ]
                ),
                Subsection(
                    title: "Outer (Gas and Ice Giants)",
                    description: "Large planets composed primarily of gases and ices.",
                    items: [
                        "**Jupiter:** Largest planet, has a Great Red Spot storm",
                        "**Saturn:** Famous for its extensive ring system",
                        "**Uranus:** Tilted on its side, rotates at a 98° angle",
                        "**Neptune:** Furthest planet, has the fastest winds in the Solar System"
                    ]
                )
            ],
            gridItems: []
        ),
        LessonSection(
            title: "Other Celestial Objects",
            content: "",
            imageName: nil,
            bulletPoints: [],
            subsections: [],
            gridItems: [
                GridItemData(
                    title: "Dwarf Planets",
                    description: "Celestial bodies that orbit the Sun and have sufficient mass to be round but haven't cleared their orbital path. Examples include Pluto, Eris, Ceres, Makemake, and Haumea."
                ),
                GridItemData(
                    title: "Asteroids",
                    description: "Rocky objects smaller than planets, primarily found in the asteroid belt between Mars and Jupiter. Millions of asteroids exist in our Solar System."
                ),
                GridItemData(
                    title: "Comets",
                    description: "Icy bodies that develop tails when approaching the Sun. They originate from the Kuiper Belt and Oort Cloud in the outer Solar System."
                ),
                GridItemData(
                    title: "Moons",
                    description: "Natural satellites orbiting planets. Our Solar System has over 200 known moons, with Jupiter and Saturn having the most."
                )
            ]
        )
    ],
    keyConcepts: [
        "**Orbital Period:** The time it takes for an object to complete one orbit around the Sun",
        "**Astronomical Unit (AU):** The average distance from Earth to the Sun (about 150 million km)",
        "**Ecliptic Plane:** The plane of Earth's orbit around the Sun",
        "**Gravity:** The force that holds the Solar System together"
    ],
    nextLessonId: "planets"
)

// Planets Lesson (simplified - you can expand this)
let planetsLesson = LessonData(
    id: "planets",
    title: "Planets in Detail",
    subtitle: "Deep dive into the characteristics and features of each planet in our Solar System.",
    sections: [
        LessonSection(
            title: "Mercury - The Swift Planet",
            content: "Mercury is the smallest planet in our Solar System and the closest to the Sun. Despite its proximity, it's not the hottest planet due to its lack of atmosphere.",
            imageName: nil,
            bulletPoints: [
                "Smallest planet in the Solar System",
                "No atmosphere to retain heat",
                "Heavily cratered surface",
                "Named after Roman messenger god",
                "Orbital period: 88 Earth days",
                "Day length: 59 Earth days",
                "Temperature: -173°C to 427°C",
                "Distance from Sun: 0.39 AU"
            ],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Venus - Earth's Twin",
            content: "Venus is similar in size to Earth but has a thick, toxic atmosphere that traps heat, making it the hottest planet in our Solar System.",
            imageName: nil,
            bulletPoints: [
                "Similar size to Earth",
                "Hottest planet in Solar System",
                "Thick, toxic atmosphere",
                "Runaway greenhouse effect",
                "Surface temperature: ~462°C",
                "Rotates backwards (retrograde rotation)",
                "No moons",
                "Distance from Sun: 0.72 AU"
            ],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Earth - Our Home",
            content: "Earth is the only known planet with life. It has liquid water, a protective atmosphere, and a magnetic field that shields it from harmful solar radiation.",
            imageName: nil,
            bulletPoints: [
                "Only known planet with life",
                "71% of surface covered by water",
                "Protective atmosphere with oxygen",
                "Strong magnetic field",
                "One natural satellite: the Moon",
                "Orbital period: 365.25 days",
                "Distance from Sun: 1 AU (150 million km)"
            ],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Mars - The Red Planet",
            content: "Mars is known for its reddish appearance due to iron oxide (rust) on its surface. It has the largest volcano in the Solar System and evidence of ancient water flows.",
            imageName: nil,
            bulletPoints: [
                "Known as the Red Planet",
                "Home to Olympus Mons, the largest volcano",
                "Evidence of ancient water flows",
                "Two small moons: Phobos and Deimos",
                "Thin atmosphere, mostly carbon dioxide",
                "Orbital period: 687 Earth days",
                "Distance from Sun: 1.52 AU"
            ],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Jupiter - The Giant",
            content: "Jupiter is the largest planet in our Solar System. It's a gas giant with a Great Red Spot, a storm larger than Earth that has been raging for centuries.",
            imageName: nil,
            bulletPoints: [
                "Largest planet in Solar System",
                "Gas giant with no solid surface",
                "Great Red Spot storm",
                "79 known moons (including the four Galilean moons)",
                "Strong magnetic field",
                "Orbital period: 12 Earth years",
                "Distance from Sun: 5.2 AU"
            ],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Saturn - The Ringed Planet",
            content: "Saturn is famous for its spectacular ring system, made of ice particles and rocky debris. It's less dense than water and would float if placed in a giant bathtub!",
            imageName: nil,
            bulletPoints: [
                "Famous for its ring system",
                "Less dense than water",
                "82 known moons, including Titan",
                "Hexagonal storm at north pole",
                "Gas giant with hydrogen and helium",
                "Orbital period: 29 Earth years",
                "Distance from Sun: 9.5 AU"
            ],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Uranus - The Tilted Planet",
            content: "Uranus is unique because it rotates on its side, likely due to a massive collision in its past. It's an ice giant with a blue-green color from methane in its atmosphere.",
            imageName: nil,
            bulletPoints: [
                "Rotates on its side (98° tilt)",
                "Ice giant with water, methane, and ammonia",
                "Blue-green color from methane",
                "27 known moons",
                "13 faint rings",
                "Orbital period: 84 Earth years",
                "Distance from Sun: 19.2 AU"
            ],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Neptune - The Windy Planet",
            content: "Neptune is the furthest planet from the Sun and has the fastest winds in the Solar System, reaching speeds up to 2,100 km/h (1,300 mph).",
            imageName: nil,
            bulletPoints: [
                "Furthest planet from the Sun",
                "Fastest winds in Solar System (up to 2,100 km/h)",
                "Ice giant similar to Uranus",
                "Deep blue color from methane",
                "14 known moons, including Triton",
                "Orbital period: 165 Earth years",
                "Distance from Sun: 30.1 AU"
            ],
            subsections: [],
            gridItems: []
        )
    ],
    keyConcepts: [
        "**Terrestrial Planets:** Rocky planets with solid surfaces (Mercury, Venus, Earth, Mars)",
        "**Gas Giants:** Large planets made mostly of hydrogen and helium (Jupiter, Saturn)",
        "**Ice Giants:** Planets with water, methane, and ammonia ices (Uranus, Neptune)",
        "**Orbital Period:** Time for one complete orbit around the Sun",
        "**AU (Astronomical Unit):** Distance from Earth to Sun, used to measure planetary distances"
    ],
    nextLessonId: "stars"
)

// Stars Lesson
let starsLesson = LessonData(
    id: "stars",
    title: "Stars & Stellar Evolution",
    subtitle: "Learn about star formation, life cycles, and stellar classifications.",
    sections: [
        LessonSection(
            title: "What Are Stars?",
            content: "Stars are massive, luminous spheres of plasma held together by gravity. They generate energy through nuclear fusion in their cores, converting hydrogen into helium and releasing enormous amounts of light and heat.",
            imageName: nil,
            bulletPoints: [],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Star Formation",
            content: "Stars form in giant molecular clouds called nebulae. When a region becomes dense enough, gravity causes it to collapse, heating up until nuclear fusion begins.",
            imageName: nil,
            bulletPoints: [
                "Form in giant molecular clouds (nebulae)",
                "Gravity causes collapse of dense regions",
                "Temperature rises to millions of degrees",
                "Nuclear fusion begins when core reaches ~10 million°C",
                "Process takes millions of years",
                "Our Sun formed about 4.6 billion years ago"
            ],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Stellar Classification",
            content: "Stars are classified by their spectral type, which indicates their temperature and color. The main sequence includes stars fusing hydrogen in their cores.",
            imageName: nil,
            bulletPoints: [],
            subsections: [
                Subsection(
                    title: "Spectral Types (O, B, A, F, G, K, M)",
                    description: "From hottest to coolest:",
                    items: [
                        "**O-type:** Blue, hottest stars (>30,000°C)",
                        "**B-type:** Blue-white (10,000-30,000°C)",
                        "**A-type:** White (7,500-10,000°C)",
                        "**F-type:** Yellow-white (6,000-7,500°C)",
                        "**G-type:** Yellow, like our Sun (5,200-6,000°C)",
                        "**K-type:** Orange (3,700-5,200°C)",
                        "**M-type:** Red, coolest stars (<3,700°C)"
                    ]
                )
            ],
            gridItems: []
        ),
        LessonSection(
            title: "Stellar Life Cycle",
            content: "A star's life cycle depends on its mass. Low-mass stars like our Sun become red giants, then white dwarfs. High-mass stars explode as supernovae.",
            imageName: nil,
            bulletPoints: [],
            subsections: [
                Subsection(
                    title: "Low-Mass Stars (like our Sun)",
                    description: "Life cycle stages:",
                    items: [
                        "**Main Sequence:** Fuses hydrogen for billions of years",
                        "**Red Giant:** Expands when hydrogen runs out",
                        "**Planetary Nebula:** Outer layers expelled",
                        "**White Dwarf:** Hot, dense core remnant",
                        "**Black Dwarf:** Cooled white dwarf (future state)"
                    ]
                ),
                Subsection(
                    title: "High-Mass Stars",
                    description: "Life cycle stages:",
                    items: [
                        "**Main Sequence:** Fuses hydrogen quickly",
                        "**Red Supergiant:** Massive expansion",
                        "**Supernova:** Explosive death",
                        "**Neutron Star or Black Hole:** Dense remnant"
                    ]
                )
            ],
            gridItems: []
        )
    ],
    keyConcepts: [
        "**Nuclear Fusion:** Process where hydrogen atoms combine to form helium, releasing energy",
        "**Main Sequence:** Phase where stars fuse hydrogen in their cores",
        "**Red Giant:** Expanded star that has exhausted its core hydrogen",
        "**Supernova:** Explosive death of a massive star",
        "**White Dwarf:** Dense remnant of a low-mass star"
    ],
    nextLessonId: "galaxies"
)

// Galaxies Lesson
let galaxiesLesson = LessonData(
    id: "galaxies",
    title: "Galaxies",
    subtitle: "Discover different types of galaxies and cosmic structures.",
    sections: [
        LessonSection(
            title: "What Are Galaxies?",
            content: "Galaxies are massive systems of stars, gas, dust, and dark matter bound together by gravity. The observable universe contains billions of galaxies, each with millions to trillions of stars.",
            imageName: nil,
            bulletPoints: [],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Types of Galaxies",
            content: "Galaxies are classified into three main types based on their shape: spiral, elliptical, and irregular.",
            imageName: nil,
            bulletPoints: [],
            subsections: [
                Subsection(
                    title: "Spiral Galaxies",
                    description: "Have rotating arms with active star formation. Our Milky Way is a spiral galaxy.",
                    items: [
                        "**Barred Spiral:** Has a central bar structure (like Milky Way)",
                        "**Regular Spiral:** No central bar",
                        "**Arms:** Regions of active star formation",
                        "**Bulge:** Central region with older stars"
                    ]
                ),
                Subsection(
                    title: "Elliptical Galaxies",
                    description: "Spherical or elliptical shapes with little gas and dust, mostly old stars.",
                    items: [
                        "**Shape:** Ranges from nearly spherical to highly elongated",
                        "**Stars:** Mostly old, red stars",
                        "**Gas:** Very little gas and dust",
                        "**Size:** Can be very large (giant ellipticals)"
                    ]
                ),
                Subsection(
                    title: "Irregular Galaxies",
                    description: "No defined shape, often result of galaxy collisions.",
                    items: [
                        "**Shape:** No regular structure",
                        "**Formation:** Often from galaxy interactions",
                        "**Star Formation:** Can be very active",
                        "**Examples:** Large and Small Magellanic Clouds"
                    ]
                )
            ],
            gridItems: []
        ),
        LessonSection(
            title: "The Milky Way",
            content: "Our home galaxy is a barred spiral galaxy containing 200-400 billion stars. It's about 100,000 light-years across and we're located about 27,000 light-years from the center.",
            imageName: nil,
            bulletPoints: [
                "Type: Barred spiral galaxy",
                "Stars: 200-400 billion",
                "Diameter: ~100,000 light-years",
                "Thickness: ~1,000 light-years",
                "Our location: ~27,000 light-years from center",
                "Age: ~13.6 billion years old",
                "Contains: Solar System, stars, gas, dust, dark matter"
            ],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Galaxy Interactions",
            content: "Galaxies can collide and merge, creating new structures. The Andromeda Galaxy is approaching the Milky Way and will collide in about 4.5 billion years.",
            imageName: nil,
            bulletPoints: [
                "Galaxies can collide and merge",
                "Collisions trigger star formation",
                "Andromeda will collide with Milky Way in ~4.5 billion years",
                "Galaxy clusters contain hundreds to thousands of galaxies",
                "Dark matter helps hold galaxies together"
            ],
            subsections: [],
            gridItems: []
        )
    ],
    keyConcepts: [
        "**Spiral Galaxy:** Galaxy with rotating arms and active star formation",
        "**Elliptical Galaxy:** Spherical galaxy with mostly old stars",
        "**Light-Year:** Distance light travels in one year (~9.5 trillion km)",
        "**Dark Matter:** Invisible matter that provides gravitational structure",
        "**Galaxy Cluster:** Group of galaxies bound by gravity"
    ],
    nextLessonId: "cosmology"
)

// Cosmology Lesson
let cosmologyLesson = LessonData(
    id: "cosmology",
    title: "Cosmology & The Universe",
    subtitle: "Understand the origin and evolution of the universe.",
    sections: [
        LessonSection(
            title: "The Big Bang Theory",
            content: "The Big Bang theory describes how the universe began approximately 13.8 billion years ago. It wasn't an explosion in space, but rather an expansion of space itself from an incredibly hot, dense point.",
            imageName: nil,
            bulletPoints: [
                "Universe began ~13.8 billion years ago",
                "Started from an extremely hot, dense state",
                "Rapid expansion called inflation",
                "Cooled enough for particles to form",
                "First atoms formed after ~380,000 years",
                "Evidence: Cosmic microwave background radiation"
            ],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Cosmic Microwave Background",
            content: "The CMB is the oldest light in the universe, released when atoms first formed. It provides a snapshot of the universe when it was only 380,000 years old.",
            imageName: nil,
            bulletPoints: [
                "Oldest light in the universe",
                "Released 380,000 years after Big Bang",
                "Temperature: ~2.7 Kelvin (-270°C)",
                "Uniform across the sky with tiny fluctuations",
                "Provides evidence for Big Bang theory"
            ],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Dark Matter & Dark Energy",
            content: "Most of the universe is made of mysterious dark matter and dark energy, which we can't directly observe but know exist from their gravitational effects.",
            imageName: nil,
            bulletPoints: [],
            subsections: [
                Subsection(
                    title: "Dark Matter",
                    description: "Invisible matter that doesn't emit or absorb light.",
                    items: [
                        "Makes up ~27% of universe",
                        "Provides gravitational structure",
                        "Holds galaxies together",
                        "We don't know what it's made of"
                    ]
                ),
                Subsection(
                    title: "Dark Energy",
                    description: "Mysterious force causing universe expansion to accelerate.",
                    items: [
                        "Makes up ~68% of universe",
                        "Causes accelerated expansion",
                        "Discovered in 1998",
                        "Nature remains unknown"
                    ]
                )
            ],
            gridItems: []
        ),
        LessonSection(
            title: "The Future of the Universe",
            content: "Based on current observations, the universe will continue expanding forever, eventually becoming cold and dark as stars burn out.",
            imageName: nil,
            bulletPoints: [
                "Universe will expand forever",
                "Stars will eventually burn out",
                "Universe will become cold and dark",
                "This is called the 'Heat Death' scenario",
                "Timeline: Trillions of years"
            ],
            subsections: [],
            gridItems: []
        )
    ],
    keyConcepts: [
        "**Big Bang:** The origin of the universe ~13.8 billion years ago",
        "**CMB:** Cosmic Microwave Background, oldest light in universe",
        "**Dark Matter:** Invisible matter providing gravitational structure",
        "**Dark Energy:** Force causing accelerated universe expansion",
        "**Inflation:** Rapid expansion in first fraction of a second"
    ],
    nextLessonId: "exoplanets"
)

// Exoplanets Lesson
let exoplanetsLesson = LessonData(
    id: "exoplanets",
    title: "Exoplanets",
    subtitle: "Discover planets beyond our Solar System.",
    sections: [
        LessonSection(
            title: "What Are Exoplanets?",
            content: "Exoplanets are planets that orbit stars other than our Sun. Scientists have discovered over 5,000 confirmed exoplanets, with thousands more candidates awaiting confirmation.",
            imageName: nil,
            bulletPoints: [
                "Planets orbiting stars other than the Sun",
                "Over 5,000 confirmed discoveries",
                "First discovered in 1992",
                "Most found using indirect methods",
                "Some may be habitable"
            ],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Detection Methods",
            content: "Exoplanets are detected using several methods, each revealing different information about these distant worlds.",
            imageName: nil,
            bulletPoints: [],
            subsections: [
                Subsection(
                    title: "Transit Method",
                    description: "Detects tiny dips in star brightness when planet passes in front.",
                    items: [
                        "Most successful method",
                        "Used by Kepler and TESS missions",
                        "Reveals planet size and orbital period",
                        "Can detect atmosphere composition"
                    ]
                ),
                Subsection(
                    title: "Radial Velocity Method",
                    description: "Detects wobbles in star's motion caused by planet's gravity.",
                    items: [
                        "Reveals planet mass",
                        "First method to find exoplanets",
                        "Works best for massive planets",
                        "Can find planets close to star"
                    ]
                ),
                Subsection(
                    title: "Direct Imaging",
                    description: "Takes pictures of exoplanets directly.",
                    items: [
                        "Very difficult method",
                        "Works best for young, hot planets",
                        "Can study planet atmospheres",
                        "Future telescopes will improve this"
                    ]
                )
            ],
            gridItems: []
        ),
        LessonSection(
            title: "Types of Exoplanets",
            content: "Exoplanets come in many varieties, from hot Jupiters to potentially habitable Earth-like worlds.",
            imageName: nil,
            bulletPoints: [],
            subsections: [],
            gridItems: [
                GridItemData(
                    title: "Hot Jupiters",
                    description: "Gas giants very close to their stars, completing orbits in days."
                ),
                GridItemData(
                    title: "Super-Earths",
                    description: "Rocky planets larger than Earth but smaller than Neptune."
                ),
                GridItemData(
                    title: "Mini-Neptunes",
                    description: "Planets with thick atmospheres, intermediate between Earth and Neptune."
                ),
                GridItemData(
                    title: "Habitable Zone Planets",
                    description: "Planets in the 'Goldilocks zone' where liquid water could exist."
                )
            ]
        )
    ],
    keyConcepts: [
        "**Exoplanet:** Planet orbiting a star other than the Sun",
        "**Transit:** When a planet passes in front of its star",
        "**Habitable Zone:** Region where liquid water could exist",
        "**Goldilocks Zone:** Another name for habitable zone",
        "**Kepler Mission:** Space telescope that found thousands of exoplanets"
    ],
    nextLessonId: "black-holes"
)

// Black Holes Lesson
let blackHolesLesson = LessonData(
    id: "black-holes",
    title: "Black Holes",
    subtitle: "Explore the most extreme objects in the universe.",
    sections: [
        LessonSection(
            title: "What Are Black Holes?",
            content: "Black holes are regions in space where gravity is so strong that nothing, not even light, can escape. They form when massive stars collapse at the end of their life cycle.",
            imageName: nil,
            bulletPoints: [
                "Regions where gravity is extremely strong",
                "Nothing can escape, not even light",
                "Formed from collapsed massive stars",
                "First predicted by Einstein's theory of relativity",
                "First image captured in 2019"
            ],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Types of Black Holes",
            content: "Black holes come in different sizes, from stellar-mass to supermassive.",
            imageName: nil,
            bulletPoints: [],
            subsections: [
                Subsection(
                    title: "Stellar-Mass Black Holes",
                    description: "Formed from collapsed massive stars.",
                    items: [
                        "Mass: 3-100 times the Sun",
                        "Formed from supernova explosions",
                        "Common throughout galaxies",
                        "Difficult to detect"
                    ]
                ),
                Subsection(
                    title: "Supermassive Black Holes",
                    description: "Found at the centers of galaxies.",
                    items: [
                        "Mass: Millions to billions of Suns",
                        "Located at galaxy centers",
                        "Milky Way has Sagittarius A*",
                        "May form from early universe"
                    ]
                ),
                Subsection(
                    title: "Intermediate Black Holes",
                    description: "Mid-sized black holes.",
                    items: [
                        "Mass: 100-100,000 Suns",
                        "Rare and poorly understood",
                        "May be stepping stones to supermassive",
                        "Few confirmed discoveries"
                    ]
                )
            ],
            gridItems: []
        ),
        LessonSection(
            title: "Event Horizon",
            content: "The event horizon is the boundary around a black hole. Once something crosses this point, it cannot escape. The size of the event horizon depends on the black hole's mass.",
            imageName: nil,
            bulletPoints: [
                "Boundary of no return",
                "Size depends on black hole mass",
                "For a stellar-mass black hole: ~3 km radius",
                "For supermassive black hole: millions of km",
                "Time appears to slow near event horizon"
            ],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Black Hole Effects",
            content: "Black holes have dramatic effects on their surroundings, from accretion disks to gravitational lensing.",
            imageName: nil,
            bulletPoints: [],
            subsections: [],
            gridItems: [
                GridItemData(
                    title: "Accretion Disk",
                    description: "Hot, glowing disk of matter spiraling into the black hole."
                ),
                GridItemData(
                    title: "Jets",
                    description: "Powerful streams of particles ejected from poles."
                ),
                GridItemData(
                    title: "Gravitational Lensing",
                    description: "Light bends around black holes, creating lensing effects."
                ),
                GridItemData(
                    title: "Tidal Forces",
                    description: "Extreme stretching forces near black holes."
                )
            ]
        )
    ],
    keyConcepts: [
        "**Event Horizon:** Boundary beyond which nothing can escape",
        "**Singularity:** Infinitely dense point at black hole center",
        "**Accretion Disk:** Hot matter spiraling into black hole",
        "**Hawking Radiation:** Theoretical radiation from black holes",
        "**Gravitational Waves:** Ripples in spacetime from black hole mergers"
    ],
    nextLessonId: "nebulae"
)

// Nebulae Lesson
let nebulaeLesson = LessonData(
    id: "nebulae",
    title: "Nebulae",
    subtitle: "Explore the beautiful clouds of gas and dust where stars are born and die.",
    sections: [
        LessonSection(
            title: "What Are Nebulae?",
            content: "Nebulae are vast clouds of gas and dust in space. They come in several types and serve as stellar nurseries where new stars form, or as remnants of dying stars.",
            imageName: nil,
            bulletPoints: [],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Types of Nebulae",
            content: "Nebulae are classified by how they interact with light and their origin.",
            imageName: nil,
            bulletPoints: [],
            subsections: [
                Subsection(
                    title: "Emission Nebulae",
                    description: "Glow with their own light, excited by nearby hot stars.",
                    items: [
                        "Glow from ionized gas",
                        "Often appear red or pink",
                        "Example: Orion Nebula",
                        "Hot stars provide energy"
                    ]
                ),
                Subsection(
                    title: "Reflection Nebulae",
                    description: "Reflect light from nearby stars.",
                    items: [
                        "Appear blue (scattered light)",
                        "Dust particles reflect starlight",
                        "Example: Pleiades Nebula",
                        "No ionization occurs"
                    ]
                ),
                Subsection(
                    title: "Dark Nebulae",
                    description: "Block light from behind, appearing as dark clouds.",
                    items: [
                        "Dense clouds of dust",
                        "Block background starlight",
                        "Example: Horsehead Nebula",
                        "Star formation regions"
                    ]
                ),
                Subsection(
                    title: "Planetary Nebulae",
                    description: "Formed when medium-mass stars expel their outer layers.",
                    items: [
                        "Not related to planets",
                        "Beautiful, colorful structures",
                        "Example: Ring Nebula",
                        "Last stage before white dwarf"
                    ]
                ),
                Subsection(
                    title: "Supernova Remnants",
                    description: "Remains of massive star explosions.",
                    items: [
                        "Expanding shells of gas",
                        "Very hot and energetic",
                        "Example: Crab Nebula",
                        "Source of heavy elements"
                    ]
                )
            ],
            gridItems: []
        ),
        LessonSection(
            title: "Star Formation",
            content: "Nebulae are stellar nurseries where gravity causes dense regions to collapse and form new stars.",
            imageName: nil,
            bulletPoints: [
                "Dense regions collapse under gravity",
                "Forms protostars",
                "Nuclear fusion begins",
                "New stars are born",
                "Process takes millions of years",
                "Orion Nebula is active star-forming region"
            ],
            subsections: [],
            gridItems: []
        )
    ],
    keyConcepts: [
        "**Nebula:** Cloud of gas and dust in space",
        "**Stellar Nursery:** Region where stars form",
        "**Ionization:** Process of atoms losing electrons",
        "**Protostar:** Early stage of star formation",
        "**Planetary Nebula:** Shell of gas from dying star (misleading name)"
    ],
    nextLessonId: "asteroids"
)

// Asteroids Lesson
let asteroidsLesson = LessonData(
    id: "asteroids",
    title: "Asteroids & Comets",
    subtitle: "Learn about the rocky and icy remnants from the early Solar System.",
    sections: [
        LessonSection(
            title: "Asteroids",
            content: "Asteroids are rocky objects smaller than planets, primarily found in the asteroid belt between Mars and Jupiter. They are remnants from the early Solar System.",
            imageName: nil,
            bulletPoints: [
                "Rocky objects smaller than planets",
                "Most found in asteroid belt",
                "Millions exist in Solar System",
                "Vary in size from meters to hundreds of kilometers",
                "Some have moons",
                "Source of meteorites on Earth"
            ],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Asteroid Belt",
            content: "The main asteroid belt lies between Mars and Jupiter, containing millions of asteroids.",
            imageName: nil,
            bulletPoints: [
                "Located between Mars and Jupiter",
                "Contains millions of asteroids",
                "Largest: Ceres (now a dwarf planet)",
                "Not densely packed (spacecraft pass through safely)",
                "Formed from material that couldn't form a planet"
            ],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Comets",
            content: "Comets are icy bodies that develop spectacular tails when approaching the Sun. They originate from the outer Solar System.",
            imageName: nil,
            bulletPoints: [
                "Icy bodies with frozen gases",
                "Develop tails near the Sun",
                "Originate from Kuiper Belt and Oort Cloud",
                "Orbital periods vary greatly",
                "Famous examples: Halley's Comet, Comet Hale-Bopp"
            ],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Comet Structure",
            content: "Comets have distinct parts: nucleus, coma, and tails.",
            imageName: nil,
            bulletPoints: [],
            subsections: [
                Subsection(
                    title: "Nucleus",
                    description: "Solid core of ice and rock.",
                    items: [
                        "Typically 1-10 km across",
                        "Made of ice, dust, and rock",
                        "Dark, dirty surface",
                        "Source of comet activity"
                    ]
                ),
                Subsection(
                    title: "Coma",
                    description: "Cloud of gas and dust around nucleus.",
                    items: [
                        "Forms when comet approaches Sun",
                        "Ice sublimates (turns to gas)",
                        "Can be larger than planets",
                        "Reflects sunlight"
                    ]
                ),
                Subsection(
                    title: "Tails",
                    description: "Two types of tails form.",
                    items: [
                        "**Dust Tail:** Curved, reflects sunlight",
                        "**Ion Tail:** Straight, points away from Sun",
                        "Can extend millions of kilometers",
                        "Always point away from Sun"
                    ]
                )
            ],
            gridItems: []
        )
    ],
    keyConcepts: [
        "**Asteroid:** Rocky object smaller than a planet",
        "**Comet:** Icy body that develops tails near the Sun",
        "**Asteroid Belt:** Region between Mars and Jupiter",
        "**Kuiper Belt:** Icy region beyond Neptune",
        "**Oort Cloud:** Distant spherical shell of comets"
    ],
    nextLessonId: "space-exploration"
)

// Space Exploration Lesson
let spaceExplorationLesson = LessonData(
    id: "space-exploration",
    title: "Space Exploration",
    subtitle: "Discover humanity's journey into space and future missions.",
    sections: [
        LessonSection(
            title: "Early Space Exploration",
            content: "Human space exploration began in the 1950s with the Space Race between the United States and Soviet Union.",
            imageName: nil,
            bulletPoints: [
                "Sputnik 1: First artificial satellite (1957)",
                "Yuri Gagarin: First human in space (1961)",
                "Apollo 11: First Moon landing (1969)",
                "Space Race drove rapid advancement",
                "Led to modern space technology"
            ],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Major Missions",
            content: "Key missions have expanded our understanding of the Solar System and beyond.",
            imageName: nil,
            bulletPoints: [],
            subsections: [
                Subsection(
                    title: "Planetary Exploration",
                    description: "Robotic missions to planets.",
                    items: [
                        "**Voyager:** Explored outer planets",
                        "**Mars Rovers:** Studied Martian surface",
                        "**Cassini:** Explored Saturn system",
                        "**Juno:** Studying Jupiter",
                        "**Perseverance:** Searching for life on Mars"
                    ]
                ),
                Subsection(
                    title: "Space Telescopes",
                    description: "Observatories in space.",
                    items: [
                        "**Hubble:** Visible and UV observations",
                        "**James Webb:** Infrared astronomy",
                        "**Kepler:** Found thousands of exoplanets",
                        "**TESS:** Searching for exoplanets",
                        "**Chandra:** X-ray observations"
                    ]
                )
            ],
            gridItems: []
        ),
        LessonSection(
            title: "International Space Station",
            content: "The ISS is a collaborative space laboratory orbiting Earth, demonstrating long-term human presence in space.",
            imageName: nil,
            bulletPoints: [
                "Orbiting laboratory since 1998",
                "International collaboration",
                "Continuous human presence since 2000",
                "Conducts scientific research",
                "Tests technologies for future missions"
            ],
            subsections: [],
            gridItems: []
        ),
        LessonSection(
            title: "Future Exploration",
            content: "Planned missions aim to return to the Moon, explore Mars, and push further into the Solar System.",
            imageName: nil,
            bulletPoints: [],
            subsections: [],
            gridItems: [
                GridItemData(
                    title: "Artemis Program",
                    description: "NASA's plan to return humans to the Moon and establish a lunar base."
                ),
                GridItemData(
                    title: "Mars Missions",
                    description: "Plans for human missions to Mars in the 2030s-2040s."
                ),
                GridItemData(
                    title: "Europa Clipper",
                    description: "Mission to study Jupiter's moon Europa, which may have an ocean."
                ),
                GridItemData(
                    title: "James Webb Discoveries",
                    description: "Continuing to reveal secrets of the early universe and exoplanets."
                )
            ]
        )
    ],
    keyConcepts: [
        "**Space Race:** Competition between US and USSR in space exploration",
        "**ISS:** International Space Station, orbiting laboratory",
        "**Rover:** Robotic vehicle for planetary exploration",
        "**Space Telescope:** Observatory above Earth's atmosphere",
        "**Artemis:** NASA's Moon exploration program"
    ],
    nextLessonId: nil
)

#Preview {
    LessonView(lessonId: "solar-system")
        .environmentObject(AppState())
}


