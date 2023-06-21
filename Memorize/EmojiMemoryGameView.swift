//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Ram Jondhale on 17/05/23.
//

import SwiftUI

struct EmojiMemoryGameView: View {

   @ObservedObject var game: EmojiMemoryGame

    var body: some View {
        VStack{
            Text(game.theme.name)
                .font(.largeTitle)
                .foregroundColor(game.theme.color)
                .colorInvert()
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(game.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fill)
                            .onTapGesture {
                                game.chooseCard(card)
                            } .foregroundColor(game.theme.color)
                    }
                }
            }

            Spacer()

            Button {
                game.startNewGame()
            } label: {
                Label("Start New Game", systemImage: "restart.circle")
                    .font(.system(size: 30))
                    .foregroundColor(.cyan)
                    .labelStyle(StartGameButtonStyle())
            }

            Spacer()

        }.padding(.horizontal)

    }
}

struct StartGameButtonStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

struct CardView: View {

    let card: EmojiMemoryGame.Card

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
        EmojiMemoryGameView(game: EmojiMemoryGame())
    }
}
