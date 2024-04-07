//
//  PokedexGenerationView.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 3/31/24.
//

import Foundation
import UIKit

class PokedexGenerationView: UIView {
    
    var pokedexGenerationLabel = UILabel()
    var pokedexGenerationCollectionView: UICollectionView!
    
    func setupView() {
        let flowLayout = UICollectionViewFlowLayout()
        pokedexGenerationCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        setupPokedexGenerationLabel()
        setupPokedexGenerationCollectionView()
    }
    
    func setupPokedexGenerationLabel() {
        pokedexGenerationLabel.text = "Choose Pokemon Generation"
        pokedexGenerationLabel.font = .boldSystemFont(ofSize: 26.0)
        pokedexGenerationLabel.textAlignment = .center
        
        addSubview(pokedexGenerationLabel)
        pokedexGenerationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokedexGenerationLabel.topAnchor.constraint(equalTo: self.topAnchor),
            pokedexGenerationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
            pokedexGenerationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0),
            pokedexGenerationLabel.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    func setupPokedexGenerationCollectionView() {
        addSubview(pokedexGenerationCollectionView)
        pokedexGenerationCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokedexGenerationCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pokedexGenerationCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            pokedexGenerationCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            pokedexGenerationCollectionView.topAnchor.constraint(equalTo: self.pokedexGenerationLabel.bottomAnchor)
        ])
    }
    
}
