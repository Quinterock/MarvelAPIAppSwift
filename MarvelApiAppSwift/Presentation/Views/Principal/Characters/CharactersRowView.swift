//
//  CharactersRowView.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 09/06/25.
//

import SwiftUI

struct CharactersRowView: View {
    let character: MarvelCharacterResult
    
    var body: some View {
        VStack {
            AsyncImage(url: character.thumbnailURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 100, height: 100)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 320, height: 320)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                case .failure(let _):
                    Image(systemName: "person")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.red)
                @unknown default:
                    Image(systemName: "person.crop.square")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                } // switch
            } // AsyncImage
            Text(character.name)
                .font(.headline)
                .frame(width: 100)
        } // VStack
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(24)
        .shadow(radius: 8)
    } // View
    
}




// Extension to get the image URL, (shorten code)
extension MarvelCharacterResult {
    static let mock: MarvelCharacterResult = MarvelCharacterResult(
            id: 1,
            name: "Spider-Man",
            description: "Friendly neighborhood Spider-Man.",
            modified: Date(),
            thumbnail: MarvelThumbnail(
                path: "https://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
                thumbnailExtension: .jpg
            ),
            series: MarvelSeries(
                available: 3,
                collectionURI: "",
                items: [],
                returned: 3
            )
        )
    
    var thumbnailURL: URL? {
        URL(string: "\(thumbnail.path).\(thumbnail.thumbnailExtension)")
    }
}
    
#Preview {
    CharactersRowView(character: .mock)
}
