//
//  MarvelRepositoryProtocol.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 07/06/25.
//

protocol MarvelRepositoryProtocol {
    // When we access to characters or series from the API, we work with the MarvelModel.data.results lists of type [Result]
    // Every [Result] as return type is a characetr with its details (id, name desc ..... series)
    
    // Get Marvel Characters
    func getCharacters(filter: String) async -> [Result]
    // Get Marvel Series
    func getSeries(filter: String) async -> [Result]
}
