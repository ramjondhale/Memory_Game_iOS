//
//  MemoryGame.swift
//  Memorize
//
//  Created by Ram Jondhale on 25/05/23.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private var indexOfFaceUpCard: Int?

    mutating func chooseCard(_ card: Card) {
        if let choosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[choosenIndex].isMatched,
           !cards[choosenIndex].isFaceUp {
            if let potentialMatchIndex = indexOfFaceUpCard {
                if cards[choosenIndex].content == cards[potentialMatchIndex].content {
                    cards[choosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                indexOfFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfFaceUpCard = choosenIndex
            }
            cards[choosenIndex].isFaceUp.toggle()
        }
    }

    init(numberOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()

        for pairIndex in 0..<numberOfCards {
            cards.append(Card(content: createCardContent(pairIndex), id: pairIndex * 2))
            cards.append(Card(content: createCardContent(pairIndex), id: pairIndex * 2 + 1))
        }

    }

    struct Card: Identifiable {
        let content: CardContent
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        let id: Int
    }
}
