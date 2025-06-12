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

struct MarvelFullSeries: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String?
    let startYear: Int
    let endYear: Int
    let thumbnail: MarvelThumbnail
}

//import Foundation
//
//// MARK: - Welcome
//struct MarvelModel: Codable {
//    let code: Int
//    let status, copyright, attributionText, attributionHTML: String
//    let etag: String
//    let data: MarvelData
//}
//
//// MARK: - DataClass
//struct MarvelData: Codable {
//    let offset, limit, total, count: Int
//    let results: [MarvelCharacter]
//}
//
//// MARK: - Result changed to MarvelCharacter as it collides with Swift's built-in type!
//struct MarvelCharacter: Codable, Identifiable {
//    let id: Int
//    let name, description: String
//    // El campo "modified" viene en formato "2025-02-21T12:58:24+0000",
//    // que no es el formato estándar de Date para JSONDecoder en Swift.
////    let modified: Date
//    let modified: String
//    let thumbnail: Thumbnail
//    let resourceURI: String
//    let comics, series: Comics
//    let stories: Stories
//    let events: Comics
//    let urls: [URLElement]
//}
//
//// MARK: - Comics / Series
//struct Comics: Codable {
//    let available: Int
//    let collectionURI: String
//    let items: [ComicsItem]
//    let returned: Int
//}
//
//// MARK: - ComicsItem
//struct ComicsItem: Codable {
//    let resourceURI: String
//    let name: String
//}
//
//// MARK: - Stories
//struct Stories: Codable {
//    let available: Int
//    let collectionURI: String
//    let items: [StoriesItem]
//    let returned: Int
//}
//
//// MARK: - StoriesItem
//struct StoriesItem: Codable {
//    let resourceURI: String
//    let name: String
//    let type: ItemType
//}
//
//enum ItemType: String, Codable {
//    case cover = "cover"
//    case empty = ""
//    case interiorStory = "interiorStory"
//    case pinup = "pinup"
//}
//
//// MARK: - Thumbnail
//struct Thumbnail: Codable {
//    let path: String
//    let thumbnailExtension: Extension
//
//    enum CodingKeys: String, CodingKey {
//        case path
//        case thumbnailExtension = "extension"
//    }
//}
//
//enum Extension: String, Codable {
//    case gif = "gif"
//    case jpg = "jpg"
//}
//
//// MARK: - URLElement
//struct URLElement: Codable {
//    let type: URLType
//    let url: String
//}
//
//enum URLType: String, Codable {
//    case comiclink = "comiclink"
//    case detail = "detail"
//    case wiki = "wiki"
//}

