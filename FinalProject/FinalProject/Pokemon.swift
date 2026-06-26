//
//  Pokemon.swift
//  FinalProject
//
//  Created by Claudia.Mattingly.2 on 24/06/26.
//

import Foundation

struct Sprites: Decodable {
    let front_default: String?
}

struct Pokemon: Identifiable, Decodable {
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [PokemonType]
    var isCaught: Bool
    var description: String?
}
