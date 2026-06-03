//
//  ContentView.swift
//  Assignment3
//
//  Created by Claudia.Mattingly.2 on 03/06/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PokemonListViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading Pokémon...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                } else {
                    List(viewModel.pokemons, id: \.name) { item in
                        NavigationLink(item.name.capitalized) {
                            PokemonDetailView(name: item.name)
                        }
                    }
                }
            }
            .navigationTitle("Pokédex")
            .task {
                await viewModel.load()
            }
        }
    }
}
