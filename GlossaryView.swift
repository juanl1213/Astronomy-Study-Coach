//
//  GlossaryView.swift
//  AstronomyStudyCoach
//
//  Created by user on 11/29/25.
//

//
//  GlossaryView.swift
//  Astronomy Study Coach
//
//  Astronomy Glossary page displaying terms and definitions
//

import SwiftUI

struct GlossaryView: View {
    let onNavigate: (String) -> Void
    @EnvironmentObject var appState: AppState
    
    @State private var searchTerm = ""
    @State private var selectedCategory = "General"
    
    private let categories = ["General", "Solar System", "Stars", "Galaxies & Cosmology", "Observation"]
    
    private var glossaryTerms: [String: [GlossaryTerm]] {
        [
            "General": [
                GlossaryTerm(term: "Astronomy", definition: "The scientific study of celestial objects, space, and the universe as a whole."),
                GlossaryTerm(term: "Celestial", definition: "Relating to the sky or outer space as observed in astronomy."),
                GlossaryTerm(term: "Light-year", definition: "The distance light travels in one year, approximately 9.46 trillion kilometers."),
                GlossaryTerm(term: "Parsec", definition: "A unit of distance equal to about 3.26 light-years."),
                GlossaryTerm(term: "Redshift", definition: "The stretching of light to longer wavelengths as an object moves away from us.")
            ],
            "Solar System": [
                GlossaryTerm(term: "Asteroid", definition: "A small rocky body orbiting the Sun, most found between Mars and Jupiter."),
                GlossaryTerm(term: "Astronomical Unit (AU)", definition: "The average distance from Earth to the Sun, about 150 million kilometers."),
                GlossaryTerm(term: "Comet", definition: "An icy body that releases gas and dust, forming a tail when approaching the Sun."),
                GlossaryTerm(term: "Dwarf Planet", definition: "A celestial body that orbits the Sun and is spherical but hasn't cleared its orbit."),
                GlossaryTerm(term: "Ecliptic", definition: "The plane of Earth's orbit around the Sun."),
                GlossaryTerm(term: "Kuiper Belt", definition: "Region beyond Neptune containing icy bodies and dwarf planets."),
                GlossaryTerm(term: "Meteoroid", definition: "A small rock or particle in space."),
                GlossaryTerm(term: "Meteor", definition: "A meteoroid burning up in Earth's atmosphere, also called a shooting star."),
                GlossaryTerm(term: "Meteorite", definition: "A meteoroid that survives passage through the atmosphere and lands on Earth.")
            ],
            "Stars": [
                GlossaryTerm(term: "Binary Star", definition: "A system of two stars orbiting their common center of mass."),
                GlossaryTerm(term: "Main Sequence", definition: "The stable phase of a star's life where it fuses hydrogen into helium."),
                GlossaryTerm(term: "Nebula", definition: "A cloud of gas and dust in space, often a star-forming region."),
                GlossaryTerm(term: "Nuclear Fusion", definition: "The process of combining atomic nuclei to form heavier elements, releasing energy."),
                GlossaryTerm(term: "Protostar", definition: "A very young star in the early stages of formation."),
                GlossaryTerm(term: "Red Giant", definition: "A large, cool star in a late stage of stellar evolution."),
                GlossaryTerm(term: "Supernova", definition: "A powerful explosion marking the death of a massive star."),
                GlossaryTerm(term: "White Dwarf", definition: "The hot, dense core remnant of a sun-like star after it has exhausted its fuel."),
                GlossaryTerm(term: "Neutron Star", definition: "An extremely dense collapsed core of a massive star, composed mostly of neutrons."),
                GlossaryTerm(term: "Pulsar", definition: "A rapidly rotating neutron star that emits beams of radiation.")
            ],
            "Galaxies & Cosmology": [
                GlossaryTerm(term: "Active Galactic Nucleus (AGN)", definition: "A region at the center of a galaxy with unusually high luminosity."),
                GlossaryTerm(term: "Big Bang", definition: "The event that marked the beginning of the universe 13.8 billion years ago."),
                GlossaryTerm(term: "Black Hole", definition: "A region of spacetime where gravity is so strong that nothing can escape."),
                GlossaryTerm(term: "Dark Energy", definition: "Mysterious energy causing the universe's expansion to accelerate."),
                GlossaryTerm(term: "Dark Matter", definition: "Invisible matter detected only through its gravitational effects."),
                GlossaryTerm(term: "Event Horizon", definition: "The boundary of a black hole beyond which nothing can escape."),
                GlossaryTerm(term: "Galaxy", definition: "A massive system of stars, gas, dust, and dark matter bound by gravity."),
                GlossaryTerm(term: "Galaxy Cluster", definition: "A group of galaxies bound together by gravity."),
                GlossaryTerm(term: "Quasar", definition: "An extremely luminous active galactic nucleus powered by a supermassive black hole."),
                GlossaryTerm(term: "Supermassive Black Hole", definition: "A black hole with millions to billions of solar masses, found at galaxy centers.")
            ],
            "Observation": [
                GlossaryTerm(term: "Apparent Magnitude", definition: "How bright an object appears from Earth."),
                GlossaryTerm(term: "Constellation", definition: "A pattern of stars as seen from Earth, used for navigation and identification."),
                GlossaryTerm(term: "Ecliptic", definition: "The apparent path of the Sun across the sky over the course of a year."),
                GlossaryTerm(term: "Equinox", definition: "When day and night are approximately equal in length, occurring twice yearly."),
                GlossaryTerm(term: "Light Pollution", definition: "Excessive artificial light that makes it difficult to observe celestial objects."),
                GlossaryTerm(term: "Solstice", definition: "When the Sun reaches its highest or lowest point in the sky, occurring twice yearly."),
                GlossaryTerm(term: "Spectrum", definition: "The range of wavelengths of electromagnetic radiation."),
                GlossaryTerm(term: "Transit", definition: "The passage of a celestial body across the face of another, larger body."),
                GlossaryTerm(term: "Zenith", definition: "The point in the sky directly overhead an observer.")
            ]
        ]
    }
    
