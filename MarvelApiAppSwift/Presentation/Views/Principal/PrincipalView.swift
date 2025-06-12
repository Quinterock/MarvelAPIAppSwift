//
//  ContentView.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 06/06/25.
//

import SwiftUI
// PRINCIPAL FIRST VIEW
struct PrincipalView: View {
    @StateObject private var viewModel = MarvelViewModel() // Use real or mock here

    var body: some View {
        CharactersListView(viewModel: viewModel)
    }
}

#Preview {
    PrincipalView()
}
