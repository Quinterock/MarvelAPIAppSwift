//
//  MarvelUseCase.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 09/06/25.
//

import Foundation

protocol MarvelUseCaseProtocol {
    var repo: MarvelRepositoryProtocol { get set }
    
    func getCharacters() async -> [Result]
    
    func getSeries() async -> [Result]
}

final class MarvelUseCase: MarvelUseCaseProtocol {
    var repo: any MarvelRepositoryProtocol
    
    init(repo: any MarvelRepositoryProtocol = MarvelRepository(networkMarvel: NetworkMarvel())) {
        self.repo = repo
    }
    
    func getCharacters() async -> [Result] {
        return await repo.getCharacters()
    }
    
    func getSeries() async -> [Result] {
        return await repo.getSeries()
    }
}

// TODO: Mock MarvelUseCaseMock

final class MarvelUseCaseMock: MarvelUseCaseProtocol {
    var repo: any MarvelRepositoryProtocol
    
    init(repo: any MarvelRepositoryProtocol = MarvelRepositoryMock()) {
        self.repo = repo
    }
    
    func getCharacters() async -> [Result] {
        return await repo.getCharacters()
    }
    
    func getSeries() async -> [Result] {
        return await repo.getSeries()
    }
}
