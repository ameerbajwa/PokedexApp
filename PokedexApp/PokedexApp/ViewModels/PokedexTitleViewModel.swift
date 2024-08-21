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
    weak var controller: PokedexTitleViewController?
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
        dispatchGroup.enter()
        
        for genId in 1...8 {
            networkService.callPokeAPI(with: .generation, by: genId, startingId: nil, endingId: nil) { (result: Result<PGeneration, Error>) in
                switch result {
                case .success(let response):
                    self.handlePokemonGenerationResponse(generation: genId, response: response)
                case .failure(let error):
                    print("Calling PokeAPI by generation \(genId) error")
                }
                if genId == 8 {
                    self.dispatchGroup.leave()
                }
            }
        }
    }
    
    func retrievePokemonVersions() {
        dispatchGroup.enter()
        for versionId in 1...20 {
            networkService.callPokeAPI(with: .versionGroup, by: versionId, startingId: nil, endingId: nil) { (result: Result<PVersion, Error>) in
                switch result {
                case .success(let response):
                    self.handlePokemonVersionGroupResponse(response: response)
                case .failure(let error):
                    print("Calling PokeAPI by version \(versionId) error")
                }
                if versionId == 20 {
                    self.dispatchGroup.leave()
                }
            }
        }
    }
    
    func handlePokemonGenerationResponse(generation: Int, response: PGeneration) {
        let selectedPokemonGenerationAction = { (action: UIAction) in
            self.selectedPokemonGeneration = Int(action.title) ?? 1
            self.changePokemonVersionSelections()
        }
        
        if self.pokemonGenerationNames != nil {
            self.pokemonGenerationNames?.append(UIAction(title: "\(response.id)", handler: selectedPokemonGenerationAction))
        } else {
            self.pokemonGenerationNames = [UIAction(title: "\(response.id)", handler: selectedPokemonGenerationAction)]
        }
        
        if self.pokemonGenerations != nil {
            self.pokemonGenerations?[generation] = response
        } else {
            self.pokemonGenerations = [generation: response]
        }
    }
    
    func handlePokemonVersionGroupResponse(response: PVersion) {
        let pokemonGenerationUrlComponents = response.generation.url.components(separatedBy: "/")
        guard let generationId = Int(pokemonGenerationUrlComponents[pokemonGenerationUrlComponents.endIndex-2]) else {
            return
        }
        if self.pokemonVersions == nil {
            self.pokemonVersions = [generationId: []]
        } else if self.pokemonVersions?[generationId] == nil {
            self.pokemonVersions?[generationId] = []
        }
        for version in response.versions {
            self.pokemonVersions?[generationId]?.append(version.name)
        }
    }
    
    func changePokemonVersionSelections() {
        let selectedPokemonVersionAction = { (action: UIAction) in
            self.selectedPokemonVersion = action.title
        }
        
        guard let safePokemonVersionNames = self.pokemonVersions?[self.selectedPokemonGeneration] else {
            return
        }
        var pokemonVersionSelections: [UIMenuElement] = []
        for pokemonVersionName in safePokemonVersionNames {
            pokemonVersionSelections.append(UIAction(title: pokemonVersionName, handler: selectedPokemonVersionAction))
        }
        self.pokemonVersionNames = pokemonVersionSelections
    }
}