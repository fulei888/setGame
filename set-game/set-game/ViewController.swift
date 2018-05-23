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
    
    @IBOutlet weak var Score: UILabel!
    
    @IBAction func Restart(_ sender: Any) {
    }
    
    
    @IBAction func Cheat(_ sender: UIButton) {
    }
    
    
    @IBAction func Deal(_ sender: UIButton) {
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

    private func updateViewFromModel(){
        
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.clicked{
                button.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }

        }
    }
        
}

