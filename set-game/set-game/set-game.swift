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
    private(set) var index1 = 0
    private(set) var index2 = 0
    private(set) var index3 = 0
    private(set) var delayColorSiginal = false
    private(set) var delayCardSignal = false
    private(set) var score = 10
    private(set) var color = false
    
    private(set) var symbol = false
    private(set) var shading = false
    private(set) var number = false
    var noRestCardSignal = false
    var freezingIndex = [Int]()
    func reset(){
        restCards.removeAll()
        clickedCards.removeAll()
        cards.removeAll()
        makeAllCards()
        score = 10
        
        
        
        setCards(numberOfCards: 12)
    }
    
    func checkDifferentFeature (){
        var colorsame = false
        var colordif = false
        var numbersame = false
        var numberdif = false
        var shadsame = false
        var shaddif = false
        var symbolsame = false
        var symboldif = false
        if (clickedCards[0].cardColor, clickedCards[1].cardColor) == (clickedCards[1].cardColor, clickedCards[2].cardColor){
            
            print ("color is eaqal")
            colorsame = true
        }
        if clickedCards[0].cardColor != clickedCards[1].cardColor && clickedCards[1].cardColor != clickedCards[2].cardColor && clickedCards[0].cardColor != clickedCards[2].cardColor {
            
            print ("color is totally not eaqal")
            colordif = true
        }
        if (clickedCards[0].cardNumber, clickedCards[1].cardNumber) == (clickedCards[1].cardNumber, clickedCards[2].cardNumber){
            
            print ("number is same")
            numbersame = true
        }
        if clickedCards[0].cardNumber != clickedCards[1].cardNumber && clickedCards[1].cardNumber != clickedCards[2].cardNumber && clickedCards[0].cardNumber != clickedCards[2].cardNumber {
            
            print ("number is not same")
            numberdif = true
            
        }
        if (clickedCards[0].cardShading, clickedCards[1].cardShading) == (clickedCards[1].cardShading, clickedCards[2].cardShading){
            
            print ("shap is same")
            shadsame = true
        }
        if clickedCards[0].cardShading != clickedCards[1].cardShading && clickedCards[1].cardShading != clickedCards[2].cardShading && clickedCards[0].cardShading != clickedCards[2].cardShading {
            
            print ("shap is not same")
            shaddif = true
        }
        
        if clickedCards[0].cardSymbol != clickedCards[1].cardSymbol && clickedCards[1].cardSymbol != clickedCards[2].cardSymbol && clickedCards[0].cardSymbol != clickedCards[2].cardSymbol {
            
            print ("symbol is not same")
            symbolsame = true
            
        }
        if (clickedCards[0].cardSymbol, clickedCards[1].cardSymbol) == (clickedCards[1].cardSymbol, clickedCards[2].cardSymbol){
            
            print ("symbol is  same")
            symboldif = true
        }
        
        if colorsame || colordif {
            color = true
        }
        else {
            color = false
        }
        if numberdif || numbersame {
            number = true
        }
        else {
            number = false
        }
        if symboldif || symbolsame {
            symbol = true
        }
        else {
            symbol = false
        }
        if shaddif || shadsame {
            shading = true
        }
        else {
            shading = false
        }
        
        
    }
    
    
    func checkMatch() -> Bool {
        
        print (color,shading,symbol,number)
        if clickedCards.count == 3 {
            print("three appear")
            checkDifferentFeature()
            
            
            //            if (color && shading && symbol && number) {
            //                print ("woddff",color && shading && symbol && number)
            //                cards[cards.index(of: clickedCards[0])!].isMatched = true
            //                cards[cards.index(of: clickedCards[1])!].isMatched = true
            //                cards[cards.index(of: clickedCards[2])!].isMatched = true
            //                return true
            //            }
            
            if (clickedCards[0].cardColor, clickedCards[1].cardColor) == (clickedCards[1].cardColor, clickedCards[2].cardColor){
                cards[cards.index(of: clickedCards[0])!].isMatched = true
                cards[cards.index(of: clickedCards[1])!].isMatched = true
                cards[cards.index(of: clickedCards[2])!].isMatched = true
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
        
        
        
        cards[index].clicked = true
        
        if clickedCards.contains(cards[index]) {
            
            
        }
        else {
            clickedCards.append(cards[index])
        }
        
        print("check mathc",checkMatch())
        if checkMatch(){
            
            delayCardSignal = true
            
            score += 3
            print("score",score)
        }
        else if clickedCards.count==3 && !checkMatch(){
            
            index1=cards.index(of: clickedCards[0])!
            index2=cards.index(of: clickedCards[1])!
            index3=cards.index(of: clickedCards[2])!
            delayColorSiginal = true
            score -= 1
            clickedCards.removeAll()
            
        }
        
        
        
        
    }
    func delayRemoveCard(){
        
        clickedCards.forEach {
            if let indexInCards = cards.index(of: $0){
                
                if restCards.count>0 {
                    cards.remove(at: indexInCards )
                    let newCard = restCards.remove(at: restCards.count.arc4random)
                    cards.insert(newCard, at: indexInCards)
                }
                else {
                    
                    noRestCardSignal = true
                    freezingIndex.append(indexInCards)
                    
                    
                }
                
                //                if restCards.count > 0 {
                //                    noRestCardSignal = true
                //                    freezingIndex.append(indexInCards)
                //
                //                }
                
            }
            
            
            
        }
        clickedCards.removeAll()
        delayCardSignal=false
        
    }
    
    func delayChangColor(){
        cards[index1].clicked = false
        cards[index2].clicked = false
        cards[index3].clicked = false
        delayColorSiginal = false
        
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



