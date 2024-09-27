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
    
    func retrievePokemonDetails() async throws {
        try await withThrowingTaskGroup(of: PokemonSuperClass?.self, returning: Void.self) { taskGroup in
            taskGroup.addTask {
                return try await self.callPokemonAPI()
            }
            taskGroup.addTask {
                return try await self.callPokemonSpeciesAPI()
            }
            
            for try await response in taskGroup {
                guard let safePokemonDetails = self.pokemonDetails,
                      let safePokemonSpeciesDetails = self.pokemonSpeciesDetails,
                      self.pokemonError == nil,
                      self.pokemonSpeciesError == nil else {
                    continue
                }
                self.masterPokemonDetails = VMPokemon(pokemon: safePokemonDetails, pokemonSpecies: safePokemonSpeciesDetails, configuration: self.configuration)
            }
        }
    }
    
    func callPokemonAPI() async throws -> Pokemon? {
        do {
            self.pokemonDetails = try await networkService.callPokeAPI(with: .pokemon, by: pokemonId, startingId: nil, endingId: nil, responseModel: Pokemon.self)
            return self.pokemonDetails
        } catch {
            self.pokemonError = error
            print(error.localizedDescription)
            return nil
        }
    }
    
    func callPokemonSpeciesAPI() async throws -> PSpecies? {
        do {
            self.pokemonSpeciesDetails = try await networkService.callPokeAPI(with: .species, by: pokemonId, startingId: nil, endingId: nil, responseModel: PSpecies.self)
            return self.pokemonSpeciesDetails
        } catch {
            self.pokemonSpeciesError = error
            print(error.localizedDescription)
            return nil
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

extension PokemonDetailsViewModel {
    func retrievePokemonDescription() -> String? {
        guard let pokemonDescriptions = self.masterPokemonDetails?.pokemonSpeciesDetails.flavorTextEntries else {
            return nil
        }
        
        let englishPokemonDescriptions = pokemonDescriptions.filter { pokemonDescription in
            return pokemonDescription.language.name == "en" ? true : false
        }
        
        for pokemonDescription in englishPokemonDescriptions {
            if pokemonDescription.version.name == configuration.selectedVersion {
                return pokemonDescription.flavorText.replacingOccurrences(of: "\n", with: " ")
            }
        }
        
        return nil
    }
}
