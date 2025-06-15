//
//  MarvelApiAppSwiftTests.swift
//  MarvelApiAppSwiftTests
//
//  Created by Luis Quintero on 06/06/25.
//

import XCTest
@testable import MarvelApiAppSwift

final class NetworkMarvelTests: XCTestCase {

    var network: NetworkMarvelMock!

        override func setUp() {
            super.setUp()
            network = NetworkMarvelMock()
        }

        override func tearDown() {
            network = nil
            super.tearDown()
        }

        func testGetCharactersReturnsExpectedMockCharacters() async {
            let characters = await network.getCharacters()
            XCTAssertEqual(characters.count, 2, "Should return two mock characters")

            let names = characters.map { $0.name }
            XCTAssertTrue(names.contains("Spider-Man"), "Should contain Spider-Man")
            XCTAssertTrue(names.contains("Iron Man"), "Should contain Iron Man")
        }

        func testGetFullSeriesForSpiderManReturnsExpectedSeries() async {
            let series = await network.getFullSeries(for: 1)
            XCTAssertEqual(series.count, 2, "Should return two series for Spider-Man")
            XCTAssertEqual(series[0].title, "The Amazing Spider-Man")
            XCTAssertEqual(series[1].title, "Ultimate Spider-Man")
        }

        func testGetFullSeriesForIronManReturnsExpectedSeries() async {
            let series = await network.getFullSeries(for: 2)
            XCTAssertEqual(series.count, 2, "Should return two series for Iron Man")
            XCTAssertEqual(series[0].title, "Iron Man: Extremis")
            XCTAssertEqual(series[1].title, "Iron Man: Armor Wars")
        }

        func testGetFullSeriesForUnknownIdReturnsEmpty() async {
            let series = await network.getFullSeries(for: 999)
            XCTAssertTrue(series.isEmpty, "Should return empty series for unknown character id")
        }

}
