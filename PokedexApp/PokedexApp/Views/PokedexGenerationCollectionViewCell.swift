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
        generationLabel.text = "Generation \(generation)"
        generationLabel.font = .boldSystemFont(ofSize: 16.0)
        generationLabel.textAlignment = .center
        generationLabel.textColor = .white
        
        addSubview(generationLabel)
        generationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            generationLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            generationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
