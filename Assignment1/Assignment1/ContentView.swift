//
//  ContentView.swift
//  Assignment1
//
//  Created by Claudia.Mattingly.2 on 22/05/26.
//

import SwiftUI

struct EmojiCounter: Identifiable {
    let id = UUID()
    let emoji: String
    var count: Int
}

struct ContentView: View {
    @State private var counters = [
        EmojiCounter(emoji: "😀", count: 0),
        EmojiCounter(emoji: "🥳", count: 0),
        EmojiCounter(emoji: "😎", count: 0),
        EmojiCounter(emoji: "🤩", count: 0),
        EmojiCounter(emoji: "😇", count: 0)
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach($counters) { $counter in
                    HStack {
                        Text(counter.emoji)
                            .font(.largeTitle)
                        Spacer()
                        Text("Counter: \(counter.count)")
                        Spacer()
                        Button("-") {
                            counter.count -= 1
                        }
                        .buttonStyle(.bordered)
                        Button("+") {
                            counter.count += 1
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding(.vertical, 8)
                }
            }
            .navigationTitle("Emoji Counter")
        }
    }
}

#Preview {
    ContentView()
}
