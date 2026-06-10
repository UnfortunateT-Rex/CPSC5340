//
//  LoginView.swift
//  Assignment4
//
//  Created by Claudia.Mattingly.2 on 11/06/26.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel

    @State private var email = ""
    @State private var password = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("Emoji Counter Login")
                    .font(.title)
                    .padding(.bottom, 20)

                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)

                if let error = authVM.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                HStack(spacing: 16) {
                    Button("Sign In") {
                        authVM.signIn(email: email, password: password)
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Sign Up") {
                        authVM.signUp(email: email, password: password)
                    }
                    .buttonStyle(.bordered)
                }

                Spacer()
            }
            .padding()
        }
    }
}
