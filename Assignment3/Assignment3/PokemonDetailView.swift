//
//  PokemonDetailView.swift
//  Assignment3
//
//  Created by Claudia.Mattingly.2 on 03/06/26.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject private var viewModel: PokemonDetailViewModel

    init(name: String) {
        _viewModel = StateObject(wrappedValue: PokemonDetailViewModel(name: name))
    }

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else if let detail = viewModel.detail {
                ScrollView {
                    VStack(spacing: 16) {
                        if let urlString = detail.sprites.front_default,
                           let url = URL(string: urlString) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                            } placeholder: {
                                ProgressView()
                            }
                        }

                        Text(detail.name.capitalized)
                            .font(.largeTitle)
                            .bold()

                        Text("Height: \(detail.height)")
                        Text("Weight: \(detail.weight)")

                        HStack {
                            ForEach(detail.types, id: \.slot) { entry in
                                Text(entry.type.name.capitalized)
                                    .padding(6)
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                }
            } else {
                Text("No details available.")
            }
        }
    }
}
