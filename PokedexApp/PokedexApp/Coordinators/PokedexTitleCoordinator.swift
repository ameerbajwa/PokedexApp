//
//  PokedexTitleCoordinator.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 8/9/24.
//

import Foundation
import UIKit

class PokedexTitleCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var navigationController: UINavigationController

    let networkService: NetworkService
    var controller: PokedexTitleViewController
        
    init(navigationController: UINavigationController, parentCoordinator: MainCoordinator, networkService: NetworkService) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.networkService = networkService
        
        let view = PokedexTitleView()
        let viewModel = PokedexTitleViewModel(networkService: networkService)
        self.controller = PokedexTitleViewController(viewModel: viewModel, pokedexSelectionView: view)
    }
    
    func start() {
        controller.coordinator = self
        self.navigationController.pushViewController(controller, animated: false)
    }
    
    func selectPokedex(configuration: PokedexConfiguration) {
        parentCoordinator?.createPokedexCoordinator(configuration: configuration)
    }
}
