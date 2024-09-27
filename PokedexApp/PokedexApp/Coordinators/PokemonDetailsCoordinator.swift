//
//  PokemonDetailsCoordinator.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 4/29/24.
//

import Foundation
import UIKit

class PokemonDetailsCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var navigationController: UINavigationController
    let networkService: NetworkService
    
    var viewModel: PokemonDetailsViewModel
    let detailsView: PokemonDetailsView
    let descriptionView: PokemonDescriptionView
    var controller: PokemonDetailsViewController
    
    init(parentCoordinator: MainCoordinator, navigationController: UINavigationController, networkService: NetworkService, configuration: PokedexConfiguration, pokemonId: Int) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.networkService = networkService
        
        self.viewModel = PokemonDetailsViewModel(networkService: networkService, configuration: configuration, pokemonId: pokemonId)
        self.detailsView = PokemonDetailsView()
        self.descriptionView = PokemonDescriptionView()
        self.controller = PokemonDetailsViewController(viewModel: viewModel, detailsView: detailsView, descriptionView: descriptionView)
    }
    
    func start() {
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: false)
    }
    
    func goBackToPokemonList() {
        navigationController.popViewController(animated: false)
        parentCoordinator?.removeCoordinator()
    }
}
