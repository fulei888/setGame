//
//  ViewController.swift
//  set-game
//
//  Created by Lei Fu on 5/20/18.
//  Copyright © 2018 Lei Fu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var game: setgame = setgame()
    private var delayGoBackColor = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restart()
    }
    
    @IBOutlet weak var Score: UILabel!
    
    @IBAction func Restart(_ sender: Any) {

        restart()
    }
    func restart() {
        disAbleAllButton()
        noMoreThanThree.isEnabled = true
        for buttonNum in cardButtons.indices{
            let button = cardButtons[buttonNum]
            button.setAttributedTitle(nil, for:  UIControlState.normal)
//            button.layer.borderColor = UIColor.white.cgColor
//            button.layer.borderWidth = 3
            button.originState()
            button.isHidden = false
            button.layer.cornerRadius = 8
        }
        game.reset()
        updateViewFromModel()
        
    }
    
    
    
    @IBAction func Cheat(_ sender: UIButton) {
    }
    
    
    @IBOutlet weak var noMoreThanThree: UIButton!
    
    @IBAction func Deal(_ sender: UIButton) {
        if game.delayCardSignal{
            
            game.delayRemoveCard()
            
        }
        else {
            game.setCards(numberOfCards: 3)
            
            if game.cards.count >= 24 {
                noMoreThanThree.isEnabled = false
            }
        }
        updateViewFromModel()
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        print("I love you william")
        if let cardNumber = cardButtons.index(of: sender){
            print(cardNumber)
            if game.delayColorSiginal{
                game.delayChangColor()
            }
            if game.delayCardSignal{
                game.delayRemoveCard()
            }
            game.chooseCard( closure: game.checkMatch, at: cardNumber)
            updateViewFromModel()
            
        }
        else{
            print("Chosen card was not in cardButtons")
        }
        
        
    }
    func disAbleAllButton(){
        for i in cardButtons.indices{
            let button = cardButtons[i]
            button.isEnabled = false
            
        }
    }
    
    private func updateViewFromModel(){
        
        Score.text = "Score: \(game.score)"
        
        if game.noRestCardSignal {
            
            let  freezingIndex1 = game.freezingIndex[0]
            let freezingIndex2 = game.freezingIndex[1]
            let  freezingIndex3 = game.freezingIndex[2]
            //            cardButtons[freeingIndex1].backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            //            cardButtons[freeingIndex2].backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            //            cardButtons[freeingIndex3].backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            //            cardButtons[freeingIndex1] isEnabled=true
            //            cardButtons[freeingIndex2].isEnabled=true
            //            cardButtons[freeingIndex3].isEnabled=true
            cardButtons[freezingIndex1].isHidden = true
            cardButtons[freezingIndex2].isHidden = true
            cardButtons[freezingIndex3].isHidden = true
            game.freezingIndex.removeAll()
            game.noRestCardSignal = false
        }
        
        
//        let checkedChange = game.cards.indices.filer {cards[$0].clicked}
//        return
        
        
        for index in game.cards.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            
            
            button.isEnabled=true
            button.layer.cornerRadius = 8
            
            buttonTitle.giveTitle(card: card, onButton: button)
            
            
            
            
            
            if card.clicked {
                
                if card.isMatched {
//                    button.layer.borderColor = UIColor.green.cgColor
//                    button.layer.borderWidth = 3
                    button.matchedState()
                    
                    
                }
                else{
//                    button.layer.borderColor = UIColor.red.cgColor
//                    button.layer.borderWidth = 3
                    button.noMatchedState()
                    
                }
                
            }
            else {
                
//                button.layer.borderColor = UIColor.white.cgColor
//                button.layer.borderWidth = 3
                button.originState()
                
            }
            
        }
    }
    
}
extension UIButton {
    func originState(){
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 3
    }
    func matchedState(){
        self.layer.borderColor = UIColor.green.cgColor
        self.layer.borderWidth = 3
    }
    func noMatchedState(){
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 3
    }
}

