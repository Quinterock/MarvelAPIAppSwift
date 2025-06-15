//
//  MarvelApiAppSwiftTests.swift
//  MarvelApiAppSwiftTests
//
//  Created by Luis Quintero on 06/06/25.
//

import XCTest
@testable import MarvelApiAppSwift

final class EndpointsTests: XCTestCase {
    
    func testCharactersEndpointPath() {
        let endpoint = Endpoints.characters
        XCTAssertEqual(endpoint.path, "/v1/public/characters")
    }

    func testCharacterSeriesEndpointPath() {
        let characterId = 1
        let endpoint = Endpoints.characterSeries(characterId: characterId)
        XCTAssertEqual(endpoint.path, "/v1/public/characters/1/series")
    }
    
    func testCharacterSeriesEndpointPathWithDifferentId() {
        let characterId = 9832758
        let endpoint = Endpoints.characterSeries(characterId: characterId)
        XCTAssertEqual(endpoint.path, "/v1/public/characters/9832758/series")
    }
}
