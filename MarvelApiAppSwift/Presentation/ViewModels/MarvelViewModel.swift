//
//  MarvelViewModel.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 09/06/25.
//

import Foundation

@MainActor
final class MarvelViewModel: ObservableObject {
    // MARK: Public properties

    // Characters list from Model
    @Published var characters: [MarvelCharacterResult] = []
    // Used for ProgressView in CharactersListView
    @Published var isLoadingCharacters: Bool = false
    @Published var errorCharacters: String?

    // Selected character and its series
    @Published var selectedCharacter: MarvelCharacterResult?
    @Published var series: [MarvelFullSeries] = []
    // Used for ProgressView in SeriesListView
    @Published var isLoadingSeries: Bool = false
    @Published var errorSeries: String?
    
    @Published var selectedSerie: MarvelFullSeries?

    // Dependencies
    private let useCase: MarvelUseCaseProtocol

    init(useCase: MarvelUseCaseProtocol = MarvelUseCase()) {
        self.useCase = useCase
    }

    // Fetch all characters
    func fetchCharacters() async {
        isLoadingCharacters = true
        errorCharacters = nil
        defer { isLoadingCharacters = false }

        let result = await useCase.getCharacters()
        if result.isEmpty {
            errorCharacters = "No se pudieron cargar los personajes"
        }
        self.characters = result
    }

    // Select a character and fetch its series
    func selectCharacter(_ character: MarvelCharacterResult) {
        self.selectedCharacter = character
        Task {
            await fetchSeries(for: character.id)
        }
    }

    // Fetch full series info for a character
    func fetchSeries(for characterId: Int) async {
        isLoadingSeries = true
        errorSeries = nil
        defer { isLoadingSeries = false }

        let result = await useCase.getFullSeries(for: characterId)
        if result.isEmpty {
            errorSeries = "Este personaje no contiene series."
        }
        self.series = result
    }
    
    // Select a serie and fetch its details
    func fetchSerieDetail(_ serie: MarvelFullSeries) {
        self.selectedSerie = serie
        Task {
            await fetchSeries(for: serie.id)
        }
    }

    // Used when closing a character or series view to clear selection
    func clearSelection() {
        selectedCharacter = nil
        series = []
        errorSeries = nil
    }
}




