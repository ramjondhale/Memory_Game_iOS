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
        Theme(name: "Animals", color: .pink, numberOfCards: 11, emojis: Set(animals)),
        Theme(name: "Birds", color: .mint, numberOfCards: 7, emojis: Set(birds)),
        Theme(name: "Cars", color: .cyan, numberOfCards: 10, emojis: Set(cars))
    ]

    private static var randomThemeIndex: Int {
        Int.random(in: 0..<themes.count)
    }

    private static var selectedTheme = {
        themes[randomThemeIndex]
    }()

    private static var randomEmojis = {
        selectedTheme.emojis.shuffled()
    }()

    // MARK: - Helper method

    private static func createModel() -> MemoryGame<String> {
        MemoryGame(numberOfCards: selectedTheme.numberOfCards) { pairIndex in
            randomEmojis[pairIndex]
        }
    }

    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }

    var theme: Theme {
        Self.selectedTheme
    }

    // MARK: - Model

    @Published private var model: MemoryGame<String> = createModel()

    // MARK: - Intent(s)

    func chooseCard(_ card: MemoryGame<String>.Card) {
        model.chooseCard(card)
    }

    func startNewGame() {
        Self.resetTheme()
        model = Self.createModel()
    }

    private static func resetTheme() {
        selectedTheme = themes[randomThemeIndex]
        randomEmojis = selectedTheme.emojis.shuffled()
    }

    // MARK: - Internal 

    struct Theme: Identifiable {
        let name: String
        let color: Color
        let numberOfCards: Int
        let emojis: Set<String>
        let id = UUID()
    }
}
