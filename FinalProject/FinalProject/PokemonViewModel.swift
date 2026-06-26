//
//  PokemonViewModel.swift
//  FinalProject
//
//  Created by Claudia.Mattingly.2 on 24/06/26.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

class PokemonViewModel: ObservableObject {
    @Published var pokemonList: [Pokemon] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let db = Firestore.firestore()

    // MARK: - Load Pokémon list
    func loadPokemonList() {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else {
            errorMessage = "Invalid URL"
            return
        }

        isLoading = true

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                    return
                }

                guard let data = data else {
                    self.errorMessage = "No data received"
                    self.isLoading = false
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                    self.fetchSprites(for: decoded.results)
                } catch {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }.resume()
    }

    // MARK: - Fetch Pokémon details
    private func fetchSprites(for results: [PokemonListResponse.Result]) {
        let group = DispatchGroup()
        var loadedPokemon: [Pokemon] = []

        for (index, result) in results.enumerated() {
            group.enter()
            guard let detailURL = URL(string: result.url) else {
                group.leave()
                continue
            }

            URLSession.shared.dataTask(with: detailURL) { data, _, _ in
                defer { group.leave() }
                guard let data = data else { return }

                if let detail = try? JSONDecoder().decode(PokemonDetailResponse.self, from: data) {
                    let pokemon = Pokemon(
                        id: index + 1,
                        name: result.name.capitalized,
                        sprites: detail.sprites,
                        types: detail.types,
                        isCaught: false
                    )
                    loadedPokemon.append(pokemon)
                }
            }.resume()
        }

        group.notify(queue: .main) {
            self.pokemonList = loadedPokemon.sorted { $0.id < $1.id }
            self.isLoading = false
            self.loadCaughtPokemon() // sync caught state from Firebase
        }
    }

    // MARK: - Toggle caught status
    func toggleCaught(for pokemon: Pokemon) {
        guard let index = pokemonList.firstIndex(where: { $0.id == pokemon.id }) else { return }
        pokemonList[index].isCaught.toggle()
        saveCaughtState(pokemonList[index])
        loadCaughtPokemon()
    }

    // MARK: - Save caught state to Firebase
    private func saveCaughtState(_ pokemon: Pokemon) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        let ref = db.collection("users").document(userID).collection("caughtPokemon").document("\(pokemon.id)")

        if pokemon.isCaught {
            ref.setData([
                "name": pokemon.name,
                "caught": true,
                "timestamp": Timestamp(date: Date())
            ])
        } else {
            ref.delete()
        }
    }

    // MARK: - Load caught Pokémon from Firebase
    func loadCaughtPokemon() {
        guard let userID = Auth.auth().currentUser?.uid else { return }

        Firestore.firestore().collection("users").document(userID)
            .collection("caughtPokemon")
            .getDocuments { snapshot, error in
                guard let documents = snapshot?.documents else { return }

                let caughtIDs = documents.compactMap { Int($0.documentID) }

                DispatchQueue.main.async {
                    for id in caughtIDs {
                        if let index = self.pokemonList.firstIndex(where: { $0.id == id }) {
                            self.pokemonList[index].isCaught = true
                        }
                    }
                }
            }
    }
}

func fetchDescription(for pokemon: Pokemon, completion: @escaping (String?) -> Void) {
    guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(pokemon.id)/") else {
        completion(nil)
        return
    }

    URLSession.shared.dataTask(with: url) { data, _, _ in
        guard let data = data else { completion(nil); return }

        do {
            let species = try JSONDecoder().decode(PokemonSpeciesResponse.self, from: data)
            let englishEntry = species.flavor_text_entries.first { $0.language.name == "en" }
            completion(englishEntry?.flavor_text.replacingOccurrences(of: "\n", with: " "))
        } catch {
            completion(nil)
        }
    }.resume()
}

struct PokemonSpeciesResponse: Decodable {
    struct FlavorTextEntry: Decodable {
        let flavor_text: String
        let language: Language
    }
    struct Language: Decodable {
        let name: String
    }
    let flavor_text_entries: [FlavorTextEntry]
}

// MARK: - Decodable structs
struct PokemonListResponse: Decodable {
    struct Result: Decodable {
        let name: String
        let url: String
    }
    let results: [Result]
}

struct PokemonDetailResponse: Decodable {
    let sprites: Sprites
    let types: [PokemonType]
}


struct PokemonType: Decodable {
    let type: TypeInfo
}

struct TypeInfo: Decodable {
    let name: String
}
