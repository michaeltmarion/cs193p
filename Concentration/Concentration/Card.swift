//
//  Card.swift
//  Concentration
//
//  Created by Michael Marion on 8/12/18.
//  Copyright © 2018 Michael Marion. All rights reserved.
//

import Foundation

/**
 * A struct representing a single Card for use with our Concentration model.
 *
 * This card is part of our model, and as such is UI-indepdnent. This struct should
 * NOT maintain any state associated with end user display, such as an emoji or label
 * text.
 *
 * Structs in Swift are similar to classes, but with two key differences:
 *
 * 1. Structs are pass-by-value, whereas classes are pass-by-reference. This means that
 * when structs are passed around — as, say, arguments to methods or other classes — the
 * value of the struct is COPIED. Swift uses copy-on-write semantics; only data that is
 * modified is copied by the compiler.
 *
 * 2. Structs cannot inherit from superclasses, nor can they function as parent objects
 * themslves.
 */
struct Card {
    
    // Is the card face up or not?
    var isFaceUp = false
    // Has the card been matched or not?
    var isMatched = false
    // An identiifer to match the card to its pair.
    var identifier: Int
    
    // A static variable to allow for global incrementation of identifiers.
    static var identifierFactory = 0;
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    /**
     * A global, static function that creates a unique identifier. Static functions are
     * tied to class type, not instance.
     */
    static func getUniqueIdentifier() -> Int {
        /* Within static scope, you can access static vars and methods without
         * type invocation. */
        identifierFactory += 1
        return Card.identifierFactory
    }
    
}
