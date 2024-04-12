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
        let flowLayout = setupPokedexGenerationFlowLayout()
        pokedexGenerationCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        setupPokedexGenerationLabel()
        setupPokedexGenerationCollectionView()
    }
    
    func setupPokedexGenerationFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 150.0, height: 90.0)
        flowLayout.sectionInset = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 10.0, right: 10.0)
        return flowLayout
    }
    
    func setupPokedexGenerationLabel() {
        pokedexGenerationLabel.text = "Welcome to the Universal Pokedex \n- \nChoose Pokemon Generation"
        pokedexGenerationLabel.numberOfLines = 0
        pokedexGenerationLabel.font = .boldSystemFont(ofSize: 28.0)
        pokedexGenerationLabel.textAlignment = .center
        
        addSubview(pokedexGenerationLabel)
        pokedexGenerationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokedexGenerationLabel.topAnchor.constraint(equalTo: self.topAnchor),
            pokedexGenerationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
            pokedexGenerationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0),
            pokedexGenerationLabel.heightAnchor.constraint(equalToConstant: 200.0)
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
