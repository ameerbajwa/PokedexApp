//
//  PokedexTitleViewController.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 8/9/24.
//

import Foundation
import UIKit

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
        self.viewModel.retrievePokemonSelectors { result in
            switch result {
            case .success:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.pokedexSelectionView.viewModel = self.viewModel
                    self.setupPokedexTitleView()
                }
            case .failure:
                print("error")
            }
        }
    }
    
    func setupPokedexTitleView() {
        pokedexSelectionView.setupViews()
        
        self.view.addSubview(pokedexSelectionView)
        pokedexSelectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokedexSelectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            pokedexSelectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            pokedexSelectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            pokedexSelectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        self.loadingView.dismissLoadingView()
    }
}

// MARK: - Coorindate Logic
extension PokedexTitleViewController {
    func coordinateToPokedexList() {
//        coordinator?.selectPokedex(configuration: viewModel.configuration)
    }
}
