//
//  AuthViewModel.swift
//  FinalProject
//
//  Created by Claudia.Mattingly.2 on 24/06/26.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseCore

class AuthViewModel: ObservableObject {
    @Published var isSignedIn = false
    @Published var authError: String?

    init() {
        isSignedIn = Auth.auth().currentUser != nil
    }

    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.authError = error.localizedDescription
                } else {
                    self.authError = nil
                    self.isSignedIn = true
                }
            }
        }
    }

    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.authError = error.localizedDescription
                } else {
                    self.authError = nil
                    self.isSignedIn = true
                }
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            isSignedIn = false
        } catch {
            authError = error.localizedDescription
        }
    }
}
