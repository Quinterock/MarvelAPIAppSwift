//
//  SeriesListView.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 09/06/25.
//

//import SwiftUI
//
//struct SeriesListView: View {
//    var hero: Result
//    
//    
//    var vmMarvel: MarvelViewModel // Reference to parent ViewModel
//    
//    var body: some View {
//        VStack {
//            // SerieImage
//            if let imageUrl = URL(string: "\(hero.thumbnail.path).\(hero.thumbnail.thumbnailExtension)") {
//                AsyncImage(url: imageUrl) { phase in
//                    if let image = phase.image {
//                        image
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 200, height: 200)
//                    } else if phase.error != nil {
//                        Color.red
//                    } else {
//                        ProgressView()
//                    }
//                    
//                } // AsyncImage
//            } // imageUrl
//            
//            Text(hero.name)
//                .font(.title)
//                .padding(.top)
//            
//            List(vmMarvel.heroesData) {
//                serie in
//                Text(serie.name)
//            } // List
//        } // VStack
//        .navigationTitle("Serie de \(hero.name)")
//        .onAppear {
//            Task {
//                await vmMarvel.getSeries()
//            }
//        }
//    } // Body
//        
//}

//#Preview {
//    // Mock Series Ironman
//    let ironmanSeries1 = Result(
//        id: 2001,
//        name: "Iron Man: Extremis",
//        description: "Tony Stark lucha con nuevas amenazas.",
//        modified: Date(),
//        thumbnail: Thumbnail(path: "https://preview.redd.it/ironman-drawn-by-me-using-colored-pencils-v0-hvhlbmna6vid1.jpeg?width=640&crop=smart&auto=webp&s=c20ec9f9d9437c887294549504edcd312e9e5fb8", thumbnailExtension: .jpg),
//        resourceURI: "https://gateway.marvel.com/v1/public/series/2001",
//        comics: Comics(available: 12, collectionURI: "https://example.com/comics", items: [], returned: 12),
//        series: Comics(available: 0, collectionURI: "", items: [], returned: 0),
//        stories: Stories(available: 6, collectionURI: "https://example.com/stories", items: [], returned: 6),
//        events: Comics(available: 2, collectionURI: "https://example.com/events", items: [], returned: 2),
//        urls: [URLElement(type: .detail, url: "https://marvel.com/series/extremis")]
//    )
//    
//    SeriesListView(hero: ironmanSeries1, vmMarvel: MarvelViewModel(useCaseMarvel: MarvelUseCaseMock()))
//}
