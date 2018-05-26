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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.reset()
        disAbleAllButton()
        updateViewFromModel()
        
    }
    
    @IBOutlet weak var Score: UILabel!
    
    @IBAction func Restart(_ sender: Any) {
        disAbleAllButton()
        noMoreThanThree.isEnabled = true
        for buttonNum in cardButtons.indices{
            let button = cardButtons[buttonNum]
            button.setAttributedTitle(nil, for:  UIControlState.normal)
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 3
        }
        game.reset()
        updateViewFromModel()
    }
    
    
    @IBAction func Cheat(_ sender: UIButton) {
    }
    
    
    @IBOutlet weak var noMoreThanThree: UIButton!
    
    @IBAction func Deal(_ sender: UIButton) {
        game.setCards(numberOfCards: 3)
        updateViewFromModel()
        if game.cards.count >= 24 {
            noMoreThanThree.isEnabled = false
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    

    @IBAction func touchCard(_ sender: UIButton) {
        print("I love you william")
        if let cardNumber = cardButtons.index(of: sender){
            print(cardNumber)
            game.chooseCard(at: cardNumber)
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
        
        for index in game.cards.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            button.isEnabled=true
            button.layer.cornerRadius = 8
            
            buttonTitle.giveTitle(card: card, onButton: button)
            if card.clicked{
                button.layer.borderColor = UIColor.green.cgColor
                button.layer.borderWidth = 3
                
            }

        }
    }
        
}

