//
//  MarvelUseCase.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 09/06/25.
//

import Foundation

protocol MarvelUseCaseProtocol {
    // Specify { get set } in protocols to have conforming types to provide a setter
    var repo: MarvelRepositoryProtocol { get set }
    
    func getCharacters() async -> [MarvelCharacterResult]
    
    func getFullSeries(for characterId: Int) async -> [MarvelFullSeries]
}

final class MarvelUseCase: MarvelUseCaseProtocol {
    var repo: any MarvelRepositoryProtocol

    init(repo: any MarvelRepositoryProtocol = MarvelRepository(networkMarvel: NetworkMarvel())) {
        self.repo = repo
    }

    func getCharacters() async -> [MarvelCharacterResult] {
        await repo.getCharacters()
    }

    // Fetches FULL series info for a character (not just the item summary)
    func getFullSeries(for characterId: Int) async -> [MarvelFullSeries] {
        await repo.getFullSeries(for: characterId)
    }
}

// MARK: - Mock

final class MarvelUseCaseMock: MarvelUseCaseProtocol {
    var repo: any MarvelRepositoryProtocol

    init(repo: any MarvelRepositoryProtocol = MarvelRepositoryMock()) {
        self.repo = repo
    }

    func getCharacters() async -> [MarvelCharacterResult] {
        await repo.getCharacters()
    }

    // Returns mock full series list for previews/tests
    func getFullSeries(for characterId: Int) async -> [MarvelFullSeries] {
        await repo.getFullSeries(for: characterId)
    }
}
