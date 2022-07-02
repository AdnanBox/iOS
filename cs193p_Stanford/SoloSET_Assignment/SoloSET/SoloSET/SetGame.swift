//
//  SetGame.swift
//  SoloSET
//
//  Created by Adnan Boxwala on 25.06.22.
//

import Foundation
import SwiftUI

struct SetGame {
    private(set) var totalCardCount: Int
    private(set) var playedCardsCount = 0
    private let initialCardCount: Int
    
    private(set) var playingCards: Array<Card>
    private var chosenCards = Array<Card>()
    
    private let createCardContent: (Int) -> CardContent
    
    mutating func choose(_ card: Card) {
        if chosenCards.count == 3 {
            resetChosenCards()
        }
        
        if let chosenIndex = playingCards.firstIndex(where: { $0.id == card.id})
        {
            if !playingCards[chosenIndex].isSelected {
                playingCards[chosenIndex].isSelected = true
                chosenCards.append(playingCards[chosenIndex])
                
                if chosenCards.count == 3 {
                    if check4Match() {
                        chosenCards.forEach{ card in
                            if let matchedIndex = playingCards.firstIndex(where: { $0.id == card.id }) {
                                playingCards[matchedIndex].isMatched = true
                            }
                        }
                    } else {
                        chosenCards.forEach{ card in
                            if let index = playingCards.firstIndex(of: card) {
                                playingCards[index].isNotMatched = true
                            }
                        }
                    }
                }
            } else {
                playingCards[chosenIndex].isSelected = false
                chosenCards.remove(at: chosenCards.firstIndex(of: playingCards[chosenIndex])!)
            }
        }
    }
    
    mutating func deal3Cards() {
        if playingCards.contains(where: {$0.isMatched}) {
            resetChosenCards()
        } else {
            for _ in 0..<3 {
                if playedCardsCount < totalCardCount {
                    deal1Card(at: playingCards.endIndex)
                }
            }
        }
    }
    
    mutating private func deal1Card(at index: Int) {
        if playedCardsCount < totalCardCount {
            let content = createCardContent(playedCardsCount)
            playingCards.insert(Card(content: content, id: playedCardsCount), at: index)
            playedCardsCount += 1
        }
    }
    
    mutating private func resetChosenCards() {
        if playingCards.contains(where: {$0.isMatched}) {
            chosenCards.forEach { card in
                if let index = playingCards.firstIndex(of: card) {
                    playingCards.remove(at: index)
                    deal1Card(at: index)
                }
            }
        } else {
            chosenCards.forEach { card in
                if let index = playingCards.firstIndex(of: card) {
                    playingCards[index].isNotMatched = false
                    playingCards[index].isSelected = false
                }
            }
        }
        
        chosenCards = []
    }
    
    mutating private func check4Match() -> Bool {
        var shape = Set<FeatureShape>()
        var color = Set<FeatureColor>()
        var shading = Set<FeatureShading>()
        var number = Set<FeatureNumber>()
        
        self.chosenCards.forEach { card in
            shape.insert(card.content.shape)
            color.insert(card.content.color)
            shading.insert(card.content.shading)
            number.insert(card.content.number)
        }
        
        if (shape.count == 2 || color.count == 2 || shading.count == 2 || number.count == 2) {
            return false
        }
        return true
    }
    
    init(totalCardCount: Int, initialCardCount: Int, createCardContent: @escaping (Int) -> CardContent) {
        playingCards = []
        self.totalCardCount = totalCardCount
        self.initialCardCount = initialCardCount
        self.createCardContent = createCardContent
        
        for _ in 0..<initialCardCount {
            let content = createCardContent(playedCardsCount)
            playingCards.append(Card(content: content, id: playedCardsCount))
            playedCardsCount += 1
        }
    }

    struct Card: Identifiable, Equatable {
        var isMatched = false
        var isNotMatched = false
        var isSelected = false
        let content: CardContent
        let id: Int
        
        static func == (lhs: SetGame.Card, rhs: SetGame.Card) -> Bool {
            lhs.id == rhs.id
        }
    }

}
