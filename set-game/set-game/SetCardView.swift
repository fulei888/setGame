//
//  SetCardView.swift
//  set-game
//
//  Created by guest1 on 6/2/18.
//  Copyright © 2018 Lei Fu. All rights reserved.
//

import UIKit

@IBDesignable

class SetCardView: UIView {
    
    @IBInspectable
    var shape: String = ""  { didSet { setNeedsDisplay() } }
    @IBInspectable
    var color: UIColor = .green //You can use UIColor with @IBInspectable too (String, Int, Bool and UIColor)
    
    enum Shape: String {
        case diamond
        case squiggle
        case oval
    }
    enum Color: String{
        case red
        case green
        case blue
    }
    
    override func draw(_ rect: CGRect) {
        //Use this to save and restore your
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        transform = CGAffineTransform.identity.translatedBy(x: 10, y: 10)
        context?.restoreGState()
        
        switch shape {
        case Shape.diamond.rawValue:
            
            drawDiamond()
        case Shape.oval.rawValue:
            drawOval()
        case Shape.squiggle.rawValue:
            drawSquiggle()
            
        default: break
        }
        
//        switch color {
//        case Color.red:
//            drawRed()
//        case Color.blue:
//            drawBlue()
//        case Color.green.rawValue:
//            drawGreen()
//        }
//        let card = Card()
//        switch  card.cardSymbol{
//        case .diamond:
//
//            drawDiamond()
//        case .oval:
//            drawOval()
//
//        case .squiggle:
//            drawSquiggle()
//        default: break
//        }
//        switch card.cardColor {
//        case .blue:
//
//        case .red:
//
//        case .green:
//
//        }
    }
    
    
    private struct DrawingConstants {
        static let padding: CGFloat = 0.05
        static let topPadding: CGFloat = 0.05
        static let paddingDiamond: CGFloat = 0.05
    }
    
    private func drawDiamond() {
        let path = UIBezierPath()
//        path.move(to: CGPoint(x: bounds.minX+bounds.width*DrawingConstants.padding, y: bounds.midY))
        
        path.move(to: CGPoint(x: bounds.midX, y: bounds.minY + bounds.width*DrawingConstants.paddingDiamond))
        path.addLine(to: CGPoint(x: bounds.maxX - bounds.width*DrawingConstants.paddingDiamond, y: bounds.midY))
        path.addLine(to: CGPoint(x: bounds.midX, y: bounds.maxY - bounds.width*DrawingConstants.paddingDiamond))
        path.addLine(to: CGPoint(x: bounds.minX + bounds.width*DrawingConstants.paddingDiamond, y: bounds.midY))
        path.close()
        UIColor.red.setStroke()
        path.stroke()
    }
    
    private func drawOval() {
        let path = UIBezierPath()

        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.height*0.2),radius: bounds.width*0.1, startAngle: 180.degreesToRadians , endAngle: 0.degreesToRadians, clockwise: true)
        
        
        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.height*0.8),radius: bounds.width*0.1, startAngle:0.degreesToRadians , endAngle: 180.degreesToRadians, clockwise: true)
        path.addLine(to: CGPoint(x:bounds.midX-bounds.width*0.1, y:bounds.height*0.2))
        
//        (arcCenter: CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2),
//         radius: self.frame.size.height/2,
//         startAngle: CGFloat(180.0).toRadians(),
//         endAngle: CGFloat(0.0).toRadians(),
//         clockwise: true)
        path.lineWidth = 3
        UIColor.green.setFill()
        UIColor.blue.setStroke()
        path.stroke()
        
    }
    private func drawSquiggle() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.minX+bounds.width*0.1
            , y: bounds.minY+bounds.height*0.4))

        path.addCurve(to: CGPoint(x: self.frame.size.width-frame.size.width*0.1, y:self.frame.size.height-frame.size.height*0.4 ),
                      controlPoint1: CGPoint(x: self.frame.size.width - self.frame.size.width*0.4, y: -frame.size.height*0.3),
                      controlPoint2: CGPoint(x: self.frame.size.width*0.3, y: frame.size.height*0.8))
        
        path.addCurve(to: CGPoint(x: bounds.minX+bounds.width*0.1, y:bounds.minY+bounds.height*0.4 ),
                      controlPoint1: CGPoint(x: self.frame.size.width * 0.5, y: frame.size.height + frame.size.height*0.3),
                      controlPoint2: CGPoint(x: self.frame.size.width*0.5, y: frame.size.height*0.3))
        


        path.close()
        UIColor.red.setStroke()
        path.stroke()
       
    }
   
}
extension BinaryInteger {
    var degreesToRadians: CGFloat { return CGFloat(Int(self)) * .pi / 180 }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
