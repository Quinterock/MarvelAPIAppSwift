//
//  Endpoints.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 07/06/25.
//

import Foundation
// Marvel Endpoints
enum Endpoints {
    // Marvel Heroes / Characters
    case characters
    
    // Marvel Heroe´s / Character´s Series
    case characterSeries(characterId: Int)
    
    var path: String {
        switch self {
        case .characters:
            return "/v1/public/characters"
        case .characterSeries(let characterId):
            // working example: https://gateway.marvel.com/v1/public/characters/1009610/series
            return "/v1/public/characters/\(characterId)/series"
        }
    }
}
