//
//  AuthView.swift
//  FinalProject
//
//  Created by Claudia.Mattingly.2 on 24/06/26.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isLoginMode = true
    @State private var authError: String?

    var body: some View {
        VStack(spacing: 20) {
            Text(isLoginMode ? "Pokémon Trainer Login" : "Create Trainer Account")
                .font(.title)
                .bold()

            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)

            if let error = authError {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            Button(isLoginMode ? "Log In" : "Sign Up") {
                if isLoginMode {
                    authVM.signIn(email: email, password: password)
                } else {
                    authVM.signUp(email: email, password: password)
                }
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .padding()
    }
}
