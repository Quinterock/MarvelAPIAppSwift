//
//  CharactersRowView.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 09/06/25.
//

import SwiftUI

struct CharactersRowView: View {
    let hero: Result
    
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: "\(hero.thumbnail.path).\(hero.thumbnail.thumbnailExtension.rawValue)")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 40, height: 40)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            case .failure:
                                Image(systemName: "person")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                            @unknown default:
                                EmptyView()
                }
            }
            
            // Hero name
            Text(hero.name)
                .font(.headline)
            
        } // HStack
        .padding(.vertical, 8)
    } // View
}

#Preview {
    
    let mockThumbnail = Thumbnail(path: "https://preview.redd.it/ironman-drawn-by-me-using-colored-pencils-v0-hvhlbmna6vid1.jpeg?width=640&crop=smart&auto=webp&s=c20ec9f9d9437c887294549504edcd312e9e5fb8",thumbnailExtension: .jpg)
        let mockHero = Result(id: 1011334,
                               name: "Iron man",
                               description: "Test description",
                               modified: Date(),
                               thumbnail: mockThumbnail,
                               resourceURI: "",
                               comics: Comics(available: 0, collectionURI: "", items: [], returned: 0),
                               series: Comics(available: 0, collectionURI: "", items: [], returned: 0),
                               stories: Stories(available: 0, collectionURI: "", items: [], returned: 0),
                               events: Comics(available: 0, collectionURI: "", items: [], returned: 0),
                               urls: [])
    CharactersRowView(hero: mockHero)
}
