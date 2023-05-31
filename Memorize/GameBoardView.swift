//
//  GameBoardView.swift
//  Memorize
//
//  Created by Ram Jondhale on 17/05/23.
//

import SwiftUI

let animals = ["🐶", "🐭", "🐹", "🦊", "🐻", "🐼", "🐯", "🐷", "🐮", "🐱", "🐸", "🐵", "🙈", "🙊", "🙉", "🐔", "🦅", "🐺", "🦄", "🐞"]
let birds = ["🐓", "🦅", "🦜", "🕊️", "🦤", "🦢", "🦆", "🪿", "🦩", "🦚", "🦃", "🐧", "🐥", "🐣", "🐔", "🦇", "🐦‍⬛", "🐦"]
let cars = ["🚙", "🚗", "🛻", "🚐", "🚚", "🚓", "🚔", "🚘", "🚖", "🚛", "🏎️", "🚒", "🚑", "🚎", "🚍", "🏍️", "🛵"]


struct GameBoardView: View {

   @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
            Text("Memorize 🧠")
                .font(.largeTitle)
                .foregroundColor(.cyan)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fill)
                            .onTapGesture {
                                viewModel.chooseCard(card)
                            }
                    }
                }
                .foregroundColor(.mint)
            }
        }
        .padding(.horizontal)
    }

}

struct CardView: View {
    let card: MemoryGame<String>.Card

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

struct GameBoardView_Previews: PreviewProvider {

    static var previews: some View {
        GameBoardView(viewModel: EmojiMemoryGame())
    }
}
