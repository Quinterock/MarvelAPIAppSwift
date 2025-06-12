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
    @Published var isLoadingCharacters: Bool = false
    @Published var errorCharacters: String?

    // Selected character and its series
    @Published var selectedCharacter: MarvelCharacterResult?
    @Published var series: [MarvelFullSeries] = []
    @Published var isLoadingSeries: Bool = false
    @Published var errorSeries: String?

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
            errorSeries = "No se encontraron series para este personaje"
        }
        self.series = result
    }

    // Used when closing a character or series view to clear selection
    func clearSelection() {
        selectedCharacter = nil
        series = []
        errorSeries = nil
    }
}






//import Foundation
//
//@MainActor
//final class MarvelViewModel: ObservableObject {
//    // MARK: Public properties
//    // Heroes list from Model
//    @Published var characters: [MarvelCharacterResult] = []
//    
//    // Used to control visual states
//    @Published var isLoadingCharacters: Bool = false
//    @Published var errorCharacters: String?
//    
//    // from Model
//    @Published var selectedCharacter: MarvelCharacterResult?
//    // from Model
//    @Published var series: [MarvelSeriesItem] = []
//    
//    // Used to control visual states
//    @Published var isLoadingSeries: Bool = false
//    @Published var errorSeries: String?
//    
//    // Dependencies
//    private let useCase: MarvelUseCaseProtocol
//    
//    init(useCase: MarvelUseCaseProtocol = MarvelUseCase()) {
//        self.useCase = useCase
//    }
//    
//    func fetchCharacters() async {
//        isLoadingCharacters = true
//        errorCharacters = nil
//        
//        // Execute no matter what, to close loading screen, it executes right before the function ends
//        defer { isLoadingCharacters = false }
//        let result = await useCase.getCharacters()
//        if result.isEmpty {
//            errorCharacters = "No se pudieron cargar los personajes"
//        }
//        self.characters = result
//    } // fetchCharacters
//    
//    func selectCharacter(_ character: MarvelCharacterResult) {
//        self.selectedCharacter = character
//        Task {
//            await fetchSeries(for: character.id)
//        }
//    } // selectCharacter
//    
//    func fetchSeries(for characterId: Int) async {
//        isLoadingSeries = true
//        errorSeries = nil
//        // Execute no matter what, to close loading screen, it executes right before the function ends
//        defer { isLoadingSeries = false }
//        let result = await useCase.getSeries(for: characterId)
//        if result.isEmpty {
//            errorSeries = "No se encontraron series para este personaje"
//        }
//        self.series = result
//    } // fetchSeries
//    
//    // Used when closing a character or series view to delete selected characters or series
//    func clearSelection() {
//            selectedCharacter = nil
//            series = []
//            errorSeries = nil
//        } // clearSelection
//}



