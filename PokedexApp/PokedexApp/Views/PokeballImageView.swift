//
//  PokeballImageView.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 3/28/24.
//

import Foundation
import UIKit

class PokeballImageView: UIView {
    
    func createPokeballImage() {
        let angle0: CGFloat = 0.0
        let angle180: CGFloat = 180.0
        let angle360: CGFloat = 360.0
        
        let topHalfPokeballLayer = CAShapeLayer()
        let topHalfOfPokeballPath = UIBezierPath(arcCenter: CGPoint(x: self.frame.midX, y: self.frame.midY),
                                                 radius: 10,
                                                 startAngle: angle180.toRadians(),
                                                 endAngle: angle360.toRadians(),
                                                 clockwise: true)
        topHalfPokeballLayer.path = topHalfOfPokeballPath.cgPath
        topHalfPokeballLayer.lineWidth = 1
        topHalfPokeballLayer.strokeColor = UIColor.black.cgColor
        topHalfPokeballLayer.fillColor = UIColor.red.cgColor

        self.layer.addSublayer(topHalfPokeballLayer)
        
        let bottomHalfPokeballLayer = CAShapeLayer()
        let bottomHalfOfPokeballPath = UIBezierPath(arcCenter: CGPoint(x: self.frame.midX, y: self.frame.midY),
                                                    radius: 10,
                                                    startAngle: angle0.toRadians(),
                                                    endAngle: angle180.toRadians(),
                                                    clockwise: true)
        bottomHalfPokeballLayer.path = bottomHalfOfPokeballPath.cgPath
        bottomHalfPokeballLayer.lineWidth = 1
        bottomHalfPokeballLayer.strokeColor = UIColor.black.cgColor
        bottomHalfPokeballLayer.fillColor = UIColor.clear.cgColor

        self.layer.addSublayer(bottomHalfPokeballLayer)
        
        let pokeballButtonLayer = CAShapeLayer()
        let pokeballButtonPath = UIBezierPath(arcCenter: CGPoint(x: self.frame.midX, y: self.frame.midY),
                                              radius: 2,
                                              startAngle: angle0.toRadians(),
                                              endAngle: angle360.toRadians(),
                                              clockwise: true)
        pokeballButtonLayer.path = pokeballButtonPath.cgPath
        pokeballButtonLayer.lineWidth = 2
        pokeballButtonLayer.strokeColor = UIColor.black.cgColor
        pokeballButtonLayer.fillColor = UIColor.white.cgColor

        self.layer.addSublayer(pokeballButtonLayer)
    }
    
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}
