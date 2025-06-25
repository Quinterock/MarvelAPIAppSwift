//
//  MarvelModels.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 07/06/25.
//

import Foundation

struct Characters: Codable {
    let data: CharactersData
}

struct CharactersData: Codable {
    let results: [MarvelCharacterResult]
}

// Character (avoid using "Result" as it collides with Swift's built-in type!)
struct MarvelCharacterResult: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let description: String
    let modified: Date
    let thumbnail: MarvelThumbnail
    let series: MarvelSeries
}

// Thumbnail
struct MarvelThumbnail: Codable, Equatable, Hashable {
    let path: String
    // dont write only extension as it collides with Swift's built-in type
    let thumbnailExtension: Extension
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
// We create this so it can only accept these 2 types, in case you write jgp or fig etc
enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"

}

// Series summary
struct MarvelSeries: Codable, Equatable, Hashable {
    let available: Int
    // Uniform Resource Identifier
    let collectionURI: String
    let items: [MarvelSeriesItem]
    let returned: Int
}

struct MarvelSeriesItem: Codable, Equatable, Hashable {
    let resourceURI: String
    let name: String
}

// Full series Model

struct SeriesResponse: Codable {
    let data: SeriesData
}

struct SeriesData: Codable {
    let results: [MarvelFullSeries]
}

// Uses Identifiable because is required for SwiftUI List and other UI elements to know how to uniquely identify each item using id.
struct MarvelFullSeries: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let description: String?
    let startYear: Int
    let endYear: Int
    let thumbnail: MarvelThumbnail
}