    private func filterTerms(_ terms: [GlossaryTerm]) -> [GlossaryTerm] {
        if searchTerm.isEmpty {
            return terms
        }
        let lowerSearch = searchTerm.lowercased()
        return terms.filter { term in
            term.term.lowercased().contains(lowerSearch) ||
            term.definition.lowercased().contains(lowerSearch)
        }
    }
    
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
                        Text("Astronomy Glossary")
                            .font(.appTitle)
                            .foregroundStyle(LinearGradient.textGradient)
                        
                        Text("Quick reference guide to astronomical terms and concepts.")
                            .font(.appBody)
                            .foregroundColor(.mutedForeground)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, Spacing.lg)
                    
                    // Search Bar
                    searchBar
                    
                    // Category Tabs
                    categoryTabs
                    
                    // Terms List
                    termsList
                    
                    // Call to Action
                    callToAction
                }
            }
        }
        .background(Color.background)
    }
    
    // MARK: - Search Bar
    private var searchBar: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.mutedForeground)
            
            TextField("Search terms...", text: $searchTerm)
                .font(.appBody)
                .foregroundColor(.foreground)
                .textFieldStyle(PlainTextFieldStyle())
        }
        .padding(Spacing.md)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .stroke(Color.border, lineWidth: 1)
        )
        .padding(.horizontal, Spacing.lg)
    }
    
    // MARK: - Category Tabs
    private var categoryTabs: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.sm) {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                    }) {
                        Text(category == "Galaxies & Cosmology" ? "Galaxies" : category)
                            .font(.appSmall)
                            .fontWeight(.medium)
                            .foregroundColor(selectedCategory == category ? .white : .foreground)
                            .padding(.horizontal, Spacing.md)
                            .padding(.vertical, Spacing.sm)
                            .background(selectedCategory == category ? AnyShapeStyle(LinearGradient.primaryGradient) : AnyShapeStyle(Color.inputBackground))
                            .cornerRadius(CornerRadius.md)
                            .overlay(
                                RoundedRectangle(cornerRadius: CornerRadius.md)
                                    .stroke(selectedCategory == category ? Color.clear : Color.border, lineWidth: 1)
                            )
                    }
                }
            }
            .padding(.horizontal, Spacing.lg)
        }
    }
    
    // MARK: - Terms List
    private var termsList: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            if let terms = glossaryTerms[selectedCategory] {
                // Category header
                HStack {
                    Text(selectedCategory)
                        .font(.appHeading)
                        .foregroundColor(.foreground)
                    
                    Spacer()
                    
                    Text("\(filterTerms(terms).count) terms")
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                }
                .padding(.horizontal, Spacing.lg)
                
                // Terms
                if filterTerms(terms).isEmpty {
                    VStack(spacing: Spacing.sm) {
                        Text("No terms found matching \"\(searchTerm)\"")
                            .font(.appBody)
                            .foregroundColor(.mutedForeground)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(Spacing.xl)
                    .background(Color.cardBackground)
                    .cornerRadius(CornerRadius.lg)
                    .padding(.horizontal, Spacing.lg)
                } else {
                    VStack(spacing: Spacing.sm) {
                        ForEach(filterTerms(terms), id: \.term) { term in
                            TermCard(term: term)
                        }
                    }
                    .padding(.horizontal, Spacing.lg)
                }
            }
        }
    }
    
    // MARK: - Call to Action
    private var callToAction: some View {
        VStack(spacing: Spacing.md) {
            Text("Want to learn more about these concepts?")
                .font(.appBody)
                .foregroundColor(.mutedForeground)
            
            Button(action: {
                Task { @MainActor in
                    appState.navigate(to: "study")
                }
            }) {
                HStack(spacing: Spacing.sm) {
                    Image(systemName: "book.fill")
                        .font(.system(size: 16, weight: .medium))
                    Text("Browse Study Topics")
                        .font(.appBody)
                        .fontWeight(.semibold)
                }
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

// MARK: - Glossary Term Model
struct GlossaryTerm {
    let term: String
    let definition: String
}

// MARK: - Term Card
struct TermCard: View {
    let term: GlossaryTerm
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            HStack(spacing: Spacing.sm) {
                Image(systemName: "book.fill")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(LinearGradient.textGradient)
                
                Text(term.term)
                    .font(.appBody)
                    .fontWeight(.semibold)
                    .foregroundColor(.foreground)
            }
            
            Text(term.definition)
                .font(.appBody)
                .foregroundColor(.mutedForeground)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Spacing.md)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .stroke(Color.border, lineWidth: 1)
        )
    }
}

#Preview {
    GlossaryView(onNavigate: { _ in })
        .environmentObject(AppState())
        .preferredColorScheme(.dark)
}

