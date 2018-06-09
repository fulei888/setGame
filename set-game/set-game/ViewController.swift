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
    
    
    var deckView: SetCardView?
    var discardPileView: SetCardView?
    var preCardViews = [SetCardView]()
    
    
    
   // var cardViews = [Card: SetCardView]()
    let bottomViewToBoundsHeightRatio: CGFloat = 0.11
    let sideViewToBoundsWidthRatio: CGFloat = 0.14
    var cardConstants: CardSizeConstants {
        if gameView.bounds.height > gameView.bounds.width {
            return CardSizeConstants(forGameSize: CGSize(
                width: gameView.bounds.width,
                height: gameView.bounds.height * (1 - bottomViewToBoundsHeightRatio)
            ), cardCount: game.cards.count)
        } else {
            return CardSizeConstants(forGameSize: CGSize(
                width: gameView.bounds.width * (1 - sideViewToBoundsWidthRatio),
                height: gameView.bounds.height
            ), cardCount: game.cards.count)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restart()
        
    }
    @IBOutlet weak var Score: UILabel!
    
    @IBOutlet weak var gameView: UIView!
    //{
//        didSet {
//            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(Deal(_:)))
//            swipe.direction = .down
//            gameView.addGestureRecognizer(swipe)
//        }
        
//    }
    @IBAction func Restart(_ sender: Any) {
        
                restart()
            }
    func restart() {
        noMoreThanThree.isEnabled = true
        game.reset()
        updateViewFromModel()
    }
    @IBAction func Cheat(_ sender: UIButton) {
        game.shuffleCard()
        updateViewFromModel()
        
            }
    
    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        print(sender.direction)
        
        if sender.direction == .down {
            print("Swipe down")
            if game.restCards.count == 0 {
                noMoreThanThree.isEnabled = false
            }
            else{
                game.setCards(numberOfCards: 3)
                game.score -= 1
                updateViewFromModel()
                
            }
            
        }
        
        
    }
    
    @IBAction func rotate(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            game.shuffleCard()
            updateViewFromModel()
        default:
            break
        }
        
        
    }
    
    @IBAction func touchCard(_ sender: UITapGestureRecognizer) {
        let touchLocation = sender.location(in: gameView)
                let num = preCardViews.count
                for index in 0..<num {
        
                    if preCardViews[index].frame.contains(touchLocation) {
                        
                        if game.delayColorSiginal{
                            game.delayChangColor()
                        }
                        if game.delayCardSignal{
                            game.delayRemoveCard()
                        }
                        game.chooseCard( closure: game.checkMatch, at: index)
                        
                       
        
                    }
        
        
                }
        updateViewFromModel()

    }
    @IBOutlet weak var noMoreThanThree: UIButton!
    
    
    @IBAction func Deal(_ sender: UIButton) {
        
        drawThreeCard()
        
        
        
    }
    
    func drawThreeCard(){
        if game.restCards.count == 0 {
            noMoreThanThree.isEnabled = false
        }
        else{
            game.setCards(numberOfCards: 3)
            game.score -= 1
            updateViewFromModel()
            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateViewFromModel()
    }
    
    private func positionCard(_ cardView:SetCardView , rowIndex row: Int, columnIndex column: Int) {
        
        var xOrigin = gameView.bounds.origin.x + CGFloat(column) * cardConstants.cardWidth + (2 * CGFloat(column) + 1) * cardConstants.horizontalCardSeperation
        let yOrigin = gameView.bounds.origin.y + CGFloat(row) * cardConstants.cardHeight + (2 * CGFloat(row) + 1) * cardConstants.verticalCardSeperation
        let cardSize = CGSize(width: cardConstants.cardWidth, height: cardConstants.cardHeight)
        
        if gameView.bounds.height < gameView.bounds.width {
            xOrigin += gameView.bounds.width * sideViewToBoundsWidthRatio
        }
        
        cardView.frame.origin = CGPoint(x: xOrigin, y: yOrigin)
        cardView.frame.size = cardSize
        
        gameView.addSubview(cardView)
    }
    
    
    
    private func updateViewFromModel(){
        Score.text = "Score: \(game.score)"
        
       
        
        
       
        removePreviousView()
        
        for index in game.cards.indices{
            
                let card = game.cards[index]
                let cardView = createCardView(card)
            if card.clicked{
                
                if card.isMatched{
                    cardView.blueBorder=true
                }
                else{
                    cardView.redBorder=true
                }
                
                print("clicked")
            }
            
                positionCard(cardView, rowIndex: index / cardConstants.columnCount, columnIndex: index % cardConstants.columnCount)
            preCardViews.append(cardView)
        }
//        if game.noRestCardSignal {
//            print("I am ehererere")
//            let  freezingIndex1 = game.freezingIndex[0]
//            let freezingIndex2 = game.freezingIndex[1]
//            let  freezingIndex3 = game.freezingIndex[2]
//            var cards = game.cards
//            
//            
//            print(freezingIndex1,freezingIndex2,freezingIndex3)
//            
////            cards.remove(at: freezingIndex1 )
////            cards.remove(at: freezingIndex2 )
////            cards.remove(at: freezingIndex3 )
////            preCardViews[freezingIndex1].removeFromSuperview()
////            preCardViews[freezingIndex2].removeFromSuperview()
////            preCardViews[freezingIndex3].removeFromSuperview()
//            
//            cards.removeAll()
//            print("card number",game.cards.count)
//            
//            game.freezingIndex.removeAll()
//            game.noRestCardSignal = false
//        }
        
    
    }
    
    func removePreviousView(){
        for cardview in preCardViews {
            cardview.removeFromSuperview()
        }
        preCardViews.removeAll()
        
    }
    
//    func getCardView(for card: Card) ->SetCardView{
//        if cardViews[card] == nil {
//            cardViews[card] = createCardView(card)
//        }
//        return cardViews[card] ?? SetCardView()
//    }
    private func createCardView(_ card:Card)-> SetCardView {
        let cardView = SetCardView()
        
        cardView.number = convertNumber(card)
        
        switch card.cardColor {
            
        case .green:
            cardView.color = UIColor.green
        case .red:
            cardView.color = UIColor.red
        case .blue:
            cardView.color = UIColor.blue
            
        }
        switch card.cardShading {
            
            case .open:
            cardView.shading = SetCardView.CardShading.outline
            case .solid:
                cardView.shading = SetCardView.CardShading.solid
            case .striped:
                cardView.shading = SetCardView.CardShading.striped
        
        }
        switch card.cardSymbol{
           
            case .diamond:
            cardView.shape = SetCardView.CardShape.diamond
            
            case .oval:
                cardView.shape = SetCardView.CardShape.oval
            case .squiggle:
                cardView.shape = SetCardView.CardShape.squiggle
            
        }
        cardView.frame = deckView?.frame ?? CGRect.zero
        
        return cardView
    }
    
    func convertNumber(_ card:Card)->Int{
        
        switch card.cardNumber{
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        }
        
        
    }
    
}
    
