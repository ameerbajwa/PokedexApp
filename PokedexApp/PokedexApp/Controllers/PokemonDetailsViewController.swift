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
    
    var detailsView: PokemonDetailsView
    
    var safeArea: UILayoutGuide!
    
    init(viewModel: PokemonDetailsViewModel, detailsView: PokemonDetailsView) {
        self.pokemonDetailsViewModel = viewModel
        self.detailsView = detailsView
        super.init(nibName: nil, bundle: nil)
        
        self.safeArea = view.layoutMarginsGuide
        
        self.pokemonDetailsViewModel.retrievePokemonDetails { result in
            switch result {
            case .success:
                self.detailsView.viewModel = self.pokemonDetailsViewModel
                self.detailsView.setValues()
            case .failure:
                print("Error")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.setupDetailsView()
        }
    }
    
    func setupDetailsView() {
        self.detailsView.setup()
        
        self.view.addSubview(detailsView)
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailsView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailsView.heightAnchor.constraint(equalToConstant: 170.0)
        ])
    }
}
