//
//  FlashcardEditorView.swift
//  AstronomyStudyCoach
//
//  Created by user on 12/2/25.
//


import SwiftUI

struct FlashcardEditorView: View {
    @ObservedObject var setManager: FlashcardSetManager
    let setId: UUID
    let card: Flashcard?
    @Environment(\.dismiss) var dismiss
    
    @State private var front: String
    @State private var back: String
    @State private var topic: String
    @State private var difficulty: Flashcard.Difficulty
    
    @State private var showingCardList = false
    
    init(setManager: FlashcardSetManager, setId: UUID, card: Flashcard?) {
        self.setManager = setManager
        self.setId = setId
        self.card = card
        _front = State(initialValue: card?.front ?? "")
        _back = State(initialValue: card?.back ?? "")
        _topic = State(initialValue: card?.topic ?? "")
        _difficulty = State(initialValue: card?.difficulty ?? .easy)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: Spacing.lg) {
                        // Set Info
                        if let set = setManager.sets.first(where: { $0.id == setId }) {
                            HStack {
                                VStack(alignment: .leading, spacing: Spacing.xs) {
                                    Text("Editing cards in:")
                                        .font(.appSmall)
                                        .foregroundColor(.mutedForeground)
                                    Text(set.name)
                                        .font(.appHeading)
                                        .foregroundColor(.foreground)
                                }
                                
                                Spacer()
                                
                                Button(action: { showingCardList = true }) {
                                    HStack {
                                        Image(systemName: "list.bullet")
                                        Text("View All (\(set.cards.count))")
                                    }
                                    .font(.appSmall)
                                    .foregroundColor(.primary)
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
                        
                        // Flashcard Form
                        VStack(alignment: .leading, spacing: Spacing.md) {
                            // Front Side
                            VStack(alignment: .leading, spacing: Spacing.sm) {
                                Text("Front (Question)")
                                    .font(.appBody)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.foreground)
                                
                                TextEditor(text: $front)
                                    .font(.appBody)
                                    .foregroundColor(.foreground)
                                    .frame(minHeight: 100)
                                    .padding(Spacing.sm)
                                    .background(Color.inputBackground)
                                    .cornerRadius(CornerRadius.sm)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: CornerRadius.sm)
                                            .stroke(Color.border, lineWidth: 1)
                                    )
                                
                                if front.isEmpty {
                                    Text("Enter the question or term")
                                        .font(.appSmall)
                                        .foregroundColor(.mutedForeground)
                                        .padding(.leading, Spacing.sm)
                                }
                            }
                            
                            // Back Side
                            VStack(alignment: .leading, spacing: Spacing.sm) {
                                Text("Back (Answer)")
                                    .font(.appBody)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.foreground)
                                
                                TextEditor(text: $back)
                                    .font(.appBody)
                                    .foregroundColor(.foreground)
                                    .frame(minHeight: 150)
                                    .padding(Spacing.sm)
                                    .background(Color.inputBackground)
                                    .cornerRadius(CornerRadius.sm)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: CornerRadius.sm)
                                            .stroke(Color.border, lineWidth: 1)
                                    )
                                
                                if back.isEmpty {
                                    Text("Enter the answer or definition")
                                        .font(.appSmall)
                                        .foregroundColor(.mutedForeground)
                                        .padding(.leading, Spacing.sm)
                                }
                            }
                            
                            // Topic
                            VStack(alignment: .leading, spacing: Spacing.sm) {
                                Text("Topic")
                                    .font(.appBody)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.foreground)
                                
                                TextField("e.g., Solar System, Stars, Cosmology", text: $topic)
                                    .font(.appBody)
                                    .foregroundColor(.foreground)
                                    .padding(Spacing.sm)
                                    .background(Color.inputBackground)
                                    .cornerRadius(CornerRadius.sm)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: CornerRadius.sm)
                                            .stroke(Color.border, lineWidth: 1)
                                    )
                            }
                            
                            // Difficulty
                            VStack(alignment: .leading, spacing: Spacing.sm) {
                                Text("Difficulty")
                                    .font(.appBody)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.foreground)
                                
                                Picker("Difficulty", selection: $difficulty) {
                                    ForEach(Flashcard.Difficulty.allCases, id: \.self) { diff in
                                        HStack {
                                            Circle()
                                                .fill(diff.color)
                                                .frame(width: 12, height: 12)
                                            Text(diff.displayName)
                                        }
                                        .tag(diff)
                                    }
                                }
                                .pickerStyle(.segmented)
                            }
                        }
                        .padding(Spacing.lg)
                    }
                }
            }
            .navigationTitle(card == nil ? "New Flashcard" : "Edit Flashcard")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(card == nil ? "Add" : "Save") {
                        if let existingCard = card {
                            // Update existing card
                            var updatedCard = existingCard
                            updatedCard.front = front
                            updatedCard.back = back
                            updatedCard.topic = topic
                            updatedCard.difficulty = difficulty
                            setManager.updateCard(updatedCard, in: setId)
                        } else {
                            // Create new card
                            let newCard = Flashcard(
                                front: front,
                                back: back,
                                topic: topic,
                                difficulty: difficulty
                            )
                            setManager.addCard(newCard, to: setId)
                        }
                        dismiss()
                    }
                    .disabled(front.isEmpty || back.isEmpty)
                }
            }
        }
        .sheet(isPresented: $showingCardList) {
            FlashcardListView(setManager: setManager, setId: setId)
        }
    }
}

struct FlashcardListView: View {
    @ObservedObject var setManager: FlashcardSetManager
    let setId: UUID
    @Environment(\.dismiss) var dismiss
    @State private var showingEditor = false
    @State private var editingCard: Flashcard?
    
    var set: FlashcardSet? {
        setManager.sets.first { $0.id == setId }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                if let set = set, !set.cards.isEmpty {
                    List {
                        ForEach(set.cards) { card in
                            FlashcardListRow(card: card) {
                                editingCard = card
                                showingEditor = true
                            }
                            .listRowBackground(Color.cardBackground)
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let card = set.cards[index]
                                setManager.deleteCard(card, from: setId)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                } else {
                    VStack(spacing: Spacing.md) {
                        Image(systemName: "rectangle.stack")
                            .font(.system(size: 48))
                            .foregroundColor(.mutedForeground)
                        
                        Text("No flashcards yet")
                            .font(.appHeading)
                            .foregroundColor(.foreground)
                        
                        Text("Add your first flashcard to get started")
                            .font(.appBody)
                            .foregroundColor(.mutedForeground)
                            .multilineTextAlignment(.center)
                    }
                    .padding(Spacing.xl)
                }
            }
            .navigationTitle("All Cards")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        .sheet(isPresented: $showingEditor) {
            if let card = editingCard {
                FlashcardEditorView(setManager: setManager, setId: setId, card: card)
            }
        }
    }
}

struct FlashcardListRow: View {
    let card: Flashcard
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(card.front)
                    .font(.appBody)
                    .fontWeight(.medium)
                    .foregroundColor(.foreground)
                    .lineLimit(2)
                
                HStack {
                    Text(card.topic)
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Circle()
                            .fill(card.difficulty.color)
                            .frame(width: 8, height: 8)
                        Text(card.difficulty.displayName)
                            .font(.appSmall)
                            .foregroundColor(.mutedForeground)
                    }
                }
            }
            .padding(.vertical, Spacing.xs)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

