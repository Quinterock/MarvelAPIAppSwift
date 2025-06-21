//
//  CharactersListView.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 09/06/25.
//

import SwiftUI

struct CharactersListView: View {
    @ObservedObject var viewModel: MarvelViewModel

    // For programmatic navigation
    @State private var activeCharacter: MarvelCharacterResult?

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoadingCharacters {
                    ProgressView("Loading characters...")
                        .frame(maxWidth: 1, maxHeight: 20)
                } else if let error = viewModel.errorCharacters {
                    VStack(spacing: 16) {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                        Button("Retry") {
                            Task { await viewModel.fetchCharacters() }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.characters) { character in
                                CharactersRowView(character: character)
                                    .onTapGesture {
                                        activeCharacter = character
                                        viewModel.selectCharacter(character)
                                    }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Marvel Characters")
            // Programmatic destination using a binding
            .navigationDestination(item: $activeCharacter) { character in
                SeriesListScreen(viewModel: viewModel, character: character)
            }
        }
        .task {
            if viewModel.characters.isEmpty {
                await viewModel.fetchCharacters()
            }
        }
    }
}

struct SeriesListScreen: View {
    @ObservedObject var viewModel: MarvelViewModel
    let character: MarvelCharacterResult

    var body: some View {
        Group {
            if viewModel.isLoadingSeries {
                ProgressView("Loading series...")
            } else if let error = viewModel.errorSeries {
                VStack(spacing: 16) {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                    Button("Retry") {
                        Task { await viewModel.fetchSeries(for: character.id) }
                    }
                }
            } else {
                SeriesListView(series: viewModel.series)
            }
        }
        .navigationTitle(character.name)
        .onAppear {
            // Only fetch if needed
            if viewModel.series.isEmpty || viewModel.selectedCharacter?.id != character.id {
                viewModel.selectCharacter(character)
            }
        }
    }
}

#Preview {
    CharactersListView(
        viewModel: MarvelViewModel(useCase: MarvelUseCaseMock())
    )
}

