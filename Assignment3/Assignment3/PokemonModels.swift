//
//  PokemonModels.swift
//  Assignment3
//
//  Created by Claudia.Mattingly.2 on 03/06/26.
//

struct PokemonListResponse: Decodable {
    let results: [PokemonListItem]
}

struct PokemonListItem: Decodable, Identifiable {
    let name: String
    let url: String
    var id: String { name }
}

struct PokemonDetail: Decodable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
    let types: [PokemonTypeEntry]
}

struct Sprites: Decodable {
    let front_default: String?
}

struct PokemonTypeEntry: Decodable {
    let slot: Int
    let type: NamedAPIResource
}

struct NamedAPIResource: Decodable {
    let name: String
    let url: String
}

struct Pokemon: Codable {
    let name: String
    let url: String
}
