//
// FavoritesView.swift : Favorites
//
// Copyright © 2025 Auburn University.
// All Rights Reserved.


import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var favorites: FavoritesViewModel

    var body: some View {
        NavigationStack {
            List {
                // 🏙 Favorite Cities
                Section(header: Text("Favorite Cities")) {
                    ForEach(favorites.cities.filter { $0.isFavorite }) { city in
                        HStack {
                            Text(city.cityName)
                            Spacer()
                            Button(action: {
                                favorites.toggleFavoriteCity(city: city)
                            }) {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }

                // 🎨 Favorite Hobbies
                Section(header: Text("Favorite Hobbies")) {
                    ForEach(favorites.hobbies.filter { $0.isFavorite }) { hobby in
                        HStack {
                            Text("\(hobby.hobbyIcon) \(hobby.hobbyName)")
                            Spacer()
                            Button(action: {
                                favorites.toggleFavoriteHobby(hobby: hobby)
                            }) {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }

                // 📚 Favorite Books
                Section(header: Text("Favorite Books")) {
                    ForEach(favorites.books.filter { $0.isFavorite }) { book in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(book.bookTitle)
                                    .font(.headline)
                                Text(book.bookAuthor)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Button(action: {
                                favorites.bookManager.toggleFavorite(items: &favorites.books, targetItem: book)
                            }) {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesViewModel())
}
