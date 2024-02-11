//
//  NetworkService.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/7/24.
//

import Foundation

struct NetworkService {
    
    var session: URLSession!
    
    init(urlSession: URLSession) {
        self.session = urlSession
    }
    
    func callPokeAPI(with endpoint: Endpoint, by id: Int?) {
        let pokeAPIUrlString = generatePokeAPIUrl(with: endpoint, by: id)
        let pokeAPIUrl = URL(fileURLWithPath: pokeAPIUrlString)
        var pokeAPIUrlRequest = URLRequest(url: pokeAPIUrl)
        pokeAPIUrlRequest.httpMethod = HttpMethod.GET.rawValue
        
//        let task = session.dataTask(with: pokeAPIUrlRequest) { pokeAPIData, pokeAPIUrlResponse, pokeAPIError in
//            <#code#>
//        }
        
//        task.resume()
    }
    
    func generatePokeAPIUrl(with endpoint: Endpoint, by id: Int?) -> String {
        var pokeAPIUrl = Constants.baseURL + UrlVersion.v2.value + endpoint.value
        guard let safeId = id else {
            pokeAPIUrl += Constants.firstGenerationPokemonListParameter
            return pokeAPIUrl
        }
        pokeAPIUrl += "\(safeId)"
        return pokeAPIUrl
    }
}
