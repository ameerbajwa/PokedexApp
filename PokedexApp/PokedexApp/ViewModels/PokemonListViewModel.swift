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
    
    func retrievePokemonList() async {
        await withTaskGroup(of: PList?.self) { taskGroup in
            taskGroup.addTask {
                do {
                    return try await self.networkService.callPokeAPI(with: .pokemonList, by: nil, startingId: self.configuration.startingPokemonId, endingId: self.configuration.endingPokemonId, responseModel: PList.self)
                } catch {
                    self.pokemonListError = error
                    print(error.localizedDescription)
                    return nil
                }
            }
            
            for await result in taskGroup {
                if let safePList = result {
                    self.createVMPokemonList(with: safePList)
                    self.generatePokemonImagesOnList()
                }
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
                print("could not unwrap and load image data")
                return nil
            }
            return pokemonImage
        } catch {
            print(error)
            return nil
        }
    }
}

extension PokemonListViewModel {
    func generatePokemonImagesOnList() {
        guard let pokemon = pokemonList?.pokemon else {
            return
        }
        for pokemonInfo in pokemon {
            Task {
                pokemonInfo.image = await generatePokemonImage(using: pokemonInfo.imageUrl)
            }
        }
    }
}

extension PokemonListViewModel {
    func calculatePokemonId(with row: Int) -> Int {
        return (configuration.startingPokemonId + row)
    }
}
