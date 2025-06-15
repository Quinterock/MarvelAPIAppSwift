//
//  MarvelApiAppSwiftTests.swift
//  MarvelApiAppSwiftTests
//
//  Created by Luis Quintero on 06/06/25.
//

import XCTest
@testable import MarvelApiAppSwift

final class MarvelUseCaseTests: XCTestCase {

    var mockRepo: MarvelRepositoryMock!
    var useCase: MarvelUseCase!

    override func setUp() {
        super.setUp()
        mockRepo = MarvelRepositoryMock()
        useCase = MarvelUseCase(repo: mockRepo)
    }

    override func tearDown() {
        mockRepo = nil
        useCase = nil
        super.tearDown()
    }

    func testGetCharactersReturnsExpectedResults() async {
        let characters = await useCase.getCharacters()
        XCTAssertEqual(characters.count, 2, "Should return two mock characters")
        XCTAssertEqual(characters.first?.name, "Spider-Man")
        XCTAssertEqual(characters.last?.name, "Iron Man")
    }

    func testGetFullSeriesForSpiderMan() async {
        let series = await useCase.getFullSeries(for: 1)
        XCTAssertEqual(series.count, 2, "Should return two series for Spider-Man")
        XCTAssertEqual(series[0].title, "The Amazing Spider-Man")
        XCTAssertEqual(series[1].title, "Ultimate Spider-Man")
    }

    func testGetFullSeriesForIronMan() async {
        let series = await useCase.getFullSeries(for: 2)
        XCTAssertEqual(series.count, 2, "Should return two series for Iron Man")
        XCTAssertEqual(series[0].title, "Iron Man: Extremis")
        XCTAssertEqual(series[1].title, "Iron Man: Armor Wars")
    }

    func testGetFullSeriesForUnknownCharacterReturnsEmpty() async {
        let series = await useCase.getFullSeries(for: 999)
        XCTAssertTrue(series.isEmpty, "Should return empty array for unknown character ID")
    }
}
