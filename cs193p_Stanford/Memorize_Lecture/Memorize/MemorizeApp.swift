//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Adnan Boxwala on 26.05.22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
