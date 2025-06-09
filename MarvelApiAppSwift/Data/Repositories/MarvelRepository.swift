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
    
    func getCharacters() async -> [Result] {
        await networkMarvel.getCharacters()
    }
    
    func getSeries() async -> [Result] {
        await networkMarvel.getSeries()
    }
}

// Mock

final class MarvelRepositoryMock: MarvelRepositoryProtocol {
    
    private var network: NetworkMarvelProtocol
    
    init(network: NetworkMarvelProtocol = NetworkMarvelMock()) {
        self.network = network
    }
    
    func getCharacters() async -> [Result] {
        return await network.getCharacters()
    }
    
    func getSeries() async -> [Result] {
        return await network.getSeries()
    }
}
