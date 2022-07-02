//
//  SoloSetGameView.swift
//  SoloSET
//
//  Created by Adnan Boxwala on 25.06.22.
//

import SwiftUI

struct SoloSetGameView: View {
    @ObservedObject var game = SoloSetGame()
    
    var body: some View {
        VStack {
            HStack {
                Text("Solo-SET").font(.title).bold().foregroundColor(.teal)
                Spacer()
            }
            .padding()
            
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                CardView(card: card)
                    .padding(3)
                    .onTapGesture {
                        game.choose(card)
                    }
            }
            .foregroundColor(.blue)
            .padding(.horizontal)
                        
            HStack {
                newGame
                Spacer()
                if game.playedCardsCount < game.totalCardCount {
                    dealCards
                } else {
                    Text("Deck empty").foregroundColor(.gray)
                }
            }
            .padding()
        }
    }
    
    var newGame: some View {
        Button {
            game.startNewGame()
        } label: {
            Text("New Game")
        }
    }
    
    var dealCards: some View {
        Button {
            game.deal3Cards()
        } label: {
            VStack {
                Image(systemName: "plus.circle").font(.title)
                Text("Deal 3 cards").font(.caption)
            }
        }
    }
}


struct CardView: View {
    let card: SetGame.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cardCornerRadius)
            
            if card.isMatched {
                shape.fill().foregroundColor(.green).opacity(DrawingConstants.cardMatchOpacity)
                shape.strokeBorder(lineWidth: DrawingConstants.cardLineWidth).foregroundColor(.green)
            } else {
                shape.fill().foregroundColor(.white)
                if card.isSelected && card.isNotMatched {
                    shape.fill().foregroundColor(.gray).opacity(DrawingConstants.cardMatchOpacity)
                    shape.strokeBorder(lineWidth: DrawingConstants.cardLineWidth).foregroundColor(.gray)
                } else if card.isSelected {
                    shape.strokeBorder(lineWidth: DrawingConstants.cardLineWidthOnSelection).foregroundColor(.orange).opacity(DrawingConstants.selectedCardLineWidthOpacity)
                } else {
                    shape.strokeBorder(lineWidth: DrawingConstants.cardLineWidth)
                }
                VStack {
                    ForEach(0..<card.content.number.getNumber(), id: \.self) { _ in
                        createCardDesign(for: card)
                    }
                }
                .padding(.vertical)
            }
        }
    }
    
    @ViewBuilder
    private func createCardDesign(for card: SetGame.Card) -> some View {
        switch card.content.shape {
        case .diamond:
            createSymbol(of: card.content, shape: Diamond())
        case .mycapsule:
            createSymbol(of: card.content, shape: MyCapsule())
        case .zapper:
            createSymbol(of: card.content, shape: Zapper())
        }
    }
    
    @ViewBuilder
    private func createSymbol<SymbolShape>(of content: CardContent, shape: SymbolShape) -> some View where SymbolShape: Shape {
        switch content.shading {
        case .solid:
            shape.fill().foregroundColor(content.color.getColor())
        case .translucent:
            ZStack {
                shape.fill().foregroundColor(content.color.getColor()).opacity(DrawingConstants.symbolOpacity)
                shape.stroke(lineWidth: DrawingConstants.symbolLineWidth).foregroundColor(content.color.getColor())
            }
        case .transparent:
            shape.stroke(lineWidth: DrawingConstants.symbolLineWidth).foregroundColor(content.color.getColor())
        }
    }
    
    struct DrawingConstants {
        static let cardLineWidth: CGFloat = 2
        static let cardLineWidthOnSelection: CGFloat = 4
        static let cardCornerRadius: CGFloat = 10
        static let symbolLineWidth: CGFloat = 2
        static let selectedCardLineWidthOpacity: Double = 0.5
        static let cardMatchOpacity: Double = 0.2
        static let symbolOpacity: Double = 0.2
    }
}




































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SoloSetGameView()
            .previewInterfaceOrientation(.portrait)
    }
}
