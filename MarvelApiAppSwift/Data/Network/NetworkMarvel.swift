//
//  NetworkMarvel.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 07/06/25.
//

import Foundation

protocol NetworkMarvelProtocol {
    // When we access to characters or series from the API, we work with the MarvelModel.data.results lists of type [Result]
    // Every [Result] as return type is a characetr with its details (id, name desc ..... series)
    
    // TODO: Solo con characters vale, ver postman
    
    // Get Marvel Characters
    func getCharacters() async -> [Result]
    
    // Get Marvel
    func getSeries() async -> [Result]
}

final class NetworkMarvel: NetworkMarvelProtocol {
    
    // Get Marvel Characters List
    func getCharacters() async -> [Result] {
        var characters = [Result]()
        
        // Characters URL
        let urlCad: String =
        "\(ConstantsApp.CONST_MARVEL_API_URL)\(Endpoints.heroes.rawValue)?apikey=\(ConstantsApp.CONST_PUBLIC_KEY)&ts=\(ConstantsApp.CONST_TS)&hash=\(ConstantsApp.CONST_HASH)"
        
        // Convert to an URL Object and see if the conversion is successful
        guard let url = URL(string: urlCad) else {
            NSLog("Error: URL inválida")
            return characters
        }
        
        // Create request with GET method
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let resp = response as? HTTPURLResponse {
                if resp.statusCode == HttpResponseCodes.success {
                    // Decode Marvel Model
                    // TODO: cHECAR SI ES MarvelModel
                    let decodeResponse = try JSONDecoder().decode(MarvelModel.self, from: data)
                    // Return the data
                    characters = decodeResponse.data.results
                } else {
                    NSLog("Error en la petición: Characters Response")
                }
            }
        } catch {
            NSLog("Error en la petición: Characters Session")
        }
        
        return characters
    }
    
    
    func getSeries() async -> [Result] {
        var series = [Result]()
        
        // Series URL
        let urlCad: String = "\(ConstantsApp.CONST_MARVEL_API_URL)\(Endpoints.series.rawValue)?apikey=\(ConstantsApp.CONST_PUBLIC_KEY)&ts=\(ConstantsApp.CONST_TS)&hash=\(ConstantsApp.CONST_HASH)"
        
        // Convert to an URL Object and see if the conversion is successful
        guard let url = URL(string: urlCad) else {
            NSLog("Error: URL Inválida, Series")
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
                    let decodedResponse = try JSONDecoder().decode(MarvelModel.self, from: data)
                    // Return the data
                    series = decodedResponse.data.results
                } else {
                    NSLog("Error en la petición: Series Response")
                }
            }
        } catch {
            NSLog("Error en la petición: Series Session")
        }
        return series
    }
}


// Mock Class
// TODO: Mock NetworkMarvel

final class NetworkMarvelMock: NetworkMarvelProtocol {

