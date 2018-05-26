//
//  File.swift
//  set-game
//
//  Created by Lei Fu on 5/22/18.
//  Copyright © 2018 Lei Fu. All rights reserved.
//

import Foundation
import UIKit

class buttonTitle{
    
    private static func getSymbol(card:Card) -> String {
        switch card.cardSymbol {
        case .diamond:
            
                return "▲"
            case .oval:
                return "●"
            case .squiggle:
                return "■"
        }
    }
    private static func getColor(card: Card) -> UIColor {
        switch card.cardColor {
    
        case .green:
            return #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        case .red:
            return UIColor.red
        case .purple:
            return UIColor.purple
    
        }
    }
    
    private static func getNumber( card: Card, symbol:String) -> String{
        switch card.cardNumber {
        case .one:
            return symbol
        case .two:
            return "\(symbol)\(symbol)"
        case .three:
            return "\(symbol) \(symbol) \(symbol)"
            
        }
    }
    private static func getAttirbute(card: Card, title:String, color: UIColor) -> NSAttributedString {
            var attributes: [NSAttributedStringKey: Any] = [:]
            
        switch card.cardShading {
            case .open:
                attributes[.strokeWidth] = 4
                attributes[.foregroundColor] = color
            case .solid:
                attributes[.strokeWidth] = -1
                attributes[.foregroundColor] = color
            case .striped:
                attributes[.strokeWidth] = -1
                attributes[.foregroundColor] = color.withAlphaComponent(0.25)
            }
        return NSAttributedString( string: title, attributes: attributes)
        }
        
    public static func giveTitle(card: Card, onButton: UIButton){
            
            let buttonColor = getColor(card: card)
            let cardSymbol = getSymbol(card: card)
            let buttonNumber = getNumber(card:card, symbol: cardSymbol)
            let title = getAttirbute(card: card, title: buttonNumber, color: buttonColor)
            
            onButton.setAttributedTitle(title, for: UIControlState.normal)
            
        }
    }

