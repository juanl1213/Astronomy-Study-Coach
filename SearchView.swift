//
//  SearchView.swift
//  Astro Learn
//
//  Global search view for finding content across the app
//

import SwiftUI

struct SearchView: View {
    let onNavigate: (String) -> Void
    @EnvironmentObject var appState: AppState
    
    @State private var searchQuery = ""
    @State private var searchResults: [SearchResult] = []
    @State private var selectedContentType: ContentType? = nil
    @State private var isSearching = false
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                AppHeaderView()
                    .environmentObject(appState)
                
                // Search Content
                ScrollView {
                    VStack(spacing: Spacing.lg) {
                        // Search Bar
                        searchBar
                        
                        // Content Type Filter
                        if !searchQuery.isEmpty {
                            contentTypeFilter
                        }
                        
                        // Results
                        if searchQuery.isEmpty {
                            emptyStateView
                        } else if searchResults.isEmpty && !isSearching {
                            noResultsView
                        } else {
                            resultsView
                        }
                    }
                    .padding(.horizontal, Spacing.lg)
                    .padding(.top, Spacing.md)
                }
            }
        }
    }
    
    // MARK: - Search Bar
    private var searchBar: some View {
        HStack(spacing: Spacing.md) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.mutedForeground)
            
            TextField("Search lessons, quizzes, flashcards...", text: $searchQuery)
                .font(.appBody)
                .foregroundColor(.foreground)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .onChange(of: searchQuery) { newValue in
                    performSearch(query: newValue)
                }
            
            if !searchQuery.isEmpty {
                Button(action: {
                    searchQuery = ""
                    searchResults = []
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.mutedForeground)
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.inputBackground)
        .cornerRadius(CornerRadius.md)
        .overlay(
            RoundedRectangle(cornerRadius: CornerRadius.md)
                .stroke(Color.border, lineWidth: 1)
        )
    }
    
    // MARK: - Content Type Filter
    private var contentTypeFilter: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.sm) {
                // All filter
                FilterChip(
                    title: "All",
                    isSelected: selectedContentType == nil,
                    count: searchResults.count
                ) {
                    selectedContentType = nil
                    performSearch(query: searchQuery)
                }
                
                // Individual type filters
                ForEach(ContentType.allCases, id: \.self) { type in
                    let count = searchResults.filter { $0.type == type }.count
                    if count > 0 {
                        FilterChip(
                            title: type.displayName,
                            isSelected: selectedContentType == type,
                            count: count
                        ) {
                            selectedContentType = type
                            performSearch(query: searchQuery)
                        }
                    }
                }
            }
            .padding(.horizontal, Spacing.lg)
        }
    }
    
    // MARK: - Empty State
    private var emptyStateView: some View {
        VStack(spacing: Spacing.lg) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundColor(.mutedForeground)
            
            Text("Search Astro Learn")
                .font(.appHeading)
                .foregroundColor(.foreground)
            
            Text("Search across lessons, quizzes, flashcards, glossary terms, and more")
                .font(.appBody)
                .foregroundColor(.mutedForeground)
                .multilineTextAlignment(.center)
            
            VStack(alignment: .leading, spacing: Spacing.sm) {
                Text("Try searching for:")
                    .font(.appBody)
                    .fontWeight(.semibold)
                    .foregroundColor(.foreground)
                
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    SearchSuggestion(text: "black hole")
                    SearchSuggestion(text: "solar system")
                    SearchSuggestion(text: "constellation")
                    SearchSuggestion(text: "exoplanet")
                }
            }
            .padding(Spacing.lg)
            .background(Color.cardBackground)
            .cornerRadius(CornerRadius.lg)
            .padding(.top, Spacing.md)
        }
        .padding(.top, Spacing.xl)
    }
    
    // MARK: - No Results View
    private var noResultsView: some View {
        VStack(spacing: Spacing.lg) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundColor(.mutedForeground)
            
            Text("No Results Found")
                .font(.appHeading)
                .foregroundColor(.foreground)
            
            Text("Try different keywords or check your spelling")
                .font(.appBody)
                .foregroundColor(.mutedForeground)
                .multilineTextAlignment(.center)
        }
        .padding(.top, Spacing.xl)
    }
    
    // MARK: - Results View
    private var resultsView: some View {
        LazyVStack(spacing: Spacing.md) {
            // Group results by type
            let groupedResults = Dictionary(grouping: searchResults) { $0.type }
            
            ForEach(ContentType.allCases, id: \.self) { type in
                if let results = groupedResults[type], !results.isEmpty {
                    SearchResultSection(
                        type: type,
                        results: results,
                        onResultTap: { result in
                            navigateToResult(result)
                        }
                    )
                }
            }
        }
        .padding(.bottom, Spacing.xl)
    }
    
    // MARK: - Search Function
    private func performSearch(query: String) {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedQuery.isEmpty else {
            searchResults = []
            isSearching = false
            return
        }
        
        isSearching = true
        
        // Perform search on background thread
        DispatchQueue.global(qos: .userInitiated).async {
            let results = SearchManager.shared.search(query: trimmedQuery, contentType: selectedContentType)
            
            DispatchQueue.main.async {
                self.searchResults = results
                self.isSearching = false
            }
        }
    }
    
    // MARK: - Navigation
    private func navigateToResult(_ result: SearchResult) {
        switch result.type {
        case .lesson:
            onNavigate("lesson-\(result.contentId)")
        case .quiz:
            // Extract quiz ID from contentId (format: "quizId-questionId")
            let parts = result.contentId.split(separator: "-")
            if let quizId = parts.first {
                onNavigate("quiz-\(quizId)")
            }
        case .flashcard:
            onNavigate("flashcards")
        case .glossary:
            onNavigate("glossary")
        case .constellation:
            onNavigate("constellations")
        case .resource:
            onNavigate("resources")
        }
    }
}

