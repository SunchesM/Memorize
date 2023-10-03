//
//  ContentView.swift
//  Memorize
//
//  Created by Aleksandr Martynenko on 10/2/23.
//

import SwiftUI

struct ContentView: View {
    let emojies = [
        ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁"],
        ["🌵", "🎄", "🌲", "🌳", "🌴", "🪵", "🌱", "🌿", "☘️", "🍀", "🎍", "🪴"],
        ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏", "🎱", "🪀", "🏓"]
    ]
    
    let theme = [0, 1, 2]
    @State var selectedTheme = 0
    
    @State var cardCount = 4
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    cards
                }
                Spacer()
                cardCountAdjusters
            }
            .navigationTitle("Memorize")
            .padding()
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojies[selectedTheme][index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(.orange)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            themeView
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var themeView: some View {
        Picker("Change theme", selection: $selectedTheme) {
            ForEach(theme, id: \.self) {
                Text("\($0)")
            }
        }
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojies[selectedTheme].count)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "minus.circle")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "plus.circle")
    }
}

#Preview {
    ContentView()
}

struct CardView: View {
    var content: String
    @State var isFaceUp = false
    var body: some View {
        let base = RoundedRectangle(cornerRadius: 12)
        ZStack {
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}
