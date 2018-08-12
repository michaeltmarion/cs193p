//
//  ViewController.swift
//  Concentration
//
//  Created by Michael Marion on 8/12/18.
//  Copyright © 2018 Michael Marion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // The set of emoji characters to display on the cards.
    var emojiChoices: [String] = ["😄", "😜", "😄", "😜"]
    
    // Tracks the number of total flip attempts.
    var flipCount = 0  {
        /* This is called a property observer.
         * It allows for the definition of actions
         * when this property's state changes.
         */
        didSet {
            flipCountLabel.text = "\(flipCount)"
        }
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
            /* Flip the card, using the card's index to step into
             * emojiChoices and retrieve the proper emoji to
             * display on it.
             */
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        } else {
            print("Error: card not found in cardButtons!")
        }
    }

    /**
     * Flip a card.
     *
     * Again, note the use of both internal and external
     * names for the function arguments.
     */
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
}

