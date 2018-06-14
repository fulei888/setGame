//
//  ViewController.swift
//  Concetration
//
//  Created by Lei Fu on 5/2/18.
//  Copyright © 2018 Lei Fu. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    
    private lazy var game: Concentration = Concentration( numberOfPairsOfCards: numberOfPairsOfCards)
    var themeContoller: ConcentrationThemeChooserViewController = ConcentrationThemeChooserViewController()
    var colors=[
    [#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)],
    [#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)],
    [#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)],
    [#colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        
    ]
    var buttonColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
     var ran = Int(arc4random_uniform(3))
    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1)/2
    }
//    private(set) var flipCount = 0 {
//        didSet {
//            flipCountLabel.text = "Flips:\(flipCount)"
//
//        }
//    }
    
    @IBAction func Restart(_ sender: Any) {
        themeContoller.themes = [
            
            
            "Halloween": "👻🎃👿👹👺🤡💩👽👾🤖☠️",
            "Fruit": "🍅🍇🍋🍌🍉🍑🥝🥑🍓🍍🍐",
            "Animals": "🐶🐱🐯🐷🙉🦆🦄🐣🦊🦁🐮",
            "Sports": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓🏸🥅",
            "Flags": "🏳️‍🌈🇦🇫🏁🇦🇬🇦🇹🇧🇸🇧🇭🇦🇿🇧🇬🇧🇫🇨🇳",
            "Cars": "🚗🚕🚙🚌🚎🏎🚚🚜🚲🚘🚖"
            
        ]
        colors=[
            [#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)],
            [#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)],
            [#colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1), #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)],
            [#colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1), #colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1)]
        ]
         ran = Int(arc4random_uniform(3))
        
        self.view.backgroundColor = colors[ran][0]
        buttonColor = colors[ran][1]
        Score.text = "Scores:0"
        flipCountLabel.text = "Flips:0"
        game.resetCards()
        game=Concentration( numberOfPairsOfCards: numberOfPairsOfCards)
        emoji.removeAll()
//        emojiChoices = [
//            ["👻","🎃","👿","👹","👺", "🤡", "💩", "👽","👾","🤖","☠️"],
//            ["🍅","🍇","🍋","🍌","🍉", "🍑", "🥝", "🥑","🍓","🍍","🍐"],
//            ["🐶","🐱","🐯","🐷","🙉", "🦆", "🦄", "🐣","🦊","🦁","🐮"],
//            ["⚽️","🏀","🏈","⚾️","🎾", "🏐", "🏉", "🎱","🏓","🏸","🥅"],
//            ["🏳️‍🌈","🇦🇫","🏁","🇦🇬","🇦🇹", "🇧🇸", "🇧🇭", "🇦🇿","🇧🇬","🇧🇫","🇨🇳"],
//            ["🚗","🚕","🚙","🚌","🚎", "🏎", "🚚", "🚜","🚲","🚘","🚖"]
//        ]
//        random = Int(arc4random_uniform(6))
        
        
        updateViewFromModel()
        
        
    }
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var Score: UILabel!
    @IBAction private func touchCard(_ sender: UIButton) {
        
         
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            print("chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel(){
       // flipCountLabel.text = "Scores:\(game.score)"
        guard cardButtons != nil else { return }
            for index in cardButtons.indices{
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                }
                else {
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 0) : buttonColor
                    
                }
            }
        Score.text = "Scores:\(game.score)"
        flipCountLabel.text = "Flips:\(game.flipCount)"
            
        }
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    private var emojiChoices = "🦇😱🙀😈🎃👻🍭🍬🍎"
    
    private var emoji = [ConcentrationCard: String]()
    
    private func emoji(for card: ConcentrationCard) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let stringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: stringIndex))
        }
        return emoji[card] ?? "?"
    }
    
//        private var emojiChoices = [
//        ["👻","🎃","👿","👹","👺", "🤡", "💩", "👽","👾","🤖","☠️"],
//        ["🍅","🍇","🍋","🍌","🍉", "🍑", "🥝", "🥑","🍓","🍍","🍐"],
//        ["🐶","🐱","🐯","🐷","🙉", "🦆", "🦄", "🐣","🦊","🦁","🐮"],
//        ["⚽️","🏀","🏈","⚾️","🎾", "🏐", "🏉", "🎱","🏓","🏸","🥅"],
//        ["🏳️‍🌈","🇦🇫","🏁","🇦🇬","🇦🇹", "🇧🇸", "🇧🇭", "🇦🇿","🇧🇬","🇧🇫","🇨🇳"],
//        ["🚗","🚕","🚙","🚌","🚎", "🏎", "🚚", "🚜","🚲","🚘","🚖"]
//        ]
    

//        private var emoji = [Int : String]()
//        var random = Int(arc4random_uniform(6))
//        private func emoji(for card: ConcentrationCard) -> String {
//
//
//            if emoji[card.identifier] == nil, emojiChoices[random].count > 0 {
//
//                emoji[card.identifier] = emojiChoices[random].remove(at: emojiChoices[random].count.arc4random)
//
//            }
//            return emoji[card.identifier] ?? "?"
//        }
}














