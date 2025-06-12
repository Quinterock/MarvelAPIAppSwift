//
//  CharactersListView.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 09/06/25.
//

import SwiftUI

struct CharactersListView: View {
    @ObservedObject var viewModel: MarvelViewModel

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoadingCharacters {
                    ProgressView("Loading characters...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                                        viewModel.selectCharacter(character)
                                    }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Marvel Characters")
        }
        .task {
            if viewModel.characters.isEmpty {
                await viewModel.fetchCharacters()
            }
        }
    }
}

#Preview {
    CharactersListView(
        viewModel: MarvelViewModel(useCase: MarvelUseCaseMock())
    )
}
