//
//  SeriesDetailView.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 24/06/25.
//

import SwiftUI

struct SeriesDetailView: View {
    
    let series: MarvelFullSeries
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack {
                    AsyncImage(url: URL(string: "\(series.thumbnail.path).\(series.thumbnail.thumbnailExtension.rawValue)")) { image in
                        image
                            .resizable()
                            .cornerRadius(20)
                        
                        
                    } placeholder: {
                        Color.gray
                    }
                    .frame(height: 300)
                    .cornerRadius(12)
                } // VStack image
                .padding(6)
                .background(Color(.systemBackground))
                .cornerRadius(24)
                .shadow(radius: 10)
                
                Text(series.title)
                    .font(.title2)
                    .padding()
                    .bold()
                
                Text((series.description ?? "No description"))
                    .font(.body)
                    .padding()
            }
            .padding()
        } // ScrollView

    }
}

extension MarvelFullSeries {
    static let mockSerieDetail = MarvelFullSeries(
        id: 2,
        title: "Deadpool",
        description: "Deapool esta loco Lollipop marshmallow apple pie chupa chups sweet brownie cheesecake chocolate cake carrot cake. Gummies bonbon jelly-o chocolate oat cake dessert sweet biscuit. Chocolate bar fruitcake oat cake pie biscuit oat cake pie. Brownie carrot cake tart lemon drops pastry jelly danish cheesecake chocolate bar.",
        startYear: 2008,
        endYear: 2008,
        thumbnail: MarvelThumbnail(
            path: "http://i.annihil.us/u/prod/marvel/i/mg/7/03/5130f646465e3",
            thumbnailExtension: .jpg
        )
    )
}

#Preview {
    SeriesDetailView(series: .mockSerieDetail)
}
