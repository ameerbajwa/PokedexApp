//
//  PokemonGenerationViewModel.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 5/18/24.
//

import Foundation

class PokemonGenerationViewModel {
    
    var networkService: NetworkService
    var pokedexConfigurations: [Int: PokedexConfiguration]
    
    init(networkService: NetworkService) {
        self.networkService = networkService
        self.pokedexConfigurations = [:]
    }
    
    func retrievePokemonGenerations(completionHandler: @escaping (CompletionHandlerResponse) -> Void) {
        for generation in 1...8 {
            networkService.callPokeAPI(with: .generation, by: generation, startingId: nil, endingId: nil) { (result: Result<PGeneration, Error>) in
                switch result {
                case .success(let response):
                    self.handlePokemonGenerationResponse(with: response)
                    if self.pokedexConfigurations.count == 8 {
                        completionHandler(.success)
                    }
                case .failure(let error):
                    print(error)
                    completionHandler(.failure)
                }
            }
        }
    }
    
    func handlePokemonGenerationResponse(with pokemonGenerationResponse: PGeneration) {
        let pokedexConfigurationVersions = pokemonGenerationResponse.versionGroups.map { versionGroup in
            return versionGroup.name
        }
        let pokemonGenerationPokemonIdList = pokemonGenerationResponse.pokemonSpecies.map { pokemonSpecies in
            let pokemonId = pokemonSpecies.url.components(separatedBy: "/")
            guard let id = Int(pokemonId[pokemonId.endIndex-2]) else { return 0 }
            return id
        }
        let pokemonIds = retrieveStartingEndingPokemonIdFromList(with: pokemonGenerationPokemonIdList)
        let pokedexConfiguration = PokedexConfiguration(region: pokemonGenerationResponse.mainRegion.name, selectedGeneration: "1", selectedVersion: "red", startingPokemonId: pokemonIds.startingId, endingPokemonId: pokemonIds.endingId)
        pokedexConfigurations[pokemonGenerationResponse.id] = pokedexConfiguration
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
