//
//  MarvelUseCase.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 09/06/25.
//

import Foundation

protocol MarvelUseCaseProtocol {
    var repo: MarvelRepositoryProtocol { get set }
    
    func getCharacters(filter: String) async -> [Result]
    
    func getSeries(filter: String) async -> [Result]
}

final class MarvelUseCase: MarvelUseCaseProtocol {
    var repo: any MarvelRepositoryProtocol
    
    init(repo: any MarvelRepositoryProtocol = MarvelRepository(networkMarvel: NetworkMarvel())) {
        self.repo = repo
    }
    
    func getCharacters(filter: String) async -> [Result] {
        return await repo.getCharacters(filter: filter)
    }
    
    func getSeries(filter: String) async -> [Result] {
        return await repo.getSeries(filter: filter)
    }
}

// TODO: Mock MarvelUseCaseMock
