//
//  PokedexGenerationCollectionViewCell.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 3/31/24.
//

import Foundation
import UIKit

class PokedexGenerationCollectionViewCell: UICollectionViewCell {
    
    var generationLabel = UILabel()
    
    func setupGenerationLabel(of generation: Int) {
        generationLabel.text = "Generation \n\(generation + 1)"
        generationLabel.numberOfLines = 0
        generationLabel.font = .boldSystemFont(ofSize: 20.0)
        generationLabel.textAlignment = .center
        generationLabel.textColor = .black
        
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.black.cgColor
        
        addSubview(generationLabel)
        generationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            generationLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            generationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
