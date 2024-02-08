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
    
}
