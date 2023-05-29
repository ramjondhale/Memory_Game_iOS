//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ram Jondhale on 25/05/23.
//

import SwiftUI

class EmojiMemoryGame {

    static let animals = ["🐶", "🐭", "🐹", "🦊", "🐻", "🐼", "🐯", "🐷", "🐮", "🐱", "🐸", "🐵", "🙈", "🙊", "🙉", "🐔", "🦅", "🐺", "🦄", "🐞"]

    private static func createModel(numberOfCards: Int) -> MemoryGame<String> {
        MemoryGame(numberOfCards: numberOfCards) { pairIndex in
            animals[pairIndex]
        }
    }

    private(set) var model: MemoryGame<String> = createModel(numberOfCards: 8)

    init() {
      
    }
}
