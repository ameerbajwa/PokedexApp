//
//  PokedexGenerationCoordinator.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 4/10/24.
//

import Foundation
import UIKit

class PokedexGenerationCoordinator: Coordinator {
    weak var parentCoordinator: MainCoordinator?
    var navigationController: UINavigationController

    let networkService: NetworkService
    var controller: PokedexGenerationViewController
        
    init(navigationController: UINavigationController, parentCoordinator: MainCoordinator) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        
        let session = URLSession.shared
        let decoder = JSONDecoder()
        self.networkService = NetworkService(urlSession: session, jsonDecoder: decoder)
        
        let view = PokedexGenerationView()
        self.controller = PokedexGenerationViewController(service: networkService, view: view)
    }
    
    func start() {
        controller.coordinator = self
        self.navigationController.pushViewController(controller, animated: false)
    }
    
    func selectPokemonGeneration(generation: Int) {
        parentCoordinator?.createPokedexCoordinator(generation: generation)
    }
}
