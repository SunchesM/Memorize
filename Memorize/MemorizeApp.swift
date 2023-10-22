//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Aleksandr Martynenko on 10/2/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
