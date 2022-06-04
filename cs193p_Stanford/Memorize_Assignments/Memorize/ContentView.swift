//
//  ContentView.swift
//  Memorize
//
//  Created by Adnan Boxwala on 26.05.22.
//

import SwiftUI

struct ContentView: View {
    @State var emojis: [String] = []
    @State var emojiCount = 0
    var vehicleEmojis = ["🚂", "🚀", "🚁", "🚜", "🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚛", "🦼", "🛴", "🚲", "🛵", "🏍", "🛺", "🚘", "🚖"]
    var flagEmojis = ["🏳️‍🌈", "🏳️‍⚧️", "🇺🇳", "🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿", "🇦🇸", "🇦🇩", "🇦🇴", "🇦🇮", "🇦🇶", "🇦🇬", "🇦🇺", "🇧🇩", "🇧🇪", "🇧🇴", "🇨🇦", "🇨🇮", "🇯🇲", "🇱🇰"]
    var sportEmojis = ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🎱", "🏓", "🏒", "🏑", "🏹", "⛳️", "🤿", "⛸", "🛼", "🛹", "🛷", "🏂", "🪂", "⛷", ]
    
    @State var isGameStarted: Bool = false
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle).foregroundColor(.black)
            Spacer()
            if !isGameStarted {
                Text("Select Theme!").font(.body).fontWeight(.semibold).foregroundColor(Color.red)
            } else {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                        ForEach(emojis[..<emojiCount].shuffled(), id: \.self) { emoji in
                            CardView(content: emoji)
                                .aspectRatio(2/3, contentMode: .fit)
                        }
                    }
                }
                .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
            }
            Spacer()
            HStack {
                themeVehicles
                Spacer()
                themeFlags
                Spacer()
                themeSports
            }
            .font(.largeTitle)
            .padding(.horizontal)
        }
        .padding(.horizontal)
    }
    
    var themeVehicles: some View {
        Button {
            emojis = vehicleEmojis
            emojiCount = Int.random(in: 8...vehicleEmojis.count)
            isGameStarted = true
        } label: {
            VStack {
                Image(systemName: "car.fill")
                Text("Vehicles").font(.caption)
            }
        }
    }
    
    var themeFlags: some View {
        Button {
            emojis = flagEmojis
            emojiCount = Int.random(in: 8...flagEmojis.count)
            isGameStarted = true
        } label: {
            VStack {
                Image(systemName: "flag.fill")
                Text("Flags").font(.caption)
            }
        }
    }
    
    var themeSports: some View {
        Button {
            emojis = sportEmojis
            emojiCount = Int.random(in: 8...sportEmojis.count)
            isGameStarted = true
        } label: {
            VStack {
                Image(systemName: "sportscourt.fill")
                Text("Sports").font(.caption)
            }
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25.0)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture{
            isFaceUp = !isFaceUp
        }
    }
}















































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
        ContentView()
            .preferredColorScheme(.dark)
    }
}
