//
//  PokedexTitleView.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 8/9/24.
//

import Foundation
import UIKit
import Combine

class PokedexTitleView: UIView {
    weak var viewModel: PokedexTitleViewModel?
    weak var controller: PokedexTitleViewController?
    private var cancellables: Set<AnyCancellable> = .init()
    
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var pokedexGenerationLabel: UILabel!
    var pokedexGenerationButton: UIButton!
    var pokedexGenerationStackView: UIStackView!
    var pokedexVersionLabel: UILabel!
    var pokedexVersionButton: UIButton!
    var pokedexVersionStackView: UIStackView!
    var continueButton: UIButton!
    
    func setupViews() {
        setupTitleLabel()
        setupDescriptionLabel()
        setupPokemonGenerationLabelButton()
        setupPokemonVersionLabelButton()
        setupContinueButton()
        
        subscribeToPokedexVersionSelection()
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 26.0)
        titleLabel.textAlignment = .center
        titleLabel.text = "Welcome to the Pokedex App"
        titleLabel.numberOfLines = 0
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20.0),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0),
        ])
    }
    
    func setupDescriptionLabel() {
        descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 18.0)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = "Please select a pokemon generation and pokemon version to view details on the corresponding pokemon from that region"
        
        self.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0)
        ])
    }
    
    func setupPokemonGenerationLabelButton() {
        pokedexGenerationLabel = UILabel()
        pokedexGenerationLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        pokedexGenerationLabel.textAlignment = .left
        pokedexGenerationLabel.text = "Pokemon Generation:"
        
        pokedexGenerationButton = UIButton(primaryAction: nil)
        guard let pokemonGenerationNames = viewModel?.pokemonGenerationNames else { return }
        pokedexGenerationButton.menu = UIMenu(options: .displayInline, children: pokemonGenerationNames)
        pokedexGenerationButton.showsMenuAsPrimaryAction = true
        pokedexGenerationButton.changesSelectionAsPrimaryAction = true
        
        pokedexGenerationStackView = UIStackView()
        pokedexGenerationStackView.axis = .horizontal
        pokedexGenerationStackView.spacing = 20.0
        pokedexGenerationStackView.distribution = .fillEqually
        
        pokedexGenerationStackView.addArrangedSubview(pokedexGenerationLabel)
        pokedexGenerationStackView.addArrangedSubview(pokedexGenerationButton)
        
        self.addSubview(pokedexGenerationStackView)
        pokedexGenerationStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokedexGenerationStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 50.0),
            pokedexGenerationStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25.0),
            pokedexGenerationStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25.0)
        ])
    }
    
    func setupPokemonVersionLabelButton() {
        pokedexVersionLabel = UILabel()
        pokedexVersionLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        pokedexVersionLabel.textAlignment = .left
        pokedexVersionLabel.text = "Pokemon Version:"
        
        pokedexVersionButton = UIButton(primaryAction: nil)
        guard let pokemonVersionNames = viewModel?.pokemonVersionNames else { return }
        pokedexVersionButton.menu = UIMenu(options: .displayInline, children: pokemonVersionNames)
        pokedexVersionButton.showsMenuAsPrimaryAction = true
        pokedexVersionButton.changesSelectionAsPrimaryAction = true
        
        pokedexVersionStackView = UIStackView()
        pokedexVersionStackView.axis = .horizontal
        pokedexVersionStackView.spacing = 20.0
        pokedexVersionStackView.distribution = .fillEqually
        
        pokedexVersionStackView.addArrangedSubview(pokedexVersionLabel)
        pokedexVersionStackView.addArrangedSubview(pokedexVersionButton)
        
        self.addSubview(pokedexVersionStackView)
        pokedexVersionStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokedexVersionStackView.topAnchor.constraint(equalTo: pokedexGenerationStackView.bottomAnchor, constant: 20.0),
            pokedexVersionStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25.0),
            pokedexVersionStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25.0)
        ])
    }
    
    func setupContinueButton() {
        continueButton = UIButton()
        continueButton.setTitle("Continue", for: .normal)
        continueButton.setTitleColor(.white, for: .focused)
        continueButton.backgroundColor = .black
        continueButton.layer.cornerRadius = 15.0
        continueButton.layer.masksToBounds = true
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        
        self.addSubview(continueButton)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            continueButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -45.0),
            continueButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30.0),
            continueButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30.0),
            continueButton.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }
    
    @objc
    func continueButtonTapped() {
        controller?.coordinateToPokedexList()
    }
}

extension PokedexTitleView {
    func subscribeToPokedexVersionSelection() {
        viewModel?.$pokemonVersionNames.sink { [unowned self] pokemonVersionNames in
            if let safePokemonVersionNames = pokemonVersionNames {
                DispatchQueue.main.async {
                    self.pokedexVersionButton.menu = UIMenu(options: .displayInline, children: safePokemonVersionNames)
                }
                
            }
        }
        .store(in: &cancellables)
    }
}
