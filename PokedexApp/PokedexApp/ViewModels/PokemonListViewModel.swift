//
//  PokemonListViewModel.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 3/24/24.
//

import Foundation

class PokemonListViewModel {
    
    var networkService: NetworkService
    var pokemonList: VMPList?
    var pokemonListError: Error?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func retrievePokemonList(completionHandler: @escaping (CompletionHandlerResponse) -> Void) {
        networkService.callPokeAPI(with: .pokemon, by: nil) { (result: Result<PList, Error>) in
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
    func createVMPokemonList(with pList: PList) {
//        var proxyPokemonList: [VMPokemonInfo] = []
        let proxyPokemonList = pList.results.map ({ (pokemon) -> VMPokemonInfo in
            return VMPokemonInfo(name: pokemon.name, imageUrl: generatePokemonImageUrl(using: pokemon.url))
        })
//        pList.results.forEach { pokemon in
//            var proxyPokemon: VMPokemonInfo = VMPokemonInfo(name: pokemon.name, imageUrl: generatePokemonImageUrl(using: pokemon.url))
//            proxyPokemonList.append(proxyPokemon)
//        }
        pokemonList?.pokemon = pList.results.map ({ (pokemon) -> VMPokemonInfo in
            return VMPokemonInfo(name: pokemon.name, imageUrl: generatePokemonImageUrl(using: pokemon.url))
        })
//        pokemonList = VMPList(pokemon: proxyPokemonList)
    }
    
    func generatePokemonImageUrl(using pokemonUrl: String) -> String {
        let pokemonUrlComponents = pokemonUrl.components(separatedBy: "/")
        return Constants.spriteImageBaseURL + "/\(pokemonUrlComponents[pokemonUrlComponents.endIndex-2]).png"
    }
}
