//
//  PokedexTitleViewController.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 8/9/24.
//

import Foundation
import UIKit
import Combine

class PokedexTitleViewController: UIViewController {
    weak var coordinator: PokedexTitleCoordinator?
    var viewModel: PokedexTitleViewModel
    var pokedexSelectionView: PokedexTitleView
    
    var loadingView: LoadingView!
    var safeArea: UILayoutGuide!
    
    
    init(viewModel: PokedexTitleViewModel, pokedexSelectionView: PokedexTitleView) {
        self.viewModel = viewModel
        self.pokedexSelectionView = pokedexSelectionView
        super.init(nibName: nil, bundle: nil)
        
        self.pokedexSelectionView.controller = self
        loadingView = LoadingView()
        self.view.backgroundColor = .white
        self.safeArea = self.view.layoutMarginsGuide
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.loadingView.displayLoadingView(with: "Loading Pokedex", on: self.view)
        }
        
        Task {
            do {
                try await self.viewModel.generatePokemonGenerationSelectors()
                try await self.viewModel.generatePokemonVersionSelectors()
            } catch {
                print(error.localizedDescription)
            }
            
            guard let _ = self.viewModel.pokemonGenerations,
                    let _ = self.viewModel.pokemonVersions else {
                return
            }
            
            self.viewModel.changePokemonVersionSelections()
            self.setupPokedexTitleView()
        }
    }
    
    func setupPokedexTitleView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.pokedexSelectionView.viewModel = self.viewModel
            self.pokedexSelectionView.setupViews()
            
            self.view.addSubview(self.pokedexSelectionView)
            self.pokedexSelectionView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                self.pokedexSelectionView.topAnchor.constraint(equalTo: self.safeArea.topAnchor),
                self.pokedexSelectionView.leadingAnchor.constraint(equalTo: self.safeArea.leadingAnchor),
                self.pokedexSelectionView.trailingAnchor.constraint(equalTo: self.safeArea.trailingAnchor),
                self.pokedexSelectionView.bottomAnchor.constraint(equalTo: self.safeArea.bottomAnchor)
            ])
            
            self.loadingView.dismissLoadingView()
        }
    }
}

// MARK: - Coorindate Logic
extension PokedexTitleViewController {
    func coordinateToPokedexList() {
        guard let configuration = viewModel.generatePokedexConfiguration() else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.coordinator?.selectPokedex(configuration: configuration)
        }
    }
}
