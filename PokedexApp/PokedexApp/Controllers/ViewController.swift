//
//  ViewController.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 2/7/24.
//

import UIKit

class ViewController: UIViewController {
    
    var pokedexTableView: UITableView!
    var safeArea: UILayoutGuide!
//    var networkService: NetworkService!
    
//    var pokemonList: PList?
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
//        self.safeArea = view.layoutMarginsGuide
        
//        pokedexTableView = UITableView()
        
//        setupPokedexTable()

//        networkService = NetworkService(urlSession: URLSession.shared,
//                                        jsonDecoder: JSONDecoder())
//        networkService.callPokeAPI(with: .pokemon, by: nil) { (result: Result<PList, Error>) in
//            switch result {
//            case .success(let response):
//                self.pokemonList = response
//                DispatchQueue.main.async {
//                    self.pokedexTableView.reloadData()
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
    func setupPokedexTable() {
        self.view.addSubview(pokedexTableView)
        pokedexTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pokedexTableView.topAnchor.constraint(equalTo: self.safeArea.topAnchor),
            pokedexTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            pokedexTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            pokedexTableView.bottomAnchor.constraint(equalTo: self.safeArea.bottomAnchor)
        ])
        
//        pokedexTableView.register(UITableViewCell.self, forCellReuseIdentifier: "pokemonCell")
//        pokedexTableView.dataSource = self
    }
}

