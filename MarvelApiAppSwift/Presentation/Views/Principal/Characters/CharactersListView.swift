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
                        .frame(maxWidth: 1, maxHeight: 15)
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
                    ScrollViewReader { proxy in
                        
                        ZStack {
                            ScrollView {
                                LazyVStack(spacing: 24) {
                                    ForEach(viewModel.characters) { character in
                                        CharactersRowView(character: character)
                                            .onTapGesture {
                                                activeCharacter = character
                                                viewModel.selectCharacter(character)
                                            }
                                    }
                                }
                                .padding()
                                
                            } // ScrollView HerosList
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    Button {
                                        withAnimation {
                                            // Scroll to the last item
                                            if let last = viewModel.characters.last {
                                                proxy.scrollTo(last.id, anchor: .bottom)
                                            }
                                        }
                                    } label: {
                                        Image(systemName: "arrow.down")
                                            .font(.system(size: 24))
                                            .foregroundColor(.black)
                                            .padding()
                                            .background(Color.white)
                                            .clipShape(Circle())
                                            .shadow(radius: 8)
                                            .padding()
                                    }
                                } // HStack
                            }
                        } // ZStack
                    } // ScrollViewReader
                } // else
            } // Group
            .navigationTitle("Marvel Characters")
            // Programmatic destination using a binding
            .navigationDestination(item: $activeCharacter) { character in
                SeriesListScreen(viewModel: viewModel, character: character)
            }
            
            
            
        } // NavigationStack
        .task {
            if viewModel.characters.isEmpty {
                await viewModel.fetchCharacters()
            }
        }
    } // View
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
                        .frame(width: 280)
                    Spacer()
                        .frame(height: 24)
                    Button("Retry") {
                        Task { await viewModel.fetchSeries(for: character.id) }
                    }
                }
            } else {
                // SeriesListView Call
                SeriesListView(series: viewModel.series, viewModel: viewModel)
            }
        }
        .navigationTitle(character.name)
        .onAppear {
            // Only fetch if needed
            if viewModel.series.isEmpty || viewModel.selectedCharacter?.id != character.id {
                // If Hero has not Series
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

