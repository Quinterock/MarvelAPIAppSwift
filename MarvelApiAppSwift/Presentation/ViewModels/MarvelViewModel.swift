//
//  MarvelViewModel.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 09/06/25.
//

import Foundation

@MainActor
final class MavelViewModel: ObservableObject {
    // MARK: Public properties
    // Heroes list from Model
    @Published var characters: [MarvelCharacterResult] = []
    
    // Used to control visual states
    @Published var isLoadingCharacters: Bool = false
    @Published var errorCharacters: String?
    
    // from Model
    @Published var selectedCharacter: MarvelCharacterResult?
    // from Model
    @Published var series: [MarvelSeriesItem] = []
    
    // Used to control visual states
    @Published var isLoadingSeries: Bool = false
    @Published var errorSeries: String?
    
    // Dependencies
    private let useCase: MarvelUseCaseProtocol
    
    init(useCase: MarvelUseCaseProtocol = MarvelUseCase()) {
        self.useCase = useCase
    }
    
    func fetchCharacters() async {
        isLoadingCharacters = true
        errorCharacters = nil
        
        // Execute no matter what, to close loading screen, it executes right before the function ends
        defer { isLoadingCharacters = false }
        let result = await useCase.getCharacters()
        if result.isEmpty {
            errorCharacters = "No se pudieron cargar los personajes"
        }
        self.characters = result
    } // fetchCharacters
    
    func selectCharacter(_ character: MarvelCharacterResult) {
        self.selectedCharacter = character
        Task {
            await fetchSeries(for: character.id)
        }
    } // selectCharacter
    
    func fetchSeries(for characterId: Int) async {
        isLoadingSeries = true
        errorSeries = nil
        // Execute no matter what, to close loading screen, it executes right before the function ends
        defer { isLoadingSeries = false }
        let result = await useCase.getSeries(for: characterId)
        if result.isEmpty {
            errorSeries = "No se encontraron series para este personaje"
        }
        self.series = result
    } // fetchSeries
    
    // Used when closing a character or series view to delete selected characters or series
    func clearSelection() {
            selectedCharacter = nil
            series = []
            errorSeries = nil
        } // clearSelection
}






//import Foundation
//
//@Observable
//final class MarvelViewModel {
//    // Pubishers
//    var heroesData = [MarvelCharacterResult]()
////    var filterUI: String = ""
//    
//    @ObservationIgnored
//    private var useCaseMarvel: MarvelUseCaseProtocol
//    
//    init( useCaseMarvel: MarvelUseCaseProtocol = MarvelUseCase()) {
//        self.useCaseMarvel = useCaseMarvel
//        
//        Task {
//            await self.useCaseMarvel.getCharacters()
//        }
//    }
//    
//    @MainActor // Esto cambia el UI
//    func getHeroes() async {
//        let data = await useCaseMarvel.getCharacters()
//        self.heroesData = data
//    }
//    
//    @MainActor
//    func getSeries(for characterId: Int) async {
//        let data = await useCaseMarvel.getSeries(for: cha)
//        self.heroesData = data
//    }
//    
//    
//    
//} // final class
