//
//  Concentration.swift
//  Concetration
//
//  Created by Lei Fu on 5/5/18.
//  Copyright © 2018 Lei Fu. All rights reserved.
//
extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

import Foundation

class Concentration
{
    private (set) var cards = [ConcentrationCard]()
    private (set) var shuffleCards = [ConcentrationCard]()
    private (set) var score = 0
    private (set) var flipCount = 0
    private (set) var existArray = [Int]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                        
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    func resetCards(){
        cards.removeAll()
        flipCount=0
        
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        flipCount += 1
        if existArray.contains(index) {
            score -= 1
        }
        else {
            existArray.append(index)
            
        }
        
        
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                    
                    existArray.remove(at: existArray.index(of: index)!)
                    existArray.remove(at: existArray.index(of: matchIndex)!)
                }
                cards[index].isFaceUp = true
                
                
            }
            else{
                
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init (numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = ConcentrationCard()
            shuffleCards += [card, card]
        }
        //cards.shuffle()
        for _ in shuffleCards {
            let randomIndex = shuffleCards.count.arc4random
            let randomCard = shuffleCards.remove(at: randomIndex)
            cards.append(randomCard)
        }
    }
    
    
    
    
}
