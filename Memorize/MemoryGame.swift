//
//  MemoryGame.swift
//  Memorize
//
//  Created by Ram Jondhale on 25/05/23.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>

    func chooseCard(_ card: Card) {

    }

    init(numberOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()

        for pairIndex in 0..<numberOfCards {
            cards.append(Card(content: createCardContent(pairIndex)))
            cards.append(Card(content: createCardContent(pairIndex)))
        }

    }

    struct Card {
        let content: CardContent
        let isFaceUp: Bool = false
        let isMatched: Bool = false
    }
}
