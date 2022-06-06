//
//  ContentView.swift
//  Memorize
//
//  Created by Adnan Boxwala on 26.05.22.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            Spacer()
            HStack {
                Text("Score: \(viewModel.score)")
                Spacer()
                newGame
            }
            .padding()
            Spacer()
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                }
            }
            .foregroundColor(viewModel.chosenColor)
            Spacer()
            Text(viewModel.chosenTheme.name).font(.title2).foregroundColor(viewModel.chosenColor).bold()
        }
        .padding(.horizontal)
    }
    
    var newGame: some View {
        Button {
            viewModel.startNewGame()
        } label: {
            VStack {
                Text("New Game").font(.title3)
            }
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25.0)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            }
            else {
                shape.fill()
            }
        }
    }
}















































struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
