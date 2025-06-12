//
//  NetworkMarvel.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 07/06/25.
//

import Foundation

protocol NetworkMarvelProtocol {
    // getCharacters() returns [MarvelCharacterResult] which has character data and the series array
    
    // Get Marvel Characters
    //example: https://gateway.marvel.com/v1/public/characters
    func getCharacters() async -> [MarvelCharacterResult]
    
    // Get Marvel series, (we need the character id)
    // This func returns all the series from an specific character using  /characters/{id}/series  endpoint
    //working example: https://gateway.marvel.com/v1/public/characters/1009610/series
    func getFullSeries(for characterId: Int) async -> [MarvelFullSeries]
}

final class NetworkMarvel: NetworkMarvelProtocol {
    
    // Get Marvel Characters List
    func getCharacters() async -> [MarvelCharacterResult] {
        var characters = [MarvelCharacterResult]()
        
        // Build Characters URL
        let urlCad: String =
        "\(ConstantsApp.CONST_MARVEL_API_URL)\(Endpoints.characters.path)?apikey=\(ConstantsApp.CONST_PUBLIC_KEY)&ts=\(ConstantsApp.CONST_TS)&hash=\(ConstantsApp.CONST_HASH)"
        
        // Convert to an URL Object and see if the conversion is successful
        guard let url = URL(string: urlCad) else {
            NSLog("Error: URL inválida para characters")
            return characters
        }
        
        // Create request with GET method
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let resp = response as? HTTPURLResponse {
                if resp.statusCode == HttpResponseCodes.success {
                    // Decode ALL Character Marvel Model
                    let decodeResponse = JSONDecoder()
                    
                    // Date formatter for "modified"
                    let dateFormatter = DateFormatter()
                    // real api: "modified": "2019-12-13T16:23:45+0000"
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    decodeResponse.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    let decoded = try decodeResponse.decode(Characters.self, from: data)
                    // Return the data
                    characters = decoded.data.results
                } else {
                    NSLog("Error en la petición: Characters Response")
                }
            }
        } catch {
            NSLog("Error en la petición: Characters Session - \(error.localizedDescription)")
        }
        
        return characters
    }
    
    // Get series for an specific character
    func getFullSeries(for characterId: Int) async -> [MarvelFullSeries] {
        var series = [MarvelFullSeries]()
        
        // Series URL
        let urlCad = "\(ConstantsApp.CONST_MARVEL_API_URL)\(Endpoints.characterSeries(characterId: characterId).path)?apikey=\(ConstantsApp.CONST_PUBLIC_KEY)&ts=\(ConstantsApp.CONST_TS)&hash=\(ConstantsApp.CONST_HASH)"
        
        // Convert to an URL Object and see if the conversion is successful
        guard let url = URL(string: urlCad) else {
            NSLog("Error: URL Inválida para las series")
            return series
        }
        
        // Create request with GET method
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let resp = response as? HTTPURLResponse {
                if resp.statusCode == HttpResponseCodes.success {
                    
                    // Decode Marvel Model
                    let decodedResponse = JSONDecoder()
                    
                    // Date formatter for "modified"
                    let dateFormatter = DateFormatter()
                    // real api: "modified": "2019-12-13T16:23:45+0000"
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    decodedResponse.dateDecodingStrategy = .formatted(dateFormatter)
                    
                    let decoded = try decodedResponse.decode(SeriesResponse.self, from: data)
                    // Return the data
                    // We can use compact in case there are nulls as it removes them, is like map + filter
                    series = decoded.data.results
                } else {
                    NSLog("Error en la petición: Series Response")
                }
            }
        } catch {
            NSLog("Error en la petición: Series Session - \(error.localizedDescription)")
        }
        return series
    }
}


// Mock Class

final class NetworkMarvelMock: NetworkMarvelProtocol {
    func getCharacters() async -> [MarvelCharacterResult] {
        let spiderman = MarvelCharacterResult(
            id: 1,
            name: "Spider-Man",
            description: "El amistoso vecino Spider-Man",
            modified: Date(),
            thumbnail: MarvelThumbnail(path: "https://i.annihil.us/u/prod/marvel/i/mg/c/a0/4ce5a9bf70e19", thumbnailExtension: .jpg),
            series: MarvelSeries(
                available: 2,
                collectionURI: "https://gateway.marvel.com/v1/public/characters/1/series",
                items: [
                    MarvelSeriesItem(
                        resourceURI: "https://gateway.marvel.com/v1/public/series/1001",
                        name: "The Amazing Spider-Man"
                    ),
                    MarvelSeriesItem(
                        resourceURI: "https://gateway.marvel.com/v1/public/series/1002",
                        name: "Ultimate Spider-Man"
                    )
                ],
                returned: 2)
        ) // Spiderman
        
        let ironman = MarvelCharacterResult(
            id: 2,
            name: "Iron Man",
            description: "El genio, millonario, playboy y filántropo",
            modified: Date(),
            thumbnail: MarvelThumbnail(
                path: "https://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
                thumbnailExtension: .jpg
            ),
            series: MarvelSeries(
                available: 2,
                collectionURI: "https://gateway.marvel.com/v1/public/characters/2/series",
                items: [
                    MarvelSeriesItem(
                        resourceURI: "https://gateway.marvel.com/v1/public/series/2001",
                        name: "Iron Man: Extremis"
                    ),
                    MarvelSeriesItem(
                        resourceURI: "https://gateway.marvel.com/v1/public/series/2002",
                        name: "Iron Man: Armor Wars"
                    )
                ],
                returned: 2
            )
        ) // Iron Man
        
        return [spiderman, ironman]
    } // Get Characters
    
    func getFullSeries(for characterId: Int) async -> [MarvelFullSeries] {
        // Returns series from the mocked character
        switch characterId {
        case 1: // Spider-Man
            return [
                MarvelFullSeries(
                    id: 1001,
                    title: "The Amazing Spider-Man",
                    description: "Peter Parker balances his life as an ordinary high school student in Queens with his superhero alter-ego Spider-Man.",
                    startYear: 1963,
                    endYear: 2012,
                    thumbnail: MarvelThumbnail(path: "https://i.annihil.us/u/prod/marvel/i/mg/3/50/526548a343e4b", thumbnailExtension: .jpg)
                ),
                MarvelFullSeries(
                    id: 1002,
                    title: "Ultimate Spider-Man",
                    description: "A modern take on Spider-Man for a new generation.",
                    startYear: 2000,
                    endYear: 2011,
                    thumbnail: MarvelThumbnail(path: "https://i.annihil.us/u/prod/marvel/i/mg/6/30/526547e2d90ad", thumbnailExtension: .jpg)
                )
            ]
        case 2: // Iron Man
            return [
                MarvelFullSeries(
                    id: 2001,
                    title: "Iron Man: Extremis",
                    description: "A classic Iron Man storyline.",
                    startYear: 2005,
                    endYear: 2006,
                    thumbnail: MarvelThumbnail(path: "https://i.annihil.us/u/prod/marvel/i/mg/1/03/526547f509313", thumbnailExtension: .jpg)
                ),
                MarvelFullSeries(
                    id: 2002,
                    title: "Iron Man: Armor Wars",
                    description: "Tony Stark faces a technological crisis.",
                    startYear: 1987,
                    endYear: 1988,
                    thumbnail: MarvelThumbnail(path: "https://i.annihil.us/u/prod/marvel/i/mg/7/10/5265488f82f85", thumbnailExtension: .jpg)
                )
            ]
        default:
            return []
        }
    }
}

