//
//  PokemonDetailViewModel.swift
//  Assignment3
//
//  Created by Claudia.Mattingly.2 on 03/06/26.
//

import Foundation
import Combine
import SwiftUI

@MainActor
class PokemonDetailViewModel: ObservableObject {
    @Published var detail: PokemonDetail?
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private let service = PokeAPIService()
    let name: String
    
    init(name: String) {
        self.name = name
        Task {
            await load()
        }
    }
    
    func load() async {
        isLoading = true
        do {
            detail = try await service.fetchPokemonDetail(name: name)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
