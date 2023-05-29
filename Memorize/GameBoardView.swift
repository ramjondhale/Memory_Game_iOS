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
var themes = [
    Theme(name: "Animals", iconName: "hare.fill", emojis: animals),
    Theme(name: "Birds", iconName: "bird.fill", emojis: birds),
    Theme(name: "Cars", iconName: "car.fill", emojis: cars)
]

struct GameBoardView: View {

    @State private var emojisCount = 8
    @State private var emojis: [String] = themes[0].emojis

    var body: some View {
        VStack {
            Text("Memorize 🧠")
                .font(.largeTitle)
                .foregroundColor(.cyan)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(emojis[0..<emojisCount], id: \.self) { emoji in
                        CardView(emoji: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
                .foregroundColor(.mint)
            }
            Spacer()
            HStack(spacing: 30) {
                ForEach(themes) { theme in
                    VStack {
                        ThemeButton(emojis: $emojis, emojisCount: $emojisCount, theme: theme)
                            .padding(.bottom, 5)

                        Text(theme.name)
                            .font(.system(.body))
                            .foregroundColor(.blue)
                    }
                }
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }

}

struct ThemeButton: View {

    @Binding var emojis: [String]
    @Binding var emojisCount: Int

    let theme: Theme

    var body: some View {
        Button {
            emojis = theme.shuffleEmojis()
            emojisCount = Int.random(in: 5...15)
        } label: {
            Image(systemName: theme.iconName)
                .renderingMode(.original)
                .resizable()
                .scaledToFit()
                .frame(height: 50)
        }
    }
}

struct CardView: View {
    var emoji: String
    @State private var isFaceUp: Bool = true

    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(emoji).font(.largeTitle)
            } else {
                shape.fill().foregroundColor(.pink)
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

struct Theme: Identifiable {
    let id = UUID()
    let name: String
    let iconName: String
    let emojis: [String]

    func shuffleEmojis() -> [String] {
        return emojis.shuffled()
    }
}

struct GameBoardView_Previews: PreviewProvider {
    static var previews: some View {
        GameBoardView()
    }
}
