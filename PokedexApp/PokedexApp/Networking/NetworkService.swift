//
//  NetworkService.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/7/24.
//

import Foundation

struct NetworkService {
    
    var session: URLSession!
    var decoder: JSONDecoder!
    
    init(urlSession: URLSession, jsonDecoder: JSONDecoder) {
        self.session = urlSession
        self.decoder = jsonDecoder
    }
    
    func callPokeAPI(with endpoint: Endpoint,
                     by id: Int?,
                     for model: Codable,
                     completionHandler: @escaping (Result<Codable, Error>) -> Void) {
        let pokeAPIUrlString = generatePokeAPIUrl(with: endpoint, by: id)
        let pokeAPIUrl = URL(fileURLWithPath: pokeAPIUrlString)
        var pokeAPIUrlRequest = URLRequest(url: pokeAPIUrl)
        pokeAPIUrlRequest.httpMethod = HttpMethod.GET.rawValue
        
        let task = session.dataTask(with: pokeAPIUrlRequest) { pokeAPIData, pokeAPIUrlResponse, pokeAPIError in
            guard let safePokeAPIData = pokeAPIData, pokeAPIError == nil else {
                return
            }
            
            var responseModel = try decoder.decode(model.self, from: safePokeAPIData)
            completionHandler(.success(responseModel))
        }
        
        task.resume()
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
