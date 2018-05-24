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
    private(set) var shuffleCards = [Card]()
    private(set) var clickedCards = [Card]()
    
    func reset(){
        for num in cards.indices{
             cards[num].clicked = false
             cards[num].isMatched = false
        }
    }
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "chosen index not in the cards")
        
        if !cards[index].isMatched {
        cards[index].clicked = true
        clickedCards.append(cards[index])
        }
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
            else if (clickedCards[0].cardShadinng, clickedCards[1].cardShadinng) == (clickedCards[1].cardShadinng, clickedCards[2].cardShadinng){
                
                return true
            }
            else if clickedCards[0].cardSymbol != clickedCards[1].cardSymbol && clickedCards[1].cardSymbol != clickedCards[2].cardSymbol && clickedCards[0].cardSymbol != clickedCards[2].cardSymbol {
                
                return true
                
            }
            else {
                return false
            }
            
            clickedCards.removeAll()
            
        }
        else{
        
        return false
        }
        
        
    }
    
    func makeAllCards(){
        
        for color in CardColor.allValues {
            for symbol in CardSymbol.allValues{
                for number in CardNumber.allValues{
                    for shading in CardShading.allValues{
                        let newCard = Card(clicked: false, isMatched: false, cardColor: color, cardSymbol: symbol, cardNumber: number, cardShadinng: shading)
                            shuffleCards.append(newCard)
                        
                        }
                    }
                }
            }
        }
    
    func mixCard (){
        makeAllCards()
        for _ in shuffleCards{
            let randomIndex = Int(arc4random_uniform(UInt32(shuffleCards.count)))
            let randomCard = shuffleCards.remove(at: randomIndex)
            cards.append(randomCard)
            
        }
    }
    init(){
        
        self.mixCard()
        print(cards)
       
       
        }
}