    // MockCharacters
    func getCharacters() async -> [Result] {
        let character1 = Result(
                                id: 1,
                                name: "Spider-Man",
                                description: "El amistoso vecino Spider-Man",
                                modified: Date(),
                                thumbnail: Thumbnail(path: "https://preview.redd.it/so-is-insomniac-spiderman-the-strongest-version-of-spiderman-v0-of2v5w4n912f1.jpeg?width=640&crop=smart&auto=webp&s=66e5222b38d0cc2039bee7ce8ded6218c825d9fe", thumbnailExtension: .jpg),
                                resourceURI: "https://gateway.marvel.com/v1/public/characters/1",
                                comics: Comics(available: 10, collectionURI: "https://example.com/comics", items: [], returned: 10),
                                series: Comics(available: 5, collectionURI: "https://example.com/series", items: [], returned: 5),
                                stories: Stories(available: 3, collectionURI: "https://example.com/stories", items: [], returned: 3),
                                events: Comics(available: 2, collectionURI: "https://example.com/events", items: [], returned: 2),
                                urls: [URLElement(type: .detail, url: "https://marvel.com/spiderman")])
        
        let character2 = Result(
                    id: 2,
                    name: "Iron Man",
                    description: "El genio, millonario, playboy y filántropo xD",
                    modified: Date(),
                    thumbnail: Thumbnail(path: "https://playcontestofchampions.com/wp-content/uploads/2023/04/champion-iron-man.webp", thumbnailExtension: .jpg),
                    resourceURI: "https://gateway.marvel.com/v1/public/characters/2",
                    comics: Comics(available: 8, collectionURI: "https://example.com/comics", items: [], returned: 8),
                    series: Comics(available: 4, collectionURI: "https://example.com/series", items: [], returned: 4),
                    stories: Stories(available: 2, collectionURI: "https://example.com/stories", items: [], returned: 2),
                    events: Comics(available: 1, collectionURI: "https://example.com/events", items: [], returned: 1),
                    urls: [URLElement(type: .detail, url: "https://marvel.com/ironman")]
                )
        
        return [character1, character2]
    }
    // TODO: Checar y ver si quitar
    func getSeries() async -> [Result] {
        
        // Mock Series for Spiderman
        let spidermanSeries1 = Result(
                    id: 1001,
                    name: "The Amazing Spider-Man",
                    description: "Las aventuras de Spider-Man en Nueva York.",
                    modified: Date(),
                    thumbnail: Thumbnail(path: "https://preview.redd.it/so-is-insomniac-spiderman-the-strongest-version-of-spiderman-v0-of2v5w4n912f1.jpeg?width=640&crop=smart&auto=webp&s=66e5222b38d0cc2039bee7ce8ded6218c825d9fe", thumbnailExtension: .jpg),
                    resourceURI: "https://gateway.marvel.com/v1/public/series/1001",
                    comics: Comics(available: 20, collectionURI: "https://example.com/comics", items: [], returned: 20),
                    series: Comics(available: 0, collectionURI: "", items: [], returned: 0),
                    stories: Stories(available: 10, collectionURI: "https://example.com/stories", items: [], returned: 10),
                    events: Comics(available: 5, collectionURI: "https://example.com/events", items: [], returned: 5),
                    urls: [URLElement(type: .detail, url: "https://marvel.com/series/amazing_spiderman")]
                )
                
                let spidermanSeries2 = Result(
                    id: 1002,
                    name: "Ultimate Spider-Man",
                    description: "Una nueva generación de Spider-Man",
                    modified: Date(),
                    thumbnail: Thumbnail(path: "https://preview.redd.it/so-is-insomniac-spiderman-the-strongest-version-of-spiderman-v0-of2v5w4n912f1.jpeg?width=640&crop=smart&auto=webp&s=66e5222b38d0cc2039bee7ce8ded6218c825d9fe", thumbnailExtension: .jpg),
                    resourceURI: "https://gateway.marvel.com/v1/public/series/1002",
                    comics: Comics(available: 15, collectionURI: "https://example.com/comics", items: [], returned: 15),
                    series: Comics(available: 0, collectionURI: "", items: [], returned: 0),
                    stories: Stories(available: 8, collectionURI: "https://example.com/stories", items: [], returned: 8),
                    events: Comics(available: 3, collectionURI: "https://example.com/events", items: [], returned: 3),
                    urls: [URLElement(type: .detail, url: "https://marvel.com/series/ultimate_spiderman")]
                )
                
                // Mock Series Ironman
                let ironmanSeries1 = Result(
                    id: 2001,
                    name: "Iron Man: Extremis",
                    description: "Tony Stark lucha con nuevas amenazas.",
                    modified: Date(),
                    thumbnail: Thumbnail(path: "https://preview.redd.it/ironman-drawn-by-me-using-colored-pencils-v0-hvhlbmna6vid1.jpeg?width=640&crop=smart&auto=webp&s=c20ec9f9d9437c887294549504edcd312e9e5fb8", thumbnailExtension: .jpg),
                    resourceURI: "https://gateway.marvel.com/v1/public/series/2001",
                    comics: Comics(available: 12, collectionURI: "https://example.com/comics", items: [], returned: 12),
                    series: Comics(available: 0, collectionURI: "", items: [], returned: 0),
                    stories: Stories(available: 6, collectionURI: "https://example.com/stories", items: [], returned: 6),
                    events: Comics(available: 2, collectionURI: "https://example.com/events", items: [], returned: 2),
                    urls: [URLElement(type: .detail, url: "https://marvel.com/series/extremis")]
                )
                
                let ironmanSeries2 = Result(
                    id: 2002,
                    name: "Iron Man: Armor Wars",
                    description: "Tony Stark enfrenta sus propios demonios tecnológicos.",
                    modified: Date(),
                    thumbnail: Thumbnail(path: "https://preview.redd.it/ironman-drawn-by-me-using-colored-pencils-v0-hvhlbmna6vid1.jpeg?width=640&crop=smart&auto=webp&s=c20ec9f9d9437c887294549504edcd312e9e5fb8", thumbnailExtension: .jpg),
                    resourceURI: "https://gateway.marvel.com/v1/public/series/2002",
                    comics: Comics(available: 10, collectionURI: "https://example.com/comics", items: [], returned: 10),
                    series: Comics(available: 0, collectionURI: "", items: [], returned: 0),
                    stories: Stories(available: 5, collectionURI: "https://example.com/stories", items: [], returned: 5),
                    events: Comics(available: 1, collectionURI: "https://example.com/events", items: [], returned: 1),
                    urls: [URLElement(type: .detail, url: "https://marvel.com/series/armor_wars")]
                )
                
                // Para el mock, simplemente devolvemos todas las series, aunque en la realidad filtrarías según el personaje
                return [spidermanSeries1, spidermanSeries2, ironmanSeries1, ironmanSeries2]
    }
}
