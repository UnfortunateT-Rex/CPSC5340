//
//  MainAppview.swift
//  FinalProject
//
//  Created by Claudia.Mattingly.2 on 24/06/26.
//

import SwiftUI

struct MainAppView: View {
    @StateObject private var authVM = AuthViewModel()
    @StateObject private var pokemonVM = PokemonViewModel()
    @State private var selectedTab: Tab = .home
    
    enum Tab: String, CaseIterable {
        case home = "Home"
        case pokedex = "Pokédex"
        case settings = "Settings"
    }

    var body: some View {
        VStack(spacing: 0) {
            // 🔝 Top tab bar
            HStack {
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button(action: {
                        selectedTab = tab
                    }) {
                        Text(tab.rawValue)
                            .font(.headline)
                            .foregroundColor(selectedTab == tab ? .red : .gray)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(selectedTab == tab ? Color(.systemGray6) : Color.clear)
                            .cornerRadius(8)
                    }
                }
            }
            .padding(.horizontal)
            .background(Color.white.shadow(radius: 2))

            Divider()

            // 🧩 Content area
            ZStack {
                switch selectedTab {
                case .home:
                    HomeView()
                        .environmentObject(authVM)
                        .environmentObject(pokemonVM)

                case .pokedex:
                    PokedexView()
                        .environmentObject(pokemonVM)

                case .settings:
                    SettingsView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}
