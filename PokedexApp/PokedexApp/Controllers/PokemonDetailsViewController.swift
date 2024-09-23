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
    
    var safeArea: UILayoutGuide!
    
    init(viewModel: PokemonDetailsViewModel, detailsView: PokemonDetailsView) {
        self.pokemonDetailsViewModel = viewModel
        self.detailsView = detailsView
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
            await self.pokemonDetailsViewModel.retrievePokemonDetails()
            self.detailsView.viewModel = self.pokemonDetailsViewModel
            self.setupDetailsView()
        }
    }
    
    func setupDetailsView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.detailsView.setup()
            
            self.view.addSubview(self.detailsView)
            self.detailsView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                self.detailsView.topAnchor.constraint(equalTo: self.safeArea.topAnchor),
                self.detailsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.detailsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.detailsView.heightAnchor.constraint(equalToConstant: 170.0)
            ])
            
            self.detailsView.setValues()
            
            self.loadingView.dismissLoadingView()
        }
    }
}
