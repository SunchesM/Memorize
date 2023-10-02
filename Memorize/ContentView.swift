//
//  ContentView.swift
//  Memorize
//
//  Created by Aleksandr Martynenko on 10/2/23.
//

import SwiftUI

struct ContentView: View {
    let emojies = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁"]
    @State var cardCount = 4
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
                    ForEach(0..<cardCount, id: \.self) { index in
                        CardView(content: emojies[index])
                    }
                    .aspectRatio(2/3, contentMode: .fit)
                }
                .foregroundStyle(.orange)
            }
            Spacer()
            HStack {
                Button(action: {
                    cardCount -= 1
                }, label: {
                    Image(systemName: "minus.circle")
                })
                Spacer()
                Button(action: {
                    cardCount += 1
                }, label: {
                    Image(systemName: "plus.circle")
                })
            }
            .imageScale(.large)
            .font(.largeTitle)
        }
        .padding()
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