// MARK: - Filter Chip
struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let count: Int
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: Spacing.xs) {
                Text(title)
                    .font(.appSmall)
                    .fontWeight(.medium)
                
                Text("(\(count))")
                    .font(.appSmall)
            }
            .foregroundColor(isSelected ? .white : .foreground)
            .padding(.horizontal, Spacing.md)
            .padding(.vertical, Spacing.sm)
            .background(isSelected ? AnyShapeStyle(LinearGradient.primaryGradient) : AnyShapeStyle(Color.inputBackground))
            .cornerRadius(CornerRadius.md)
            .overlay(
                RoundedRectangle(cornerRadius: CornerRadius.md)
                    .stroke(isSelected ? Color.clear : Color.border, lineWidth: 1)
            )
        }
    }
}

// MARK: - Search Suggestion
struct SearchSuggestion: View {
    let text: String
    
    var body: some View {
        HStack(spacing: Spacing.xs) {
            Image(systemName: "arrow.right")
                .font(.system(size: 12))
                .foregroundColor(.mutedForeground)
            
            Text(text)
                .font(.appSmall)
                .foregroundColor(.mutedForeground)
        }
    }
}

// MARK: - Search Result Section
struct SearchResultSection: View {
    let type: ContentType
    let results: [SearchResult]
    let onResultTap: (SearchResult) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            // Section Header
            HStack(spacing: Spacing.sm) {
                Image(systemName: type.icon)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.indigo600)
                
                Text(type.displayName)
                    .font(.appHeading)
                    .foregroundColor(.foreground)
                
                Text("(\(results.count))")
                    .font(.appSmall)
                    .foregroundColor(.mutedForeground)
            }
            
            // Results
            VStack(spacing: Spacing.sm) {
                ForEach(results.prefix(10)) { result in
                    SearchResultCard(result: result) {
                        onResultTap(result)
                    }
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.cardBackground)
        .cornerRadius(CornerRadius.lg)
    }
}

// MARK: - Search Result Card
struct SearchResultCard: View {
    let result: SearchResult
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(alignment: .top, spacing: Spacing.md) {
                // Icon
                ZStack {
                    RoundedRectangle(cornerRadius: CornerRadius.sm)
                        .fill(Color.indigo600.opacity(0.1))
                        .frame(width: 36, height: 36)
                    
                    Image(systemName: result.type.icon)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.indigo600)
                }
                
                // Content
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text(result.title)
                        .font(.appBody)
                        .fontWeight(.semibold)
                        .foregroundColor(.foreground)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    Text(result.snippet)
                        .font(.appSmall)
                        .foregroundColor(.mutedForeground)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.mutedForeground)
            }
            .padding(Spacing.md)
            .background(Color.inputBackground.opacity(0.5))
            .cornerRadius(CornerRadius.md)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    SearchView(onNavigate: { _ in })
        .environmentObject(AppState())
        .preferredColorScheme(.dark)
}


