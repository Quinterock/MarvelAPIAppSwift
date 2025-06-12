//
//  SeriesRowView.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 12/06/25.
//

import SwiftUI

struct SeriesRowView: View {
    let series: MarvelFullSeries

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: series.thumbnailURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 80, height: 80)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(series.title)
                    .font(.headline)
                    .lineLimit(2)
                if let description = series.description, !description.isEmpty {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                Text("\(series.startYear) - \(series.endYear)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

// Helper for image URL
extension MarvelFullSeries {
    var thumbnailURL: URL? {
        URL(string: "\(thumbnail.path).\(thumbnail.thumbnailExtension.rawValue)")
    }
}

// Mock for preview
extension MarvelFullSeries {
    static let mock = MarvelFullSeries(
        id: 1,
        title: "Avengers: The Initiative",
        description: "Superhero training program.",
        startYear: 2007,
        endYear: 2010,
        thumbnail: MarvelThumbnail(
            path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/514a2ed3302f5",
            thumbnailExtension: .jpg
        )
    )
}

#Preview {
    SeriesRowView(series: .mock)
}
