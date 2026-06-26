//
//  PokedexView.swift
//  FinalProject
//
//  Created by Claudia.Mattingly.2 on 24/06/26.
//

import SwiftUI

struct PokedexView: View {
    @EnvironmentObject var pokemonVM: PokemonViewModel

    var body: some View {
        NavigationStack {
            if pokemonVM.isLoading {
                ProgressView("Loading Pokémon...")
                    .font(.headline)
                    .padding()
            } else if let error = pokemonVM.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(pokemonVM.pokemonList) { pokemon in
                    NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                        HStack {
                            AsyncImage(url: URL(string: pokemon.sprites.front_default ?? "")) { image in
                                image.resizable().scaledToFit().frame(width: 50, height: 50)
                            } placeholder: {
                                Color.gray.opacity(0.2).frame(width: 50, height: 50)
                            }

                            Text(pokemon.name.capitalized)
                                .font(.headline)

                            Spacer()

                            // 🟢 Toggle caught status
                            Button(action: {
                                pokemonVM.toggleCaught(for: pokemon)
                            }) {
                                Image(systemName: pokemon.isCaught ? "circle.fill" : "circle")
                                    .foregroundColor(pokemon.isCaught ? .red : .gray)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Pokédex")
            }
        }
        .onAppear {
            if pokemonVM.pokemonList.isEmpty {
                pokemonVM.loadPokemonList()
            }
        }
    }
}
