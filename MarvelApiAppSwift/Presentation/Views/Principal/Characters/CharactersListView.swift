//
//  CharactersListView.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 09/06/25.
//

import SwiftUI

struct CharactersListView: View {
    
    @State var viewModel: MarvelViewModel
    
    // Transition to HerosDetail
    @Namespace
    private var nameSpace
    
    var body: some View {
        // Heroes List
        NavigationStack {
            List {
                ForEach(viewModel.heroesData) { hero in
                    NavigationLink {
                        // Destination
                        SeriesListView()
                        // Transition
                            .navigationTransition(.zoom(sourceID: hero.id, in: nameSpace))
                    } label: {
                        // Heroes row
                        CharactersRowView()
                    }
                    // NavigationLink
                } // ForEach
                
            } // List
            .navigationTitle("Marvel Heroes")
        } // NavStack
        
    } // Body
}

#Preview {
    CharactersListView(viewModel: MarvelViewModel(useCaseMarvel: MarvelUseCaseMock()))
}
