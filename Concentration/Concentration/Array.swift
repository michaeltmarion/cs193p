//
//  Array.swift
//  Concentration
//
//  Created by Michael Marion on 8/13/18.
//  Copyright © 2018 Michael Marion. All rights reserved.
//

import Foundation

extension Array {
    
    /**
     * Randomizes the order of an array's elements.
     */
    mutating func shuffle() {
        for _ in 0..<10 {
            sort {(_,_) in arc4random() < arc4random()}
        }
    }
}
