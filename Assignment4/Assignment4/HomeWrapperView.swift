//
//  HomeWrapperView.swift
//  Assignment4
//
//  Created by Claudia.Mattingly.2 on 11/06/26.
//

import SwiftUI

struct HomeWrapperView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        NavigationView {
            VStack {
                // Your existing emoji counter content
                ContentView()

                Button("Logout") {
                    authVM.signOut()
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .navigationTitle("Emoji Counter")
        }
    }
}
