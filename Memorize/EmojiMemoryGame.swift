//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ram Jondhale on 25/05/23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {

    // MARK: - Constants

    static let animals = ["🐶", "🐭", "🐹", "🦊", "🐻", "🐼", "🐯", "🐷", "🐮", "🐱", "🐸", "🐵", "🙈", "🙊", "🙉", "🐔", "🦅", "🐺", "🦄", "🐞"]
    static let birds = ["🐓", "🦅", "🦜", "🕊️", "🦤", "🦢", "🦆", "🪿", "🦩", "🦚", "🦃", "🐧", "🐥", "🐣", "🐔", "🦇", "🐦‍⬛", "🐦"]
    static let cars = ["🚙", "🚗", "🛻", "🚐", "🚚", "🚓", "🚔", "🚘", "🚖", "🚛", "🏎️", "🚒", "🚑", "🚎", "🚍", "🏍️", "🛵"]
    static let themes: [Theme] = [
        Theme(name: "Animals", color: .pink, numberOfCards: 11, emojis: animals),
        Theme(name: "Birds", color: .mint, numberOfCards: 7, emojis: birds),
        Theme(name: "Cars", color: .cyan, numberOfCards: 10, emojis: cars)
    ]

    // MARK: - Helpers

    private static func createModel(theme: Theme) -> MemoryGame<String> {
        MemoryGame(numberOfCards: theme.numberOfCards) { pairIndex in
            theme.emojis[pairIndex]
        }
    }

    private static var randomTheme: Theme {
        themes[Int.random(in: 0..<themes.count)]
    }

    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }

    // MARK: - Models

    @Published private var model: MemoryGame<String>
    private(set) var theme: Theme

    // MARK: - Init

    init() {
        self.theme = Self.randomTheme
        self.model = Self.createModel(theme: theme)
    }

    // MARK: - Intent(s)

    func chooseCard(_ card: MemoryGame<String>.Card) {
        cards.filter({ !$0.isMatched}).count == 2 ? startNewGame() : model.chooseCard(card)
    }

    func startNewGame() {
        resetTheme()
        model = Self.createModel(theme: theme)
    }

    // MARK: - Private Helpers

    private func resetTheme() {
        theme = Self.randomTheme
        model = Self.createModel(theme: theme)
    }

    // MARK: - Internal

    struct Theme: Identifiable {
        let name: String
        let color: Color
        let numberOfCards: Int
        var emojis: [String]
        let id = UUID()

        init(name: String, color: Color, numberOfCards: Int, emojis: [String]) {
            self.name = name
            self.color = color
            self.numberOfCards = numberOfCards
            self.emojis = Set(emojis).shuffled()
        }
    }
}
