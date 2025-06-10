//
//  ContentView.swift
//  MarvelApiAppSwift
//
//  Created by Luis Quintero on 06/06/25.
//

import SwiftUI
// PRINCIPAL FIRST VIEW
struct PrincipalView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    PrincipalView()
}
