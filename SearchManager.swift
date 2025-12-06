//
//  SearchManager.swift
//  AstroLearn
//
//  Created by user on 12/4/25.
//


import Foundation

enum ContentType: String, CaseIterable {
    case lesson
    case quiz
    case flashcard
    case glossary
    case constellation
    case resource
    
    var displayName: String {
        switch self {
        case .lesson: return "Lessons"
        case .quiz: return "Quizzes"
        case .flashcard: return "Flashcards"
        case .glossary: return "Glossary"
        case .constellation: return "Constellations"
        case .resource: return "Resources"
        }
    }
    
    var icon: String {
        switch self {
        case .lesson: return "book.fill"
        case .quiz: return "target"
        case .flashcard: return "brain"
        case .glossary: return "text.book.closed.fill"
        case .constellation: return "star.fill"
        case .resource: return "link"
        }
    }
}

struct SearchResult: Identifiable {
    let id: UUID
    let title: String
    let snippet: String
    let type: ContentType
    let contentId: String
    let relevance: Int // Higher = more relevant
    
    init(id: UUID = UUID(), title: String, snippet: String, type: ContentType, contentId: String, relevance: Int = 1) {
        self.id = id
        self.title = title
        self.snippet = snippet
        self.type = type
        self.contentId = contentId
        self.relevance = relevance
    }
}

class SearchManager {
    static let shared = SearchManager()
    
    private init() {}
    
    // MARK: - Search Function
    func search(query: String, contentType: ContentType? = nil) -> [SearchResult] {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return []
        }
        
        let searchQuery = query.lowercased()
        var results: [SearchResult] = []
        
        // Search lessons
        if contentType == nil || contentType == .lesson {
            results.append(contentsOf: searchLessons(query: searchQuery))
        }
        
        // Search quiz questions
        if contentType == nil || contentType == .quiz {
            results.append(contentsOf: searchQuizQuestions(query: searchQuery))
        }
        
        // Search flashcards
        if contentType == nil || contentType == .flashcard {
            results.append(contentsOf: searchFlashcards(query: searchQuery))
        }
        
        // Search glossary
        if contentType == nil || contentType == .glossary {
            results.append(contentsOf: searchGlossary(query: searchQuery))
        }
        
        // Search constellations
        if contentType == nil || contentType == .constellation {
            results.append(contentsOf: searchConstellations(query: searchQuery))
        }
        
        // Search resources
        if contentType == nil || contentType == .resource {
            results.append(contentsOf: searchResources(query: searchQuery))
        }
        
