//
//  PokedexTitleViewModel.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 8/9/24.
//

import Foundation
import Dispatch
import UIKit
import Combine

class PokedexTitleViewModel {
    var networkService: NetworkService
    let dispatchGroup: DispatchGroup
    
    var pokemonGenerations: [Int: PGeneration]?
    var pokemonVersions: [Int: [String]]?
    var pokedexConfiguration: PokedexConfiguration?
    
    var selectedPokemonGeneration: Int = 1
    var selectedPokemonVersion: String?
    var pokemonGenerationNames: [UIMenuElement]?
    @Published var pokemonVersionNames: [UIMenuElement]?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        
        self.dispatchGroup = DispatchGroup()
    }
    
    func retrievePokemonSelectors(completionHandler: @escaping (CompletionHandlerResponse) -> Void) {
        retrievePokemonGenerations()
        retrievePokemonVersions()
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let safePokemonGenerations = self?.pokemonGenerations,
                  let safePokemonVersions = self?.pokemonVersions else {
                completionHandler(.failure)
                return
            }
            self?.changePokemonVersionSelections()
            completionHandler(.success)
        }
    }
    
    func retrievePokemonGenerations() {
        let selectedPokemonGenerationAction = { (action: UIAction) in
            self.selectedPokemonGeneration = Int(action.title) ?? 1
            self.changePokemonVersionSelections()
        }
        
        for genId in 1...8 {
            dispatchGroup.enter()
            networkService.callPokeAPI(with: .generation, by: genId, startingId: nil, endingId: nil) { (result: Result<PGeneration, Error>) in
                switch result {
                case .success(let response):
                    self.pokemonGenerationNames?.append(UIAction(title: "\(response.id)", handler: selectedPokemonGenerationAction))
                    self.pokemonGenerations?[genId] = response
                case .failure(let error):
                    print("error")
                }
            }
            self.dispatchGroup.leave()
        }
        
    }
    
    func retrievePokemonVersions() {
        for versionId in 1...20 {
            dispatchGroup.enter()
            networkService.callPokeAPI(with: .versionGroup, by: versionId, startingId: nil, endingId: nil) { (result: Result<PVersion, Error>) in
                switch result {
                case .success(let response):
                    let pokemonGenerationUrlComponents = response.generation.url.components(separatedBy: "/")
                    guard let generationId = Int(pokemonGenerationUrlComponents[pokemonGenerationUrlComponents.endIndex-2]) else { return }
                    for version in response.versions {
                        self.pokemonVersions?[generationId]?.append(version.name)
                    }
                case .failure(let error):
                    print("error")
                }
            }
            self.dispatchGroup.leave()
        }
    }
    
    func changePokemonVersionSelections() {
        let selectedPokemonVersionAction = { (action: UIAction) in
            self.selectedPokemonVersion = action.title
        }
        
        guard let safePokemonVersionNames = self.pokemonVersions?[self.selectedPokemonGeneration] else {  return }
        for pokemonVersionName in safePokemonVersionNames {
            self.pokemonVersionNames?.append(UIAction(title: pokemonVersionName, handler: selectedPokemonVersionAction))
        }
    }
}
