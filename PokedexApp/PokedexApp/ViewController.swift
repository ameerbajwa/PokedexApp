//
//  ViewController.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/7/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        let networkService = NetworkService(urlSession: URLSession.shared,
                                            jsonDecoder: JSONDecoder())
        networkService.callPokeAPI(with: .pokemon, by: 1) { (result: Result<Pokemon, Error>) in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }


}

