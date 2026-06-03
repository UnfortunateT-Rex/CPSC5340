//
//  PokemonListViewModel.swift
//  Assignment3
//
//  Created by Claudia.Mattingly.2 on 03/06/26.
//

import Foundation
import Combine
import SwiftUI

@MainActor
class PokemonListViewModel: ObservableObject {
    @Published var pokemons: [PokemonListItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func load() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let fetched = try await PokeAPIService.shared.fetchPokemonList()
            pokemons = fetched
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
