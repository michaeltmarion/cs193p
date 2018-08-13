//
//  ViewController.swift
//  Concentration
//
//  Created by Michael Marion on 8/12/18.
//  Copyright © 2018 Michael Marion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /* A lazy variable. Lazy variables in Swift prevent compilation errors: objects in
     * Swift must be 100% initialized before accessing any of its members. Lazy vars
     * are not initialized until they are accessed.
     *
     * Lazy variables cannot, by definition,have property observers. */
    lazy var game = Concentration(numberOfCardPairs: (cardButtons.count + 1) / 2)
    
    // The set of emoji characters to display on the cards.
    var emojiChoices: [String] = ["😄", "😜", "😎", "😍", "🤬",  "😱", "😶",  "🤑", "😂"]
    
    /* A dictionary, or hashtable, mapping indices to emoji choices. */
    var emoji = [Int:String]()
    
    // Tracks the number of total flip attempts.
    var flipCount = 0  {
        /* This is called a property observer.
         * It allows for the definition of actions
         * when this property's state changes.
         */
        didSet { flipCountLabel.text = "\(flipCount)" }
    }

    /**
     * This is an IBOutlet; it's an instance variable associated
     * with an element in our Storyboard.
     *
     * IBOutlets differ from IBActions in that they are represented
     * solely as a state variable and not a method or funciton call.
     *
     * Notice also that this IBOutlet does not require an initialization.
     */
    @IBOutlet weak var flipCountLabel: UILabel!
    
    /**
     * This is an Outlet Collection. The syntax below is syntactic sugar
     * for instantiating a variable-length array of type UIBUtton.
     */
    @IBOutlet var cardButtons: [UIButton]!
    
    /**
     * An IBAction defining behavior when the given card
     * represented as a UIButton is tapped in the view.
     *
     * Note that the given parameter here has two names:
     * the external name and internal name, respectively:
     *
     * - The "sender" name is internal to this class only.
     *
     * - The "_" name is the external name; the _ character
     *   is used by convention to denote that there needn't
     *   be any specificity here. This is an Objective C
     *   convention that isn't used widely in Swift.
     *
     * Note: copying and pasting a new card in the Storyboard
     * erred because IBActions are copied over when
     * Storyboard items are copied in the view. This means
     * that _both_ this action and the original touchCard
     * were called when tapping the first card.
     *
     * To modify an item's actions, right-click it in the
     * Storyboard.
     */
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        /* Put an exclamation point at the end of the following line
         * to force-retrieve the value wrapped within the Optional
         * returned by Array.index.
         *
         * Alternatively, you can wrap Optionals within if/else blocks
         * to define behaviors based on presence, like so.
         */
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Error: card not found in cardButtons!")
        }
    }
    
    /**
     * Respond to state changes in the model and update the view accordingly.
     */
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            }
        }
    }
    
    /**
     * Choose the emoji from our emoji dictionary that matches
     * the index on the card.
     */
    func emoji(for card: Card) -> String {
        // Comma-based synax here is sugar for nested if statements.
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            /* A pseudorandom number generator, bounded to the range between 0 and
             * the size of our emoji dictionary.
             *
             * In addition: Swfit, while good at type inference, never automatically
             * converts between types. We also need to convert a UInt32 into an Int.
             * Thankfully, UInt32 offers an initializer with an Int argument. */
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            // Remove (and return) the emoji from our set of choices to avoid collisions with
            // emoji-identifier pairs.
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        // The ?? is a special operator to perform a nil-check in a single line.
        return emoji[card.identifier] ?? "?"
    }
    
}

