//
//  FlashcardSet.swift
//  AstronomyStudyCoach
//
//  Created by user on 12/2/25.
//

//
//  FlashcardSet.swift
//  Astronomy Study Coach
//
//  Models for flashcard sets
//

import SwiftUI

struct FlashcardSet: Identifiable, Codable {
    let id: UUID
    var name: String
    var description: String
    var cards: [Flashcard]
    var createdAt: Date
    var isDefault: Bool
    
    init(id: UUID = UUID(), name: String, description: String = "", cards: [Flashcard] = [], createdAt: Date = Date(), isDefault: Bool = false) {
        self.id = id
        self.name = name
        self.description = description
        self.cards = cards
        self.createdAt = createdAt
        self.isDefault = isDefault
    }
}

// MARK: - Flashcard Model (Updated)
struct Flashcard: Identifiable, Codable {
    var id: UUID
    var front: String
    var back: String
    var topic: String
    var difficulty: Difficulty
    
    init(id: UUID = UUID(), front: String, back: String, topic: String, difficulty: Difficulty) {
        self.id = id
        self.front = front
        self.back = back
        self.topic = topic
        self.difficulty = difficulty
    }
    
    enum Difficulty: String, Codable, CaseIterable {
        case easy
        case medium
        case hard
        
        var color: Color {
            switch self {
            case .easy: return .green
            case .medium: return .yellow
            case .hard: return .red
            }
        }
        
        var displayName: String {
            switch self {
            case .easy: return "Easy"
            case .medium: return "Medium"
            case .hard: return "Hard"
            }
        }
    }
}

// MARK: - Flashcard Set Manager
class FlashcardSetManager: ObservableObject {
    @Published var sets: [FlashcardSet] = []
    @Published var selectedSetId: UUID?
    
    private let defaultsKey = "flashcardSets"
    
    init() {
        loadSets()
        createDefaultSetIfNeeded()
    }
    
    var selectedSet: FlashcardSet? {
        guard let selectedId = selectedSetId else { return nil }
        return sets.first { $0.id == selectedId }
    }
    
    var defaultSet: FlashcardSet? {
        sets.first { $0.isDefault }
    }
    
    func createDefaultSetIfNeeded() {
        if defaultSet == nil {
            let defaultCards = [
                Flashcard(front: "What is a light-year?", back: "A light-year is the distance that light travels in one year in a vacuum, approximately 9.46 trillion kilometers (5.88 trillion miles). It's used to measure vast distances in space.", topic: "Basic Concepts", difficulty: .easy),
                Flashcard(front: "What causes the phases of the Moon?", back: "Moon phases are caused by the changing positions of the Moon relative to Earth and the Sun. As the Moon orbits Earth, different portions of its sunlit surface are visible from Earth.", topic: "Solar System", difficulty: .easy),
                Flashcard(front: "What is a supernova?", back: "A supernova is the explosive death of a massive star (at least 8 times the mass of our Sun). It occurs when the star's core collapses and then rebounds, creating an extremely bright explosion that can outshine an entire galaxy.", topic: "Stellar Evolution", difficulty: .medium),
                Flashcard(front: "What is dark matter?", back: "Dark matter is a form of matter that makes up approximately 27% of the universe. It doesn't emit, absorb, or reflect light, making it invisible to direct observation. Its presence is inferred through its gravitational effects on visible matter.", topic: "Cosmology", difficulty: .hard),
                Flashcard(front: "What is the difference between a planet and a dwarf planet?", back: "A planet must: 1) orbit the Sun, 2) have enough mass to be roughly round, and 3) have cleared its orbital neighborhood of other objects. A dwarf planet meets the first two criteria but has not cleared its orbital neighborhood.", topic: "Solar System", difficulty: .medium),
                Flashcard(front: "What is redshift?", back: "Redshift is the phenomenon where light from distant objects appears shifted toward longer (redder) wavelengths. It's caused by the expansion of the universe and is key evidence for the Big Bang theory.", topic: "Cosmology", difficulty: .hard),
                Flashcard(front: "What is the main sequence of stellar evolution?", back: "The main sequence is the longest phase of a star's life, where it fuses hydrogen into helium in its core. Stars spend about 90% of their lifetime in this stable phase, including our Sun.", topic: "Stellar Evolution", difficulty: .medium),
                Flashcard(front: "What is the Goldilocks Zone?", back: "The Goldilocks Zone (or habitable zone) is the region around a star where conditions are 'just right' for liquid water to exist on a planet's surface - not too hot and not too cold.", topic: "Exoplanets", difficulty: .easy)
            ]
            
            let defaultSet = FlashcardSet(
                name: "Default Astronomy Set",
                description: "Basic astronomy concepts",
                cards: defaultCards,
                isDefault: true
            )
            sets.append(defaultSet)
            selectedSetId = defaultSet.id
            saveSets()
        } else if selectedSetId == nil {
            selectedSetId = defaultSet?.id
        }
    }
    
    func addSet(_ set: FlashcardSet) {
        sets.append(set)
        selectedSetId = set.id
        saveSets()
    }
    
    func updateSet(_ set: FlashcardSet) {
        if let index = sets.firstIndex(where: { $0.id == set.id }) {
            sets[index] = set
            saveSets()
        }
    }
    
    func deleteSet(_ set: FlashcardSet) {
        guard !set.isDefault else { return } // Can't delete default set
        sets.removeAll { $0.id == set.id }
        if selectedSetId == set.id {
            selectedSetId = defaultSet?.id
        }
        saveSets()
    }
    
    func addCard(_ card: Flashcard, to setId: UUID) {
        if let index = sets.firstIndex(where: { $0.id == setId }) {
            sets[index].cards.append(card)
            saveSets()
        }
    }
    
    func updateCard(_ card: Flashcard, in setId: UUID) {
        if let setIndex = sets.firstIndex(where: { $0.id == setId }),
           let cardIndex = sets[setIndex].cards.firstIndex(where: { $0.id == card.id }) {
            sets[setIndex].cards[cardIndex] = card
            saveSets()
        }
    }
    
    func deleteCard(_ card: Flashcard, from setId: UUID) {
        if let setIndex = sets.firstIndex(where: { $0.id == setId }) {
            sets[setIndex].cards.removeAll { $0.id == card.id }
            saveSets()
        }
    }
    
    private func saveSets() {
        if let encoded = try? JSONEncoder().encode(sets) {
            UserDefaults.standard.set(encoded, forKey: defaultsKey)
        }
    }
    
    private func loadSets() {
        if let data = UserDefaults.standard.data(forKey: defaultsKey),
           let decoded = try? JSONDecoder().decode([FlashcardSet].self, from: data) {
            sets = decoded
            if let defaultSet = sets.first(where: { $0.isDefault }) {
                selectedSetId = defaultSet.id
            }
        }
    }
}

