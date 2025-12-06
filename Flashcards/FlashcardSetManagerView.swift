//
//  FlashcardSetManagerView.swift
//  Astronomy Study Coach
//
//  View for managing flashcard sets
//

import SwiftUI

struct FlashcardSetManagerView: View {
    @ObservedObject var setManager: FlashcardSetManager
    @Environment(\.dismiss) var dismiss
    @State private var showingCreateSet = false
    @State private var showingEditSet: FlashcardSet?
    @State private var showingCardEditor: UUID?
    @State private var editingCard: Flashcard?
    @State private var setToDelete: FlashcardSet?
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("Back")
                        }
                        .font(.appBody)
                        .foregroundColor(.foreground)
                    }
                    
                    Spacer()
                    
                    Text("Manage Sets")
                        .font(.appHeading)
                        .foregroundColor(.foreground)
                    
                    Spacer()
                    
                    Button(action: { showingCreateSet = true }) {
                        Image(systemName: "plus")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.foreground)
                    }
                }
                .padding(Spacing.lg)
                .background(Color.cardBackground)
                
                ScrollView {
                    VStack(spacing: Spacing.md) {
                        // Current Set Info
                        if let selectedSet = setManager.selectedSet {
                            currentSetCard(selectedSet)
                        }
                        
                        // All Sets
                        VStack(alignment: .leading, spacing: Spacing.md) {
                            Text("All Flashcard Sets")
                                .font(.appHeading)
                                .foregroundColor(.foreground)
                            
                            ForEach(setManager.sets) { set in
                                FlashcardSetCard(
                                    set: set,
                                    isSelected: setManager.selectedSetId == set.id,
                                    onSelect: {
                                        setManager.selectedSetId = set.id
                                    },
                                    onEdit: {
                                        showingEditSet = set
                                    },
                                    onDelete: {
                                        setToDelete = set
                                        showingDeleteAlert = true
                                    },
                                    onManageCards: {
                                        showingCardEditor = set.id
                                        editingCard = nil
                                    }
                                )
                            }
                        }
                        .padding(Spacing.lg)
                    }
                }
            }
        }
        .sheet(isPresented: $showingCreateSet) {
            CreateFlashcardSetView(setManager: setManager)
        }
        .sheet(item: $showingEditSet) { set in
            EditFlashcardSetView(setManager: setManager, set: set)
        }
        .sheet(isPresented: Binding(
            get: { showingCardEditor != nil },
            set: { if !$0 { showingCardEditor = nil; editingCard = nil } }
        )) {
            if let setId = showingCardEditor {
                FlashcardEditorView(
                    setManager: setManager,
                    setId: setId,
                    card: editingCard
                )
            }
        }
        .alert("Delete Flashcard Set", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) {
                setToDelete = nil
            }
            Button("Delete", role: .destructive) {
                if let set = setToDelete {
                    setManager.deleteSet(set)
                }
                setToDelete = nil
            }
        } message: {
            if let set = setToDelete {
                Text("Are you sure you want to delete '\(set.name)'? This will permanently delete all \(set.cards.count) flashcards in this set. This action cannot be undone.")
            }
        }
    }
    
    private func currentSetCard(_ set: FlashcardSet) -> some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text("Current Set")
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                    
                    Text(set.name)
                        .font(.appHeading)
                        .foregroundColor(.foreground)
                    
                    if !set.description.isEmpty {
                        Text(set.description)
                            .font(.appCaption)
                            .foregroundColor(.mutedForeground)
                    }
                }
                
                Spacer()
                
                if set.isDefault {
                    Text("Default")
                        .font(.appSmall)
                        .padding(.horizontal, Spacing.sm)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.2))
                        .foregroundColor(.blue)
                        .cornerRadius(CornerRadius.sm)
                }
            }
            
            HStack {
                Label("\(set.cards.count) cards", systemImage: "rectangle.stack.fill")
                    .font(.appSmall)
                    .foregroundColor(.mutedForeground)
                
                Spacer()
                
                    Button(action: {
                        showingCardEditor = set.id
                        editingCard = nil
                    }) {
                    HStack(spacing: Spacing.xs) {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Card")
                    }
                    .font(.appSmall)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.horizontal, Spacing.md)
                    .padding(.vertical, Spacing.xs)
                    .background(LinearGradient.primaryGradient)
                    .cornerRadius(CornerRadius.sm)
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
        .padding(.horizontal, Spacing.lg)
        .padding(.top, Spacing.lg)
    }
}

