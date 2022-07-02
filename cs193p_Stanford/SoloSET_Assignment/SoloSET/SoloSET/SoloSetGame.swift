//
//  SoloSetGame.swift
//  SoloSET
//
//  Created by Adnan Boxwala on 25.06.22.
//

import SwiftUI

class SoloSetGame: ObservableObject {
    typealias Card = SetGame.Card
    
    static private var cardContents: Array<CardContent> = {
        var contents = Array<CardContent>()
        
        for shape in FeatureShape.allCases {
            for color in FeatureColor.allCases {
                for shading in FeatureShading.allCases {
                    for number in FeatureNumber.allCases {
                        let content = CardContent(shape: shape, number: number, color: color, shading: shading)
                        contents.append(content)
                    }
                }
            }
        }
        
        return contents.shuffled()
    }()
    
    static private func CreateSetGame() -> SetGame {
        SetGame(totalCardCount: cardContents.count, initialCardCount: 12) { index in
            cardContents[index]
        }
    }
    
    @Published private var model: SetGame

    init() {
        model = SoloSetGame.CreateSetGame()
    }
    
    var cards: Array<Card> {
        model.playingCards
    }
    
    var playedCardsCount: Int {
        model.playedCardsCount
    }
    
    var totalCardCount: Int {
        model.totalCardCount
    }
    
    // MARK: - Intent(s)
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        SoloSetGame.cardContents.shuffle()
        model = SoloSetGame.CreateSetGame()
    }
    
    func deal3Cards() {
        model.deal3Cards()
    }
}
