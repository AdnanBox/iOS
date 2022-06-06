//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Adnan Boxwala on 05.06.22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias EmojiTheme = Theme<String>
    
    // MARK: - Emoji collection
    static let defaultEmojis = ["😀", "😆", "🥹", "😂", "😇", "😍", "😘", "😜", "🤓", "😎"]
    static let vehicleEmojis = ["🚂", "🚀", "🚁", "🚜", "🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚛", "🦼", "🛴", "🚲", "🛵", "🏍", "🛺", "🚘", "🚖"]
    static let flagEmojis = ["🏳️‍🌈", "🏳️‍⚧️", "🇺🇳", "🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇩", "🇦🇴", "🇦🇮", "🇦🇶", "🇦🇬", "🇦🇺", "🇧🇩", "🇧🇪", "🇧🇴", "🇨🇦", "🇨🇮", "🇯🇲", "🇱🇰"]
    static let sportEmojis = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🎱", "🏓", "🏒", "🏑", "🏹", "⛳️", "🤿", "⛸", "🛼", "🛹", "🛷", "🏂", "🪂", "⛷", ]
    static let fruitEmojis = ["🍏", "🍎", "🍐", "🍊", "🍌", "🍉", "🍇", "🍓", "🫐", "🍒", "🍑", "🥭", "🍍", "🥥", "🥑", "🍆", "🥝", "🌶", "🥦", "🌽"]
    static let objectEmojis = ["⌚️", "📱", "💻", "⌨️", "🖥", "🖨", "🖱", "🕹", "🗜", "📀", "📸", "💾", "📹", "🎥", "☎️", "📞", "📟", "📺", "🧭", "🎚", "🎙", "⏰", "⏱", "🕰"]
    static let symbolEmojis = ["💟", "☮️", "✝️", "☪️", "🕉", "☸️", "✡️", "🔯", "🕎", "☯️", "☦️", "🛐", "⛎", "♈️", "♉️", "♊️", "♋️", "♌️", "♍️", "♎️", "♏️", "♐️", "♑️", "♒️", "♓️"]
    
    // MARK: - Type Properties
    static private func getColor(_ color: String) -> Color {
        switch(color) {
            case "black":
                return .black
            case "indigo":
                return .indigo
            case "green":
                return .green
            case "yellow":
                return .yellow
            case "orange":
                return .orange
            case "pink":
                return .pink
            case "violet":
                return .cyan
            case "gray":
                return .gray
            case "brown":
                return .brown
            case "purple":
                return .purple
            default:
                return .red
        }
    }
    
    static private var themes: [EmojiTheme] {
        var themes = [EmojiTheme]()
        themes.append(EmojiTheme("Vehicles", with: vehicleEmojis, cardColor: "indigo"))
        themes.append(EmojiTheme("Flags", with: flagEmojis, cardColor: "green"))
        themes.append(EmojiTheme("Sports", with: sportEmojis, cardColor: "yellow"))
        themes.append(EmojiTheme("Fruits", with: fruitEmojis, cardColor: "orange"))
        themes.append(EmojiTheme("Objects", with: objectEmojis, cardColor: "brown"))
        themes.append(EmojiTheme("Symbols", with: symbolEmojis, cardColor: "purple"))
        
        return themes
    }
    
    static private func chooseTheme() -> EmojiTheme {
        if let randomlyChosenTheme = themes.randomElement() {
            return randomlyChosenTheme
        }
        return EmojiTheme("Emoticons", with: defaultEmojis, cardColor: "red")
    }
    
    static private func createMemoryGame(with theme: EmojiTheme) -> MemoryGame<String> {
        let shuffledContent = theme.content.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 8...theme.numberOfPairsOfCards)) { pairIndex in
            shuffledContent[pairIndex]
        }
    }
    
    // MARK: - Instance specific
    private(set) var chosenTheme: EmojiTheme
    @Published private var model: MemoryGame<String>
    
    init() {
        chosenTheme = EmojiMemoryGame.chooseTheme()
        model = EmojiMemoryGame.createMemoryGame(with: chosenTheme)
    }
    
    var chosenColor: Color {
        EmojiMemoryGame.getColor(chosenTheme.cardColor)
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intent(s)
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        chosenTheme = EmojiMemoryGame.chooseTheme()
        model = EmojiMemoryGame.createMemoryGame(with: chosenTheme)
    }
}

