//
//  PokedexGenerationCoordinator.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 4/10/24.
//

import Foundation
import UIKit

class PokedexGenerationCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController
    let networkService: NetworkService
    
    var pokedexGenerationViewController: PokedexGenerationViewController?
    var pokedexCoordinator: PokedexCoordinator?
    
    init() {
        navigationController = UINavigationController()
        
        let session = URLSession.shared
        let decoder = JSONDecoder()
        
        self.networkService = NetworkService(urlSession: session, jsonDecoder: decoder)
        
    }
    
    func start() {
        let pokedexGenerationView = PokedexGenerationView()
        self.pokedexGenerationViewController = PokedexGenerationViewController(service: networkService, view: pokedexGenerationView)
        guard let safePokedexGenerationVC = pokedexGenerationViewController else { return }
        navigationController.viewControllers = [safePokedexGenerationVC]
    }
    
    func finish() {
        self.pokedexCoordinator = PokedexCoordinator(service: networkService)
    }
    
}
