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
    
    var flipCount = 0;
    var score = 0;
    
    // An optional value.
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    /**
     * Non-default initializer. Note: all classes in Swift
     * have a default init with no arguments.
     */
    init(numberOfCardPairs: Int) {
        startNewGame(numberOfCardPairs: numberOfCardPairs)
    }
    
    /**
     * Start a new game of Concentration. Reset the existing
     * array of cards and re-initialize it.
     */
    func startNewGame(numberOfCardPairs: Int) {
        flipCount = 0; score = 0
        cards.removeAll()
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
        // Shuffle the cards.
        cards.shuffle()
    }
    
    /**
     * Modifies model state when a card in the game has
     * been chosen by a player.
     */
    func chooseCard(at index: Int) {
        // Ignore matched cards.
        if !cards[index].isMatched {
            /* Increment the flip count only
             * if the tapped card was face-down. */
            if !cards[index].isFaceUp {
                flipCount += 1
            }
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                /* Before touch, only one card was face up. We need to check if the
                 * just-tapped card matches the face-up card. */
                if cards[matchIndex].identifier == cards[index].identifier {
                    // The cards match!
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    // The cards do not match.
                    score -= 1
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                // Either no cards or two cards are face-up with no match.
                for flipDownIndex in cards.indices {
                    // Turn all cards face-down.
                    cards[flipDownIndex].isFaceUp = false
                }
                // Turn up only the card that was tapped.
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }

}
