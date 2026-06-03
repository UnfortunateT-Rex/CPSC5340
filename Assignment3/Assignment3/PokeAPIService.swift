//
//  PokeAPIService.swift
//  Assignment3
//
//  Created by Claudia.Mattingly.2 on 03/06/26.
//

import Foundation

class PokeAPIService {
    static let shared = PokeAPIService()
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    func fetchPokemonList(limit: Int = 50) async throws -> [PokemonListItem] {
        let url = baseURL.appendingPathComponent("pokemon")
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "limit", value: String(limit))
        ]
        let (data, _) = try await URLSession.shared.data(from: components.url!)
        let decoded = try JSONDecoder().decode(PokemonListResponse.self, from: data)
        return decoded.results
    }

    func fetchPokemonDetail(name: String) async throws -> PokemonDetail {
        let url = baseURL.appendingPathComponent("pokemon/\(name)")
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(PokemonDetail.self, from: data)
    }
}
