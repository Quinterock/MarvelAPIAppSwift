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
            List(viewModel.heroesData) { hero in
                    NavigationLink {
                        // Destination
                        SeriesListView(hero: hero, vmMarvel: viewModel)
                        // Transition
                            .navigationTransition(.zoom(sourceID: hero.id, in: nameSpace))
                    } label: {
                        // Heroes row
                        CharactersRowView(hero: hero)
                    }
                    // NavigationLink
                
            } // List
            .navigationTitle("Marvel Heroes")
        } // NavStack
        
    } // Body
}

#Preview {
    CharactersListView(viewModel: MarvelViewModel(useCaseMarvel: MarvelUseCaseMock()))
}
