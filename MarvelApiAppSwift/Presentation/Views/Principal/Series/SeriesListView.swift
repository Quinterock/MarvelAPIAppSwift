//
//  SeriesListView.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 09/06/25.
//

import SwiftUI

struct SeriesListView: View {
    let series: [MarvelFullSeries]

    var body: some View {
        List(series) { serie in
            SeriesRowView(series: serie)
        }
        .listStyle(.plain)
        .navigationTitle("Series")
    }
}

// MARK: - #Preview

#Preview {
    NavigationStack {
        SeriesListView(series: [
            .mock,
            MarvelFullSeries(
                id: 2,
                title: "Deadpool",
                description: "Deapool esta loco",
                startYear: 2008,
                endYear: 2008,
                thumbnail: MarvelThumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/7/03/5130f646465e3",
                    thumbnailExtension: .jpg
                )
            )
        ])
    }
}



