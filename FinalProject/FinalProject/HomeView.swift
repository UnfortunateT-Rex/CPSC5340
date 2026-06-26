//
//  HomeView.swift
//  FinalProject
//
//  Created by Claudia.Mattingly.2 on 24/06/26.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var authVM: AuthViewModel
    @EnvironmentObject var pokemonVM: PokemonViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Welcome, Trainer!")
                    .font(.largeTitle)
                    .bold()
                Text("Pokémon caught: \(pokemonVM.pokemonList.filter { $0.isCaught }.count)")
                    .font(.headline)
                Spacer()
            }
            .padding()
        }
    }
}
