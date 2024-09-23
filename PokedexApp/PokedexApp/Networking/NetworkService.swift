//
//  NetworkService.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/7/24.
//

import Foundation
import UIKit

struct NetworkService {
    
    var session: URLSession
    var decoder: JSONDecoder
    
    init(urlSession: URLSession, jsonDecoder: JSONDecoder) {
        self.session = urlSession
        self.decoder = jsonDecoder
    }
    
    func callPokeAPI<T: Codable>(with endpoint: Endpoint,
                                 by id: Int?,
                                 startingId: Int?,
                                 endingId: Int?,
                                 responseModel: T.Type) async throws -> T {
        let pokeAPIUrlString = generatePokeAPIUrl(with: endpoint, by: id, startingId: startingId, endingId: endingId)
        let pokeAPIUrl = URL(string: pokeAPIUrlString)
        guard let safePokeAPIUrl = pokeAPIUrl else {
            throw PokemonError.noPokeAPIUrl
        }
        var pokeAPIUrlRequest = URLRequest(url: safePokeAPIUrl)
        pokeAPIUrlRequest.httpMethod = HttpMethod.GET.rawValue
        
        var data: Data
        
        do {
            (data, _) = try await session.data(for: pokeAPIUrlRequest)
        } catch {
            throw PokemonError.pokeAPIResponseError(error: error)
        }
        
        do {
            let responseModel = try decoder.decode(T.self, from: data)
            return responseModel
        } catch {
            throw PokemonError.decodingError
        }
    }
    
    func retrievePokemonImageData(using pokemonImageUrlString: String) async throws -> Data? {
        let pokemonImageUrl = URL(string: pokemonImageUrlString)
        guard let safePokemonImageUrl = pokemonImageUrl else {
            throw URLError(.badServerResponse, userInfo: [:])
        }
        
        let (imageData, _) = try await session.data(from: safePokemonImageUrl)
        return imageData
    }
}

extension NetworkService {
    func generatePokeAPIUrl(with endpoint: Endpoint, by id: Int?, startingId: Int?, endingId: Int?) -> String {
        let pokeAPIUrlString = Constants.baseURL + UrlVersion.v2.value + endpoint.value
        guard let safeId = id else {
            guard let startingId = startingId, let endingId = endingId else { return "" }
            let offset = startingId - 1
            let limit = (offset == 0) ? endingId : endingId - offset
            return pokeAPIUrlString + "limit=\(limit)&offset=\(offset)"
        }
        return pokeAPIUrlString + "\(safeId)"
    }
}