//    private var game: setgame = setgame()
//    private var delayGoBackColor = false
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        restart()
//
//    }
//
//    @IBOutlet weak var Score: UILabel!
//
//    @IBAction func Restart(_ sender: Any) {
//
//        restart()
//    }
//    func restart() {
//        disAbleAllButton()
//        noMoreThanThree.isEnabled = true
//        for buttonNum in cardButtons.indices{
//            let button = cardButtons[buttonNum]
//            button.setAttributedTitle(nil, for:  UIControlState.normal)
////            button.layer.borderColor = UIColor.white.cgColor
////            button.layer.borderWidth = 3
//            button.originState()
//            button.isHidden = false
//            button.layer.cornerRadius = 8
//        }
//        game.reset()
//        updateViewFromModel()
//
//    }
//
//
//
//    @IBAction func Cheat(_ sender: UIButton) {
//    }
//
//
//    @IBOutlet weak var noMoreThanThree: UIButton!
//
//    @IBAction func Deal(_ sender: UIButton) {
//        if game.delayCardSignal{
//
//            game.delayRemoveCard()
//
//        }
//        else {
//            game.setCards(numberOfCards: 3)
//
//            if game.cards.count >= 24 {
//                noMoreThanThree.isEnabled = false
//            }
//        }
//        updateViewFromModel()
//    }
//
//    @IBOutlet var cardButtons: [UIButton]!
//
//
//
//    @IBAction func touchCard(_ sender: UIButton) {
//        print("I love you william")
//        if let cardNumber = cardButtons.index(of: sender){
//            print(cardNumber)
//            if game.delayColorSiginal{
//                game.delayChangColor()
//            }
//            if game.delayCardSignal{
//                game.delayRemoveCard()
//            }
//            game.chooseCard( closure: game.checkMatch, at: cardNumber)
//            updateViewFromModel()
//
//        }
//        else{
//            print("Chosen card was not in cardButtons")
//        }
//
//
//    }
//    func disAbleAllButton(){
//        for i in cardButtons.indices{
//            let button = cardButtons[i]
//            button.isEnabled = false
//
//        }
//    }
//
//    private func updateViewFromModel(){
//
//        Score.text = "Score: \(game.score)"
//
//        if game.noRestCardSignal {
//
//            let  freezingIndex1 = game.freezingIndex[0]
//            let freezingIndex2 = game.freezingIndex[1]
//            let  freezingIndex3 = game.freezingIndex[2]
//            //            cardButtons[freeingIndex1].backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
//            //            cardButtons[freeingIndex2].backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
//            //            cardButtons[freeingIndex3].backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
//            //            cardButtons[freeingIndex1] isEnabled=true
//            //            cardButtons[freeingIndex2].isEnabled=true
//            //            cardButtons[freeingIndex3].isEnabled=true
//            cardButtons[freezingIndex1].isHidden = true
//            cardButtons[freezingIndex2].isHidden = true
//            cardButtons[freezingIndex3].isHidden = true
//            game.freezingIndex.removeAll()
//            game.noRestCardSignal = false
//        }
//
//
////        let checkedChange = game.cards.indices.filer {cards[$0].clicked}
////        return
//
//
//        for index in game.cards.indices{
//            let button = cardButtons[index]
//            let card = game.cards[index]
//
//
//            button.isEnabled=true
//            button.layer.cornerRadius = 8
//
//            buttonTitle.giveTitle(card: card, onButton: button)
//
//
//
//
//
//            if card.clicked {
//
//                if card.isMatched {
////                    button.layer.borderColor = UIColor.green.cgColor
////                    button.layer.borderWidth = 3
//                    button.matchedState()
//
//
//                }
//                else{
////                    button.layer.borderColor = UIColor.red.cgColor
////                    button.layer.borderWidth = 3
//                    button.noMatchedState()
//
//                }
//
//            }
//            else {
//
////                button.layer.borderColor = UIColor.white.cgColor
////                button.layer.borderWidth = 3
//                button.originState()
//
//            }
//
//        }
//    }
//
//}
//extension UIButton {
//    func originState(){
//        self.layer.borderColor = UIColor.white.cgColor
//        self.layer.borderWidth = 3
//    }
//    func matchedState(){
//        self.layer.borderColor = UIColor.green.cgColor
//        self.layer.borderWidth = 3
//    }
//    func noMatchedState(){
//        self.layer.borderColor = UIColor.red.cgColor
//        self.layer.borderWidth = 3
//    }
    
    
    
   
    


