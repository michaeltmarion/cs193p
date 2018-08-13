//
//  Concentration.swift
//  Concentration
//
//  Created by Michael Marion on 8/12/18.
//  Copyright © 2018 Michael Marion. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    /**
     * Non-default initializer. Note: all classes in Swift
     * have a default init with no arguments.
     */
    init(numberOfCardPairs: Int) {
        /* The 1...val syntax is syntactic sugar for creating a CountableRange.
         *
         * For loops in swift allow for iteration through any sequence,
         * which is some series of values that is countable and finite.
         * Strings, for instance, are also technically sequences.
         *
         * Alternatively, you can use 0..<, which will be exclusive of
         * val. Using 1...val includes the final value in the sequence. */
        for _ in 1...numberOfCardPairs {
            // Append two matching cards to the cards array.
            let card = Card()
            // Note: doing += [Card(), Card()] would create two separate
            // instances, not two copies of the same struct.
            cards += [card, card]
        }
    }
    
    /**
     * Modifies model state when a card in the game has
     * been chosen by a player.
     */
    func chooseCard(at index: Int) {
        cards[index].isFaceUp = !cards[index].isFaceUp
    }
}
