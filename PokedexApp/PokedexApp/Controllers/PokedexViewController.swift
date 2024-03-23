//
//  PokedexViewController.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 3/5/24.
//

import Foundation
import UIKit

class PokedexViewController: UIViewController {
    
    var loadingView: LoadingView!
    
    var pokedexTableView: UITableView!
    var safeArea: UILayoutGuide!
    var networkService: NetworkService!
    
    var pokemonList: PList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView = LoadingView()
        pokedexTableView = UITableView()
        
        self.view.backgroundColor = .white
        self.safeArea = view.layoutMarginsGuide
        
        DispatchQueue.main.async {
            self.loadingView.displayLoadingView(with: "Loading", on: self.view)
        }
        
        setupPokedexTable()

        networkService = NetworkService(urlSession: URLSession.shared,
                                        jsonDecoder: JSONDecoder())
        networkService.callPokeAPI(with: .pokemon, by: nil) { (result: Result<PList, Error>) in
            switch result {
            case .success(let response):
                self.pokemonList = response
                DispatchQueue.main.async {
                    self.pokedexTableView.reloadData()
                    self.loadingView.dismissLoadingView()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setupPokedexTable() {
        self.view.addSubview(pokedexTableView)
        pokedexTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pokedexTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            pokedexTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokedexTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pokedexTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        pokedexTableView.register(UITableViewCell.self, forCellReuseIdentifier: "pokemonCell")
        pokedexTableView.dataSource = self
    }
}

extension PokedexViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let pokemonCount = self.pokemonList?.results.count else {
            return 10
        }
        return pokemonCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokemonList = pokemonList else {
            return UITableViewCell()
        }
        let pokemonCell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
        pokemonCell.textLabel?.text = pokemonList.results[indexPath.row].name
        return pokemonCell
    }
}
