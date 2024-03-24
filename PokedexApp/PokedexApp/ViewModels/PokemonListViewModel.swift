//
//  PokemonListViewModel.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 3/24/24.
//

import Foundation

class PokemonListViewModel {
    
    var networkService: NetworkService
    var pokemonList: PList?
    var pokemonListError: Error?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func retrievePokemonList(completionHandler: @escaping (CompletionHandlerResponse) -> Void) {
        networkService.callPokeAPI(with: .pokemon, by: nil) { (result: Result<PList, Error>) in
            switch result {
            case .success(let response):
                self.pokemonList = response
                completionHandler(.success)
            case .failure(let error):
                self.pokemonListError = error
                completionHandler(.failure)
            }
        }
    }
    
}
