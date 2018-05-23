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
    
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "chosen index not in the cards")
        
        if !cards[index].isMatched {
        cards[index].clicked = true
            print("card clicked")
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


