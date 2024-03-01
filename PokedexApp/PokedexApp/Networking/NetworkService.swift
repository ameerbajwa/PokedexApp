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
    
    func callPokeAPI<T: Codable>(with endpoint: Endpoint,
                                 by id: Int?,
                                 completionHandler: @escaping (Result<T, Error>) -> Void) {
        let pokeAPIUrlString = generatePokeAPIUrl(with: endpoint, by: id)
        let pokeAPIUrl = URL(string: pokeAPIUrlString)
        guard let safePokeAPIUrl = pokeAPIUrl else {
            return
        }
        var pokeAPIUrlRequest = URLRequest(url: safePokeAPIUrl)
        pokeAPIUrlRequest.httpMethod = HttpMethod.GET.rawValue
        
        session.dataTask(with: pokeAPIUrlRequest) { (pokeAPIData, pokeAPIUrlResponse, pokeAPIError) in
            guard let safePokeAPIData = pokeAPIData, pokeAPIError == nil else {
                completionHandler(.failure(pokeAPIError!))
                return
            }
            
            do {
                let responseModel = try decoder.decode(T.self, from: safePokeAPIData)
                completionHandler(.success(responseModel))
            } catch {
                print("error: \(error)")
            }
        }.resume()
        
    }
}

extension NetworkService {
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