        // Sort by relevance (higher first), then alphabetically
        return results.sorted { first, second in
            if first.relevance != second.relevance {
                return first.relevance > second.relevance
            }
            return first.title < second.title
        }
    }
    
    // MARK: - Search Lessons
    private func searchLessons(query: String) -> [SearchResult] {
        var results: [SearchResult] = []
        
        for (lessonId, lessonData) in LessonData.lessons {
            var matches: [String] = []
            var relevance = 0
            
            // Check title (highest relevance)
            if lessonData.title.lowercased().contains(query) {
                matches.append(lessonData.title)
                relevance += 10
            }
            
            // Check subtitle
            if lessonData.subtitle.lowercased().contains(query) {
                matches.append(lessonData.subtitle)
                relevance += 5
            }
            
            // Check key concepts
            for concept in lessonData.keyConcepts {
                if concept.lowercased().contains(query) {
                    matches.append(concept)
                    relevance += 3
                }
            }
            
            // Check sections
            for section in lessonData.sections {
                if section.title.lowercased().contains(query) {
                    matches.append(section.title)
                    relevance += 3
                }
                
                if section.content.lowercased().contains(query) {
                    let snippet = String(section.content.prefix(100))
                    matches.append(snippet)
                    relevance += 1
                }
                
                // Check bullet points
                for bullet in section.bulletPoints {
                    if bullet.lowercased().contains(query) {
                        matches.append(bullet)
                        relevance += 2
                    }
                }
            }
            
            if !matches.isEmpty {
                let snippet = matches.first ?? lessonData.subtitle
                results.append(SearchResult(
                    title: lessonData.title,
                    snippet: snippet,
                    type: .lesson,
                    contentId: lessonId,
                    relevance: relevance
                ))
            }
        }
        
        return results
    }
    
    // MARK: - Search Quiz Questions
    private func searchQuizQuestions(query: String) -> [SearchResult] {
        var results: [SearchResult] = []
        
        for (quizId, questions) in QuizQuestions.allQuizzes {
            for question in questions {
                var relevance = 0
                var snippet = question.question
                
                // Check question text (highest relevance)
                if question.question.lowercased().contains(query) {
                    relevance += 5
                }
                
                // Check explanation
                if question.explanation.lowercased().contains(query) {
                    snippet = question.explanation
                    relevance += 2
                }
                
                // Check options
                for option in question.options {
                    if option.lowercased().contains(query) {
                        relevance += 1
                    }
                }
                
                if relevance > 0 {
                    // Get quiz title from QuizData if available
                    let quizTitle = getQuizTitle(for: quizId)
                    results.append(SearchResult(
                        title: "\(quizTitle) - Question \(question.id)",
                        snippet: String(snippet.prefix(100)),
                        type: .quiz,
                        contentId: "\(quizId)-\(question.id)",
                        relevance: relevance
                    ))
                }
            }
        }
        
        return results
    }
    
    // MARK: - Search Flashcards
    private func searchFlashcards(query: String) -> [SearchResult] {
        var results: [SearchResult] = []
        
        let flashcardManager = FlashcardSetManager()
        let allSets = flashcardManager.sets
        
        for set in allSets {
            for card in set.cards {
                var relevance = 0
                var snippet = card.front
                
                // Check front text
                if card.front.lowercased().contains(query) {
                    relevance += 3
                }
                
                // Check back text
                if card.back.lowercased().contains(query) {
                    snippet = card.back
                    relevance += 2
                }
                
                // Check topic
                if card.topic.lowercased().contains(query) {
                    relevance += 1
                }
                
                if relevance > 0 {
                    results.append(SearchResult(
                        title: "\(set.name) - \(card.front)",
                        snippet: String(snippet.prefix(100)),
                        type: .flashcard,
                        contentId: card.id.uuidString,
                        relevance: relevance
                    ))
                }
            }
        }
        
        return results
    }
    
    // MARK: - Search Glossary
    private func searchGlossary(query: String) -> [SearchResult] {
        var results: [SearchResult] = []
        
        // Get glossary terms from GlossaryView's data structure
        let glossaryData = getGlossaryTerms()
        
        for (category, terms) in glossaryData {
            for term in terms {
                var relevance = 0
                
                // Check term name (highest relevance)
                if term.term.lowercased().contains(query) {
                    relevance += 5
                }
                
                // Check definition
                if term.definition.lowercased().contains(query) {
                    relevance += 2
                }
                
                if relevance > 0 {
                    results.append(SearchResult(
                        title: term.term,
                        snippet: term.definition,
                        type: .glossary,
                        contentId: term.term,
                        relevance: relevance
                    ))
                }
            }
        }
        
        return results
    }
    
    // MARK: - Search Constellations
    private func searchConstellations(query: String) -> [SearchResult] {
        var results: [SearchResult] = []
        
        // Get constellation data
        let constellations = getConstellationData()
        
        for constellation in constellations {
            var relevance = 0
            var snippet = constellation.mythology
            
            // Check name (highest relevance)
            if constellation.name.lowercased().contains(query) {
                relevance += 5
            }
            
            // Check latin name
            if constellation.latinName.lowercased().contains(query) {
                relevance += 3
            }
            
            // Check mythology
            if constellation.mythology.lowercased().contains(query) {
                relevance += 2
            }
            
            if relevance > 0 {
                results.append(SearchResult(
                    title: constellation.name,
                    snippet: String(snippet.prefix(100)),
                    type: .constellation,
                    contentId: constellation.id,
                    relevance: relevance
                ))
            }
        }
        
        return results
    }
    
    // MARK: - Search Resources
    private func searchResources(query: String) -> [SearchResult] {
        var results: [SearchResult] = []
        
        // Get resources data
        let resources = getResourcesData()
        
        for resource in resources {
            var relevance = 0
            
            // Check name (highest relevance)
            if resource.name.lowercased().contains(query) {
                relevance += 5
            }
            
            // Check description
            if resource.description.lowercased().contains(query) {
                relevance += 2
            }
            
            if relevance > 0 {
                results.append(SearchResult(
                    title: resource.name,
                    snippet: resource.description,
                    type: .resource,
                    contentId: resource.name,
                    relevance: relevance
                ))
            }
        }
        
        return results
    }
    
    // MARK: - Helper Functions
    private func getQuizTitle(for quizId: String) -> String {
        // Map quiz IDs to titles
        let quizTitles: [String: String] = [
            "solar-system": "Solar System",
            "planets": "Planets",
            "stars": "Stars",
            "galaxies": "Galaxies",
            "cosmology": "Cosmology",
            "exoplanets": "Exoplanets",
            "black-holes": "Black Holes",
            "nebulae": "Nebulae",
            "asteroids": "Asteroids",
            "space-exploration": "Space Exploration"
        ]
        return quizTitles[quizId] ?? quizId.capitalized
    }
    
    private func getGlossaryTerms() -> [String: [GlossaryTerm]] {
        // This matches the structure in GlossaryView
        return [
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
    
    private func getConstellationData() -> [Constellation] {
        // Match the structure in ConstellationsView
        return [
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
    }
    
    private func getResourcesData() -> [SearchResourceItem] {
        // Match the structure in ResourcesView
        var resources: [SearchResourceItem] = []
        
        // Websites
        resources.append(contentsOf: [
            SearchResourceItem(name: "NASA", description: "Official NASA website with latest space news and missions"),
            SearchResourceItem(name: "ESA (European Space Agency)", description: "European space exploration and research"),
            SearchResourceItem(name: "Sky & Telescope", description: "Astronomy news, observing guides, and resources"),
            SearchResourceItem(name: "Astronomy.com", description: "Popular astronomy magazine and learning resources"),
            SearchResourceItem(name: "Space.com", description: "Latest space news, exploration, and discoveries")
        ])
        
        // Educational
        resources.append(contentsOf: [
            SearchResourceItem(name: "Khan Academy Cosmology", description: "Free astronomy and cosmology video lessons"),
            SearchResourceItem(name: "Crash Course Astronomy", description: "Entertaining and educational astronomy video series"),
            SearchResourceItem(name: "NASA's Astronomy Picture of the Day", description: "Daily astronomical images with explanations"),
            SearchResourceItem(name: "Stellarium Web", description: "Online planetarium showing realistic sky")
        ])
        
        // Tools
        resources.append(contentsOf: [
            SearchResourceItem(name: "SkySafari", description: "Planetarium app for stargazing (iOS/Android)"),
            SearchResourceItem(name: "Star Walk 2", description: "Interactive astronomy guide app"),
            SearchResourceItem(name: "NASA App", description: "Official NASA app with missions, images, and videos"),
            SearchResourceItem(name: "ISS Detector", description: "Track the International Space Station")
        ])
        
        // Books
        resources.append(contentsOf: [
            SearchResourceItem(name: "Cosmos by Carl Sagan", description: "Classic exploration of the universe and our place in it"),
            SearchResourceItem(name: "Astrophysics for People in a Hurry", description: "By Neil deGrasse Tyson - Quick introduction to the cosmos"),
            SearchResourceItem(name: "The Elegant Universe by Brian Greene", description: "Introduction to string theory and modern physics"),
            SearchResourceItem(name: "A Brief History of Time by Stephen Hawking", description: "Cosmology from the Big Bang to black holes"),
            SearchResourceItem(name: "The Order of Time by Carlo Rovelli", description: "Fascinating exploration of the nature of time")
        ])
        
        return resources
    }
}


struct SearchResourceItem {
    let name: String
    let description: String
}


