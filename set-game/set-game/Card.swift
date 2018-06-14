//
//  Card.swift
//  set-game
//
//  Created by Lei Fu on 5/20/18.
//  Copyright © 2018 Lei Fu. All rights reserved.
//

import Foundation
struct Card : Equatable, Hashable{
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        
        
        return  lhs.cardColor == rhs.cardColor &&
            lhs.cardNumber == rhs.cardNumber &&
            lhs.cardShading == rhs.cardShading &&
            lhs.cardSymbol == rhs.cardSymbol &&
        lhs.identifier == rhs.identifier
        
    }
    
    var clicked = false
    var isMatched = false
    var hashValue: Int {
        return identifier
    }
     var identifier: Int
    var cardColor: CardColor = .green
    var cardSymbol: CardSymbol = .diamond
    var cardNumber: CardNumber = .one
    var cardShading: CardShading = .solid
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    init() {
        self.identifier = Card.getUniqueIdentifier()
        
    }
    
   
}



enum CardColor {
    case red
    case green
    case blue
    static let allValues = [red, green, blue]
}

enum CardSymbol {
    case diamond
    case squiggle
    case oval
    
    static let allValues = [diamond, squiggle, oval]
}

enum CardNumber {
    case one
    case two
    case three
    
    static let allValues = [one, two, three]
    
}

enum CardShading {
    case solid
    case striped
    case open
    
    static let allValues = [solid, striped, open]
}

//extension Card: Hashable {
//    var hashValue: Int {
//        return (cardColor.rawValue) + (cardNumber.rawValue * 3) + (cardShading.rawValue * 9) + (cardShading.rawValue * 27)
//    }
//
//    static func ==(lhs: Card, rhs: Card) -> Bool {
//        return lhs.hashValue == rhs.hashValue
//}
//}
//}



