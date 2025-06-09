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
    
    // Get Marvel Characters
    func getCharacters(filter: String) async -> [Result]
    
    // Get Marvel
    func getSeries(filter: String) async -> [Result]
}

final class NetworkMarvel: NetworkMarvelProtocol {
    
    // Get Marvel Characters List
    func getCharacters(filter: String) async -> [Result] {
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
    
    
    func getSeries(filter: String) async -> [Result] {
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
