//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Adnan Boxwala on 26.05.22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
