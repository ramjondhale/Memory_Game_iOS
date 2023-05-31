//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Ram Jondhale on 17/05/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let viewModel = EmojiMemoryGame()

    var body: some Scene {
        WindowGroup {
            GameBoardView(viewModel: viewModel)
        }
    }
}
