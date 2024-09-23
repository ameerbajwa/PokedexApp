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
    
    var pokemonGenerations: [Int: PGeneration]?
    var pokemonVersions: [Int: [String]]?
    
    var selectedPokemonGeneration: Int = 1
    var selectedPokemonVersion: String?
    var pokemonGenerationNames: [UIMenuElement]?
    @Published var pokemonVersionNames: [UIMenuElement]?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func retrievePokemonSelectors() async {
        await withTaskGroup(of: Bool.self, returning: Void.self) { taskGroup in
            taskGroup.addTask {
                return await self.retrievePokemonGenerations()
            }
            taskGroup.addTask {
                return await self.retrievePokemonVersions()
            }
            
            var results = [Bool]()
            for await result in taskGroup {
                results.append(result)
            }
            
            if results[0] && results[1] {
                self.changePokemonVersionSelections()
            }
        }
    }
    
    func retrievePokemonGenerations() async -> Bool {
        for genId in 1...8 {
            do {
                let response = try await networkService.callPokeAPI(with: .generation, by: genId, startingId: nil, endingId: nil, responseModel: PGeneration.self)
                self.handlePokemonGenerationResponse(generation: genId, response: response)
            } catch {
                print("Calling PokeAPI by generation \(genId) error")
            }
        }
        
        return (self.pokemonGenerations?.count == 8) ? true : false
    }
    
    func retrievePokemonVersions() async -> Bool {
        for versionId in 1...20 {
            do {
                let response = try await networkService.callPokeAPI(with: .versionGroup, by: versionId, startingId: nil, endingId: nil, responseModel: PVersion.self)
                self.handlePokemonVersionGroupResponse(response: response)
            } catch {
                print("Calling PokeAPI by version \(versionId) error")
            }
        }
        
        return (self.pokemonVersions?.count == 8) ? true : false
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
            if selectedPokemonVersion == nil, self.pokemonVersions?.count == 1 {
                selectedPokemonVersion = version.name
            }
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

// MARK: - Generate Pokedex Configuration
extension PokedexTitleViewModel {
    func generatePokedexConfiguration() -> PokedexConfiguration? {
        guard let pokemonGeneration = pokemonGenerations?[selectedPokemonGeneration], let pokemonVersion = selectedPokemonVersion else {
            return nil
        }

        let pokemonGenerationPokemonIdList = pokemonGeneration.pokemonSpecies.map { pokemonSpecies in
            let pokemonId = pokemonSpecies.url.components(separatedBy: "/")
            guard let id = Int(pokemonId[pokemonId.endIndex-2]) else { return 0 }
            return id
        }
        let pokemonIds = retrieveStartingEndingPokemonIdFromList(with: pokemonGenerationPokemonIdList)
        return PokedexConfiguration(region: pokemonGeneration.mainRegion.name, selectedGeneration: String(pokemonGeneration.id), selectedVersion: pokemonVersion, startingPokemonId: pokemonIds.startingId, endingPokemonId: pokemonIds.endingId)
    }
    
    func retrieveStartingEndingPokemonIdFromList(with pokemonIdList: [Int]) -> (startingId: Int, endingId: Int) {
        var startingId: Int = pokemonIdList[0]
        var endingId: Int = pokemonIdList[0]
        for id in pokemonIdList {
            if startingId > id {
                startingId = id
            }
            if endingId < id {
                endingId = id
            }
        }
        
        return (startingId, endingId)
    }
}
