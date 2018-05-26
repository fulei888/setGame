//
//  set-game.swift
//  set-game
//
//  Created by Lei Fu on 5/20/18.
//  Copyright © 2018 Lei Fu. All rights reserved.
//

import Foundation
class setgame{
    
    private(set) var cards = [Card]()
    private(set) var restCards = [Card]()
    private(set) var clickedCards = [Card]()
    
    func reset(){
        
        cards.removeAll()
        makeAllCards()
//        for num in cards.indices{
//             cards[num].clicked = false
//             cards[num].isMatched = false
//        }
        
        setCards(numberOfCards: 12)
    }
    
    
    func checkMatch() -> Bool {
        
        if clickedCards.count == 3 {
            if (clickedCards[0].cardColor, clickedCards[1].cardColor) == (clickedCards[1].cardColor, clickedCards[2].cardColor){
                
                return true
            }
            else if clickedCards[0].cardColor != clickedCards[1].cardColor && clickedCards[1].cardColor != clickedCards[2].cardColor && clickedCards[0].cardColor != clickedCards[2].cardColor {
                
                return true
                
            }
            else if (clickedCards[0].cardNumber, clickedCards[1].cardNumber) == (clickedCards[1].cardNumber, clickedCards[2].cardNumber){
                
                return true
            }
            else if clickedCards[0].cardNumber != clickedCards[1].cardNumber && clickedCards[1].cardNumber != clickedCards[2].cardNumber && clickedCards[0].cardNumber != clickedCards[2].cardNumber {
                
                return true
                
            }
            else if (clickedCards[0].cardShading, clickedCards[1].cardShading) == (clickedCards[1].cardShading, clickedCards[2].cardShading){
                
                return true
            }
            else if clickedCards[0].cardSymbol != clickedCards[1].cardSymbol && clickedCards[1].cardSymbol != clickedCards[2].cardSymbol && clickedCards[0].cardSymbol != clickedCards[2].cardSymbol {
                
                return true
                
            }
            else {
                return false
            }
            
            
            
        }
        else{
        
        return false
        }
        
        
    }
    
    
    func chooseCard (at index: Int) {
        assert(cards.indices.contains(index), "chosen index not in the cards")
        
        if !cards[index].isMatched {
            cards[index].clicked = true
            
        }
        if checkMatch(){
            for selectCard in clickedCards {
                if let indexInCards = cards.index(of: selectCard){
                    cards.remove(at: indexInCards )
                    if restCards.count>0 {
                        let newCard = restCards.remove(at: restCards.count.arc4random)
                        cards.insert(newCard, at: indexInCards)
                    }
                    
                }
                
                
                
            }
            clickedCards.removeAll()
        }
        else if clickedCards.count==3 && !checkMatch(){
            clickedCards.removeAll()
        }
        if clickedCards.contains(cards[index]) {
            
        }
        else {
            clickedCards.append(cards[index])
        }
        
        print(clickedCards.count)
    }
    
    func makeAllCards(){
        
        for color in CardColor.allValues {
            for symbol in CardSymbol.allValues{
                for number in CardNumber.allValues{
                    for shading in CardShading.allValues{
                        let newCard = Card(clicked: false, isMatched: false, cardColor: color, cardSymbol: symbol, cardNumber: number, cardShading: shading)
                            restCards.append(newCard)
                        
                        }
                    }
                }
            }
        }
    
    func giveCard (){
        
        
            let randomIndex = Int(arc4random_uniform(UInt32(restCards.count)))
            let randomCard = restCards.remove(at: randomIndex)
            cards.append(randomCard)
    }
    
    func setCards (numberOfCards: Int) {
        
        for _ in 0..<numberOfCards {
            giveCard()
        }
        
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
            
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
}
}



