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
    var habitatLabel = UILabel()
    var infoLabelStackView = UIStackView()
    
    func setup() {
        setupImageView()
        setupInfoLabels()
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
    
    func setupInfoLabels() {
        idLabel.font = UIFont.systemFont(ofSize: 14.0)
        nameLabel.font = UIFont.systemFont(ofSize: 14.0)
        typeLabel.font = UIFont.systemFont(ofSize: 14.0)
        regionLabel.font = UIFont.systemFont(ofSize: 14.0)
        habitatLabel.font = UIFont.systemFont(ofSize: 14.0)
        
        infoLabelStackView.axis = .vertical
        infoLabelStackView.distribution = .fillEqually
        infoLabelStackView.alignment = .leading
        
        infoLabelStackView.addArrangedSubview(idLabel)
        infoLabelStackView.addArrangedSubview(nameLabel)
        infoLabelStackView.addArrangedSubview(typeLabel)
        infoLabelStackView.addArrangedSubview(regionLabel)
        infoLabelStackView.addArrangedSubview(habitatLabel)
        
        self.addSubview(infoLabelStackView)
        infoLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            infoLabelStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0),
            infoLabelStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10.0),
            infoLabelStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
            infoLabelStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10.0)
        ])
    }
    
    func setValues() {
        guard let masterPokemonDetails = self.viewModel?.masterPokemonDetails else {
            return
        }
        idLabel.text = "ID: \(masterPokemonDetails.pokemonDetails.id)"
        nameLabel.text = "NAME: \(masterPokemonDetails.pokemonDetails.name.capitalized)"
        if masterPokemonDetails.pokemonDetails.types.count > 1 {
            typeLabel.text = "TYPE: \(masterPokemonDetails.pokemonDetails.types[0].type.name.capitalized) \(masterPokemonDetails.pokemonDetails.types[1].type.name.capitalized)"
        } else {
            typeLabel.text = "TYPE: \(masterPokemonDetails.pokemonDetails.types[0].type.name.capitalized)"
        }
        regionLabel.text = "REGION: \(masterPokemonDetails.pokedexConfiguration.region.capitalized)"
        habitatLabel.text = "HABITAT: \(masterPokemonDetails.pokemonSpeciesDetails.habitat?.name.capitalized ?? "UNKNOWN")"
        Task {
            self.imageView.image = await self.viewModel?.generatePokemonImage()
        }
        
    }
}
