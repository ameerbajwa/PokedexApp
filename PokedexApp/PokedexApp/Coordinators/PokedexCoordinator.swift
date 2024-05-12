//
//  PokedexCoordinator.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 4/11/24.
//

import Foundation
import UIKit

class PokedexCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var navigationController: UINavigationController
    let networkService: NetworkService
    var viewModel: PokemonListViewModel
    var controller: PokedexViewController
    
    init(parentCoordinator: MainCoordinator, service: NetworkService, navigationController: UINavigationController, generation: Int) {
        self.parentCoordinator = parentCoordinator
        self.networkService = service
        self.navigationController = navigationController
        
        self.viewModel = PokemonListViewModel(networkService: networkService, generation: generation)
        self.controller = PokedexViewController(viewModel: viewModel)
    }
    
    func start() {
        controller.coordinator = self
        navigationController.pushViewController(controller, animated: false)
    }
    
    func selectPokemon(at id: Int) {
        parentCoordinator?.createPokemonDetailsCoordinator(pokemonId: id)
    }
    
}
