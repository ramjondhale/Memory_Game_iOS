//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ram Jondhale on 25/05/23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {

    static let animals = ["🐶", "🐭", "🐹", "🦊", "🐻", "🐼", "🐯", "🐷", "🐮", "🐱", "🐸", "🐵", "🙈", "🙊", "🙉", "🐔", "🦅", "🐺", "🦄", "🐞"]

    private static func createModel(numberOfCards: Int) -> MemoryGame<String> {
        MemoryGame(numberOfCards: numberOfCards) { pairIndex in
            animals[pairIndex]
        }
    }

    @Published private var model: MemoryGame<String> = createModel(numberOfCards: 8)

    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }

    // MARK: - Intent(s)

    func chooseCard(_ card: MemoryGame<String>.Card) {
        model.chooseCard(card)
    }
}
