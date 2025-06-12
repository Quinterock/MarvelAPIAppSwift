//
//  MarvelUseCase.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 09/06/25.
//

import Foundation

protocol MarvelUseCaseProtocol {
    var repo: MarvelRepositoryProtocol { get set }
    
    func getCharacters() async -> [MarvelCharacterResult]
    
    func getSeries(for characterId: Int) async -> [MarvelSeriesItem]
}

final class MarvelUseCase: MarvelUseCaseProtocol {
    var repo: any MarvelRepositoryProtocol
    
    init(repo: any MarvelRepositoryProtocol = MarvelRepository(networkMarvel: NetworkMarvel())) {
        self.repo = repo
    }
    
    func getCharacters() async -> [MarvelCharacterResult] {
        return await repo.getCharacters()
    }
    
    func getSeries(for characterId: Int) async -> [MarvelSeriesItem] {
        return await repo.getSeries(for: characterId)
    }
}

// MarvelUseCaseMock

final class MarvelUseCaseMock: MarvelUseCaseProtocol {
    var repo: any MarvelRepositoryProtocol
    
    init(repo: any MarvelRepositoryProtocol = MarvelRepositoryMock()) {
        self.repo = repo
    }
    
    func getCharacters() async -> [MarvelCharacterResult] {
        return await repo.getCharacters()
    }
    
    func getSeries(for characterId: Int) async -> [MarvelSeriesItem] {
        return await repo.getSeries(for: characterId)
    }
}