struct FlashcardSetCard: View {
    let set: FlashcardSet
    let isSelected: Bool
    let onSelect: () -> Void
    let onEdit: () -> Void
    let onDelete: () -> Void
    let onManageCards: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    HStack {
                        Text(set.name)
                            .font(.appBody)
                            .fontWeight(.semibold)
                            .foregroundColor(.foreground)
                        
                        if set.isDefault {
                            Text("Default")
                                .font(.appSmall)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.blue.opacity(0.2))
                                .foregroundColor(.blue)
                                .cornerRadius(CornerRadius.sm)
                        }
                    }
                    
                    if !set.description.isEmpty {
                        Text(set.description)
                            .font(.appSmall)
                            .foregroundColor(.mutedForeground)
                            .lineLimit(2)
                    }
                }
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.green)
                }
            }
            
            HStack {
                Label("\(set.cards.count) cards", systemImage: "rectangle.stack.fill")
                    .font(.appSmall)
                    .foregroundColor(.mutedForeground)
                
                Spacer()
                
                HStack(spacing: Spacing.sm) {
                    Button(action: onManageCards) {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 14))
                            .foregroundColor(.primary)
                    }
                    
                    if !set.isDefault {
                        Button(action: onEdit) {
                            Image(systemName: "pencil")
                                .font(.system(size: 14))
                                .foregroundColor(.primary)
                        }
                        
                        Button(action: onDelete) {
                            Image(systemName: "trash")
                                .font(.system(size: 14))
                                .foregroundColor(.red)
                        }
                    }
                    
                    Button(action: onSelect) {
                        Text(isSelected ? "Selected" : "Select")
                            .font(.appSmall)
                            .fontWeight(.medium)
                            .foregroundColor(isSelected ? .white : .foreground)
                            .padding(.horizontal, Spacing.md)
                            .padding(.vertical, Spacing.xs)
                            .background(isSelected ? AnyShapeStyle(LinearGradient.primaryGradient) : AnyShapeStyle(Color.inputBackground))
                            .cornerRadius(CornerRadius.sm)
                    }
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .stroke(isSelected ? Color.primary : Color.border, lineWidth: isSelected ? 2 : 1)
        )
    }
}

struct CreateFlashcardSetView: View {
    @ObservedObject var setManager: FlashcardSetManager
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var description = ""
    @FocusState private var focusedField: Field?
    
    enum Field {
        case name
        case description
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: Spacing.lg) {
                        // Set Name
                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            Text("Set Name")
                                .font(.appBody)
                                .fontWeight(.semibold)
                                .foregroundColor(.foreground)
                            
                            TextField("Enter set name", text: $name)
                                .font(.appBody)
                                .foregroundColor(.foreground)
                                .padding(Spacing.sm)
                                .background(Color.inputBackground)
                                .cornerRadius(CornerRadius.sm)
                                .overlay(
                                    RoundedRectangle(cornerRadius: CornerRadius.sm)
                                        .stroke(Color.border, lineWidth: 1)
                                )
                                .focused($focusedField, equals: .name)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.words)
                        }
                        
                        // Description
                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            Text("Description (optional)")
                                .font(.appBody)
                                .fontWeight(.semibold)
                                .foregroundColor(.foreground)
                            
                            TextEditor(text: $description)
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
                                .focused($focusedField, equals: .description)
                                .autocorrectionDisabled()
                        }
                    }
                    .padding(Spacing.lg)
                }
            }
            .navigationTitle("New Flashcard Set")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Create") {
                        let newSet = FlashcardSet(
                            name: name,
                            description: description,
                            cards: []
                        )
                        setManager.addSet(newSet)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}

struct EditFlashcardSetView: View {
    @ObservedObject var setManager: FlashcardSetManager
    let set: FlashcardSet
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String
    @State private var description: String
    @FocusState private var focusedField: Field?
    
    enum Field {
        case name
        case description
    }
    
    init(setManager: FlashcardSetManager, set: FlashcardSet) {
        self.setManager = setManager
        self.set = set
        _name = State(initialValue: set.name)
        _description = State(initialValue: set.description)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: Spacing.lg) {
                        // Set Name
                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            Text("Set Name")
                                .font(.appBody)
                                .fontWeight(.semibold)
                                .foregroundColor(.foreground)
                            
                            TextField("Enter set name", text: $name)
                                .font(.appBody)
                                .foregroundColor(.foreground)
                                .padding(Spacing.sm)
                                .background(Color.inputBackground)
                                .cornerRadius(CornerRadius.sm)
                                .overlay(
                                    RoundedRectangle(cornerRadius: CornerRadius.sm)
                                        .stroke(Color.border, lineWidth: 1)
                                )
                                .focused($focusedField, equals: .name)
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.words)
                        }
                        
                        // Description
                        VStack(alignment: .leading, spacing: Spacing.sm) {
                            Text("Description (optional)")
                                .font(.appBody)
                                .fontWeight(.semibold)
                                .foregroundColor(.foreground)
                            
                            TextEditor(text: $description)
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
                                .focused($focusedField, equals: .description)
                                .autocorrectionDisabled()
                        }
                    }
                    .padding(Spacing.lg)
                }
            }
            .navigationTitle("Edit Set")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        var updatedSet = set
                        updatedSet.name = name
                        updatedSet.description = description
                        setManager.updateSet(updatedSet)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}


