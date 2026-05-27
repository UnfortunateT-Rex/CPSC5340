//
//  BooksView.swift
//  Favorites_Completed
//
//  Created by Claudia.Mattingly.2 on 27/05/26.
//

import SwiftUI

struct BooksView: View {
    @Binding var searchText: String
    @EnvironmentObject private var favorites: FavoritesViewModel

    var body: some View {
        List {
            ForEach(favorites.books.filter { book in
                searchText.isEmpty ||
                book.bookTitle.localizedCaseInsensitiveContains(searchText) ||
                book.bookAuthor.localizedCaseInsensitiveContains(searchText)
            }) { book in
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
                        favorites.toggleFavoriteBook(book: book)
                    }) {
                        Image(systemName: book.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(book.isFavorite ? .red : .gray)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
                .padding(.vertical, 4)
            }
        }
    }
}

#Preview {
    BooksView(searchText: .constant(""))
        .environmentObject(FavoritesViewModel())
}
