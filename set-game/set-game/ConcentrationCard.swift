//
//  Card.swift
//  Concetration
//
//  Created by Lei Fu on 5/5/18.
//  Copyright © 2018 Lei Fu. All rights reserved.
//

import Foundation

struct ConcentrationCard: Hashable {
    
    var hashValue: Int {
        return identifier
    }
    
    static func ==(lhs: ConcentrationCard, rhs: ConcentrationCard) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = ConcentrationCard.getUniqueIdentifier()
    }
}
