//
//  MarvelViewModel.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 09/06/25.
//

import Foundation

@Observable
final class MarvelViewModel {
    // Pubishers
    var heroesData = [Result]()
//    var filterUI: String = ""
    
    @ObservationIgnored
    private var useCaseMarvel: MarvelUseCaseProtocol
    
    init( useCaseMarvel: MarvelUseCaseProtocol = MarvelUseCase()) {
        self.useCaseMarvel = useCaseMarvel
        
        Task {
            await self.useCaseMarvel.getCharacters()
        }
    }
    
    @MainActor // Esto cambia el UI
    func getHeroes() async {
        let data = await useCaseMarvel.getCharacters()
        self.heroesData = data
    }
    
    
    
} // final class
