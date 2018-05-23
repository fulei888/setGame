//
//  File.swift
//  set-game
//
//  Created by Lei Fu on 5/22/18.
//  Copyright © 2018 Lei Fu. All rights reserved.
//

import Foundation

class buttonTitle{
    
    private static func getSymbol(card:Card) -> String {
        switch card.cardSymbol {
            case .diamond
                return "🔹"
            case .oval:
                return "🔴"
            case .squiggle:
                return "◻️"
        }
    }
    private static fun getColor(card: Card) -> String {
        switch card.cardColor {
    
        case .green:
            return UIColor.green
        case .red:
            return UIColor.red
        case .purple:
            return UIColor .purple
    
        }
    }
    
    private static func getNumber( card: Card, symbol:String) -> String{
        switch card.cardNumber {
        case .one:
            return symbol
        case .two:
            return "\(symbol)\(symbol)\(symbol)"
        case .three:
            return "\(symbol) \(symbol) \(symbol)"
            
        }
        private static func getAttirbute(card: Card, title:String, color: UIColor) -> NSAttributedString {
            var attributes: [NSAttributedStringKey: Any] = [:]
            
            switch card.cardShading {
            case .open:
                attributes[.strokeWith]=4
                attributes[.foregroundColor]= color
            case .solid:
                attributes[.strokeWidth] =-1
                attributes[.foregroundColor] = color
            case .striped:
                attributes[.strokeWidth]=-1
                attributes[.foregroundColor] = color.withAlphaComponent(0.25)
            }
            return NSAttributedString(string: title, attributes: attibutes)
        }
        
        public static func giveTitle(card: Card, onButton: UIButton){
            
        }
    }
}
