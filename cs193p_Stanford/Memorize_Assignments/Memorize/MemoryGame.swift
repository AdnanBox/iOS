//
//  MemoryGame.swift
//  Memorize
//
//  Created by Adnan Boxwala on 05.06.22.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    if cards[potentialMatchIndex].isSeen { score -= 1 }
                    if cards[chosenIndex].isSeen {score -= 1 }
                    
                    cards[potentialMatchIndex].isSeen = true
                    cards[chosenIndex].isSeen = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        // add numberOfPairsOfCards x 2 cards to cards array
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var isSeen: Bool = false
        var content: CardContent
        var id: Int
    }
}

struct Theme<CardContent> {
    let name: String
    var content: [CardContent]
    var numberOfPairsOfCards: Int
    var cardColor: String
    
    init(_ name: String, with content: [CardContent], cardColor: String) {
        self.name = name
        self.content = content
        numberOfPairsOfCards = content.count
        self.cardColor = cardColor
    }
}
