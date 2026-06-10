//
//  RootView.swift
//  Assignment4
//
//  Created by Claudia.Mattingly.2 on 11/06/26.
//

import SwiftUI
import FirebaseAuth

struct RootView: View {
    @StateObject private var authVM = AuthViewModel()

    var body: some View {
        Group {
            if authVM.user != nil {
                HomeWrapperView()
                    .environmentObject(authVM)
            } else {
                LoginView()
                    .environmentObject(authVM)
            }
        }
    }
}
