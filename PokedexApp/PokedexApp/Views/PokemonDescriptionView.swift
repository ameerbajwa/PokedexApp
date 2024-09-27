//
//  PokemonDescriptionView.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 9/26/24.
//

import Foundation
import UIKit

class PokemonDescriptionView: UIView {
    var viewModel: PokemonDetailsViewModel?
    
    var descriptionTitleLabel = UILabel()
    var descriptionLabel = UILabel()
    
    func setupLabels() {
        descriptionTitleLabel.text = "Description:"
        descriptionTitleLabel.textColor = .black
        descriptionTitleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        descriptionLabel.textColor = .black
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.numberOfLines = 0
        
        self.addSubview(descriptionTitleLabel)
        self.addSubview(descriptionLabel)
        descriptionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 2.5),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5.0),
            descriptionTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5.0),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 5.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0)
        ])
    }
    
    func setupDescriptionValue() {
        guard let pokemonDescription = self.viewModel?.retrievePokemonDescription() else {
            return
        }
        self.descriptionLabel.text = pokemonDescription
    }
}
