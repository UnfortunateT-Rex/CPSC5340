//
//  FinalProjectApp.swift
//  FinalProject
//
//  Created by Claudia.Mattingly.2 on 24/06/26.
//

import SwiftUI
import FirebaseCore

@main
struct FinalProjectApp: App {
    @StateObject private var authVM = AuthViewModel()
    @StateObject private var pokemonVM = PokemonViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            if authVM.isSignedIn {
                MainAppView()
                    .environmentObject(authVM)
                    .environmentObject(pokemonVM)
            } else {
                LoginView()
                    .environmentObject(authVM)
            }
        }
    }
}
