//
//  PokemonDetailsView.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 5/7/24.
//

import Foundation
import UIKit

class PokemonDetailsView: UIView {
    var viewModel: PokemonDetailsViewModel?
    
    var imageView = UIImageView()
    var idLabel = UILabel()
    var nameLabel = UILabel()
    var typeLabel = UILabel()
    var regionLabel = UILabel()
    var labelStackView = UIStackView()
    
    func setup() {
        setupImageView()
        setupLabels()
    }
    
    func setupImageView() {
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 5.0
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
            imageView.widthAnchor.constraint(equalToConstant: 150.0),
            imageView.heightAnchor.constraint(equalToConstant: 150.0)
        ])
    }
    
    func setupLabels() {
        idLabel.font = UIFont.systemFont(ofSize: 12.0)
        nameLabel.font = UIFont.systemFont(ofSize: 12.0)
        typeLabel.font = UIFont.systemFont(ofSize: 12.0)
        regionLabel.font = UIFont.systemFont(ofSize: 12.0)
        
        labelStackView.axis = .vertical
        labelStackView.distribution = .fillEqually
        labelStackView.alignment = .leading
        
        labelStackView.addArrangedSubview(idLabel)
        labelStackView.addArrangedSubview(nameLabel)
        labelStackView.addArrangedSubview(typeLabel)
        labelStackView.addArrangedSubview(regionLabel)
        
        self.addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
            labelStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10.0),
            labelStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
            labelStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0)
        ])
    }
    
    func setValues() {
        guard let masterPokemonDetails = self.viewModel?.masterPokemonDetails else {
            return
        }
        idLabel.text = "ID: \(masterPokemonDetails.pokemonDetails.id)"
        nameLabel.text = "NAME: \(masterPokemonDetails.pokemonDetails.name)"
        if masterPokemonDetails.pokemonDetails.types.count > 1 {
            typeLabel.text = "TYPE: \(masterPokemonDetails.pokemonDetails.types[0].type.name) \(masterPokemonDetails.pokemonDetails.types[1].type.name)"
        } else {
            typeLabel.text = "TYPE: \(masterPokemonDetails.pokemonDetails.types[0].type.name)"
        }
        regionLabel.text = "REGION: \(masterPokemonDetails.pokemonSpeciesDetails.habitat)"
        Task {
            self.imageView.image = await self.viewModel?.generatePokemonImage()
        }
        
    }
}
