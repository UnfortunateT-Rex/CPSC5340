//
//  PokemonDetailView.swift
//  FinalProject
//
//  Created by Claudia.Mattingly.2 on 24/06/26.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    @EnvironmentObject var pokemonVM: PokemonViewModel
    @State private var description: String = "Loading description..."
    
    // Helper for type colors
    func colorForType(_ type: String) -> Color {
        switch type.lowercased() {
        case "grass": return .green
        case "fire": return .red
        case "water": return .blue
        case "electric": return .yellow
        case "bug": return .teal
        case "poison": return .purple
        case "ground": return .brown
        case "flying": return .cyan
        case "psychic": return .pink
        case "rock": return .gray
        case "ice": return .mint
        case "dragon": return .indigo
        case "dark": return .black
        case "fairy": return .orange
        default: return .gray
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Pokémon sprite
                AsyncImage(url: URL(string: pokemon.sprites.front_default ?? "")) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                } placeholder: {
                    Color.gray.opacity(0.2)
                        .frame(width: 150, height: 150)
                }
                
                // Pokémon name
                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                    .bold()
                
                // Type badges
                HStack(spacing: 10) {
                    ForEach(pokemon.types, id: \.type.name) { typeInfo in
                        Text(typeInfo.type.name.capitalized)
                            .font(.headline)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(colorForType(typeInfo.type.name))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                
                // Description text
                Text(description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top, 10)
                
                // Caught toggle button
                Button(action: {
                    pokemonVM.toggleCaught(for: pokemon)
                }) {
                    Label(
                        pokemon.isCaught ? "Release Pokémon" : "Catch Pokémon",
                        systemImage: pokemon.isCaught ? "circle.fill" : "circle"
                    )
                    .font(.headline)
                    .foregroundColor(pokemon.isCaught ? .red : .gray)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationTitle(pokemon.name.capitalized)
        .task {
                    await loadDescription()
                }
        }
    
    // MARK: - Async description loader
        func loadDescription() async {
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(pokemon.id)/") else {
                description = "No description available."
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let species = try JSONDecoder().decode(PokemonSpeciesResponse.self, from: data)
                if let englishEntry = species.flavor_text_entries.first(where: { $0.language.name == "en" }) {
                    description = englishEntry.flavor_text.replacingOccurrences(of: "\n", with: " ")
                } else {
                    description = "No description available."
                }
            } catch {
                description = "Failed to load description."
            }
        }
    }
