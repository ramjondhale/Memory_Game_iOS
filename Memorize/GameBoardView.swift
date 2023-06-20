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
        VStack{
            Text(viewModel.theme.name)
                .font(.largeTitle)
                .foregroundColor(viewModel.theme.color)
                .colorInvert()
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fill)
                            .onTapGesture {
                                viewModel.chooseCard(card)
                            } .foregroundColor(viewModel.theme.color)
                    }
                }
            }

            Spacer()

            Button {
                viewModel.startNewGame()
            } label: {
                Label("Start New Game", systemImage: "restart.circle")
                    .font(.system(size: 30))
                    .foregroundColor(.cyan)
                    .labelStyle(NewLabelStyle())
            }

            Spacer()

        }.padding(.horizontal)

    }
}

struct NewLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
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
