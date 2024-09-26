//
//  PokemonDetailsViewController.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 4/29/24.
//

import Foundation
import UIKit

class PokemonDetailsViewController: UIViewController {
    
    weak var coordinator: PokemonDetailsCoordinator?
    var pokemonDetailsViewModel: PokemonDetailsViewModel
    
    var loadingView: LoadingView!
    var detailsView: PokemonDetailsView
    var descriptionView: PokemonDescriptionView
    
    var safeArea: UILayoutGuide!
    
    init(viewModel: PokemonDetailsViewModel, detailsView: PokemonDetailsView, descriptionView: PokemonDescriptionView) {
        self.pokemonDetailsViewModel = viewModel
        self.detailsView = detailsView
        self.descriptionView = descriptionView
        super.init(nibName: nil, bundle: nil)
        
        loadingView = LoadingView()
        self.view.backgroundColor = .white
        self.safeArea = view.layoutMarginsGuide
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func back(sender: UIBarButtonItem) {
        self.coordinator?.goBackToPokemonList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "Pokemon List", style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = backButton
        
        DispatchQueue.main.async {
            self.loadingView.displayLoadingView(with: "Loading Pokemon Details", on: self.view)
        }
        
        Task {
            do {
                try await self.pokemonDetailsViewModel.retrievePokemonDetails()
                self.setupDetailsView()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func setupDetailsView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.detailsView.viewModel = self.pokemonDetailsViewModel
            self.descriptionView.viewModel = self.pokemonDetailsViewModel
            self.detailsView.setup()
            self.descriptionView.setupLabels()
            
            self.descriptionView.layer.borderColor = UIColor.black.cgColor
            self.descriptionView.layer.borderWidth = 2.5
            
            self.view.addSubview(self.detailsView)
            self.view.addSubview(self.descriptionView)
            self.detailsView.translatesAutoresizingMaskIntoConstraints = false
            self.descriptionView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                self.detailsView.topAnchor.constraint(equalTo: self.safeArea.topAnchor),
                self.detailsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.detailsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.detailsView.heightAnchor.constraint(equalToConstant: 170.0),
                self.descriptionView.topAnchor.constraint(equalTo: self.detailsView.bottomAnchor, constant: 15.0),
                self.descriptionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10.0),
                self.descriptionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10.0),
                self.descriptionView.heightAnchor.constraint(equalToConstant: 80.0)
            ])
            
            self.detailsView.setValues()
            self.descriptionView.setupDescriptionValue()
            
            self.loadingView.dismissLoadingView()
        }
    }
}
