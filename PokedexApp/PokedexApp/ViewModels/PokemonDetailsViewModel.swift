//
//  PokemonDetailsViewModel.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 4/29/24.
//

import Foundation
import UIKit
import Dispatch

class PokemonDetailsViewModel {
    let dispatchGroup: DispatchGroup
    let networkService: NetworkService
    let configuration: PokedexConfiguration
    let pokemonId: Int
    
    var masterPokemonDetails: VMPokemon?
    var pokemonDetails: Pokemon?
    var pokemonError: Error?
    var pokemonSpeciesDetails: PSpecies?
    var pokemonSpeciesError: Error?
    
    init(networkService: NetworkService, configuration: PokedexConfiguration, pokemonId: Int) {
        self.networkService = networkService
        self.configuration = configuration
        self.pokemonId = pokemonId
        
        self.dispatchGroup = DispatchGroup()
    }
    
    func retrievePokemonDetails(completionHandler: @escaping (CompletionHandlerResponse) -> Void) {
        callPokemonAPI()
        callPokemonSpeciesAPI()
        
        dispatchGroup.notify(queue: .main) {
            guard let safePokemonDetails = self.pokemonDetails,
                  let safePokemonSpeciesDetails = self.pokemonSpeciesDetails,
                  self.pokemonError == nil,
                  self.pokemonSpeciesError == nil else {
                completionHandler(.failure)
                return
            }
            self.masterPokemonDetails = VMPokemon(pokemon: safePokemonDetails, pokemonSpecies: safePokemonSpeciesDetails, configuration: self.configuration)
            completionHandler(.success)
        }
    }
    
    func callPokemonAPI() {
        dispatchGroup.enter()
        networkService.callPokeAPI(with: .pokemon, by: pokemonId, startingId: nil, endingId: nil) { (result: Result<Pokemon, Error>) in
            switch result {
            case .success(let response):
                self.pokemonDetails = response
            case .failure(let errorResponse):
                self.pokemonError = errorResponse
            }
            self.dispatchGroup.leave()
        }
    }
    
    func callPokemonSpeciesAPI() {
        dispatchGroup.enter()
        networkService.callPokeAPI(with: .species, by: pokemonId, startingId: nil, endingId: nil) { (result: Result<PSpecies, Error>) in
            switch result {
            case .success(let response):
                self.pokemonSpeciesDetails = response
            case .failure(let errorResponse):
                self.pokemonSpeciesError = errorResponse
            }
            self.dispatchGroup.leave()
        }
    }
}

extension PokemonDetailsViewModel {
    func generatePokemonImage() async -> UIImage? {
        guard let imageUrl = self.masterPokemonDetails?.pokemonDetails.sprites.frontPokemonImageUrl else {
            return nil
        }
        
        do {
            let imageData = try await networkService.retrievePokemonImageData(using: imageUrl)
            guard let safeImageData = imageData, let pokemonImage = UIImage(data: safeImageData) else {
                return nil
            }
            return pokemonImage
        } catch {
            return nil
        }
    }
}
