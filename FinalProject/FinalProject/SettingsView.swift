//
//  SettingsView.swift
//  FinalProject
//
//  Created by Claudia.Mattingly.2 on 24/06/26.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Trainer")) {
                    // Safely unwrap the optional email from Firebase
                    Text(Auth.auth().currentUser?.email ?? "Unknown")
                }

                Section {
                    Button(role: .destructive) {
                        authVM.signOut()
                    } label: {
                        Text("Sign Out")
                    }
                }
            }
        }
    }
}
