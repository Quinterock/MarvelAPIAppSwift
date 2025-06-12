//
//  MarvelRepositoryProtocol.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 07/06/25.
//

protocol MarvelRepositoryProtocol {
    // Get Marvel Characters
    func getCharacters() async -> [MarvelCharacterResult]
    // Get Marvel Series
    func getFullSeries(for characterId: Int) async -> [MarvelFullSeries]
}
