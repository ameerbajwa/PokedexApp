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
    
    func retrievePokemonDetails() async {
        await withTaskGroup(of: Bool.self, returning: Void.self) { taskGroup in
            taskGroup.addTask {
                return await self.callPokemonAPI()
            }
            taskGroup.addTask {
                return await self.callPokemonSpeciesAPI()
            }
            
            var results = [Bool]()
            for await result in taskGroup {
                results.append(result)
            }
            
            if results[0] && results[1] {
                guard let safePokemonDetails = self.pokemonDetails,
                      let safePokemonSpeciesDetails = self.pokemonSpeciesDetails,
                      self.pokemonError == nil,
                      self.pokemonSpeciesError == nil else {
                    return
                }
                self.masterPokemonDetails = VMPokemon(pokemon: safePokemonDetails, pokemonSpecies: safePokemonSpeciesDetails, configuration: self.configuration)
            }
        }
    }
    
    func callPokemonAPI() async -> Bool {
        do {
            self.pokemonDetails = try await networkService.callPokeAPI(with: .pokemon, by: pokemonId, startingId: nil, endingId: nil, responseModel: Pokemon.self)
            return true
        } catch {
            self.pokemonError = error
            print(error.localizedDescription)
            return false
        }
    }
    
    func callPokemonSpeciesAPI() async -> Bool {
        do {
            self.pokemonSpeciesDetails = try await networkService.callPokeAPI(with: .species, by: pokemonId, startingId: nil, endingId: nil, responseModel: PSpecies.self)
            return true
        } catch {
            self.pokemonSpeciesError = error
            print(error.localizedDescription)
            return false
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
