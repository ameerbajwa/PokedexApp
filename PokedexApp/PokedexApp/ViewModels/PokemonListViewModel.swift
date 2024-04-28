//
//  PokemonListViewModel.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 3/24/24.
//

import Foundation
import UIKit

class PokemonListViewModel {
    
    var networkService: NetworkService
    var generation: Int
    var pokemonList: VMPList?
    var pokemonListError: Error?
    
    init(networkService: NetworkService, generation: Int) {
        self.networkService = networkService
        self.generation = generation
    }
    
    func retrievePokemonList(completionHandler: @escaping (CompletionHandlerResponse) -> Void) {
        networkService.callPokeAPI(with: .generation, by: generation) { (result: Result<PGeneration, Error>) in
            switch result {
            case .success(let response):
                self.createVMPokemonList(with: response)
                completionHandler(.success)
            case .failure(let error):
                self.pokemonListError = error
                completionHandler(.failure)
            }
        }
    }
    
}

extension PokemonListViewModel {
    func createVMPokemonList(with pGeneration: PGeneration) {
        let proxyPokemonList = pGeneration.pokemonSpecies.map ({ (pokemon) -> VMPokemonInfo in
            let pokemonImageUrlString = generatePokemonImageUrl(using: pokemon.url)
            return VMPokemonInfo(name: pokemon.name, url: pokemon.url, imageUrl: pokemonImageUrlString)
        })
        pokemonList = VMPList(pokemon: proxyPokemonList)
    }
    
    func generatePokemonImageUrl(using pokemonUrl: String) -> String {
        let pokemonUrlComponents = pokemonUrl.components(separatedBy: "/")
        return Constants.spriteImageBaseURL + "/\(pokemonUrlComponents[pokemonUrlComponents.endIndex-2]).png"
    }
    
    func generatePokemonImage(using pokemonUrl: String) async -> UIImage? {
        do {
            let imageData = try await networkService.retrievePokemonImageData(using: pokemonUrl)
            guard let safeImageData = imageData, let pokemonImage = UIImage(data: safeImageData) else {
                print("could not obtain image data")
                return nil
            }
            return pokemonImage
        } catch {
            print(error)
            return nil
        }
    }
}
