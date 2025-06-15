//
//  MarvelRepository.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 07/06/25.
//

import Foundation

final class MarvelRepository: MarvelRepositoryProtocol {
    
    private let networkMarvel: NetworkMarvelProtocol
    
    init(networkMarvel: NetworkMarvelProtocol = NetworkMarvel()) {
        self.networkMarvel = networkMarvel
    }
    
    func getCharacters() async -> [MarvelCharacterResult] {
        await networkMarvel.getCharacters()
    }
    
    func getFullSeries(for characterId: Int) async -> [MarvelFullSeries] {
        await networkMarvel.getFullSeries(for: characterId)
    }
}

// Mock

final class MarvelRepositoryMock: MarvelRepositoryProtocol {
    private var network: NetworkMarvelProtocol
    
    init(network: NetworkMarvelProtocol = NetworkMarvelMock()) {
        self.network = network
    }
    
    func getCharacters() async -> [MarvelCharacterResult] {
        return await network.getCharacters()
    }
    
    func getFullSeries(for characterId: Int) async -> [MarvelFullSeries] {
        return await network.getFullSeries(for: characterId)
    }
}
