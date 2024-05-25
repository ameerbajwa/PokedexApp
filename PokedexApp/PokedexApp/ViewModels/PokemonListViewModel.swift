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
    var configuration: PokedexConfiguration
    var pokemonList: VMPList?
    var pokemonListError: Error?
    
    init(networkService: NetworkService, configuration: PokedexConfiguration) {
        self.networkService = networkService
        self.configuration = configuration
    }
    
    func retrievePokemonList(completionHandler: @escaping (CompletionHandlerResponse) -> Void) {
        networkService.callPokeAPI(with: .pokemonList, by: nil, startingId: configuration.startingPokemonId, endingId: configuration.endingPokemonId) { (result: Result<PList, Error>) in
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
    func createVMPokemonList(with pGeneration: PList) {
        let proxyPokemonList = pGeneration.results.map ({ (pokemon) -> VMPokemonInfo in
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
