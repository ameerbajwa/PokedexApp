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
    var networkService: NetworkService!
    
    var pokemonList: PList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.safeArea = view.layoutMarginsGuide
        
        pokedexTableView = UITableView()
        
        setupPokedexTable(table: pokedexTableView)

        networkService = NetworkService(urlSession: URLSession.shared,
                                        jsonDecoder: JSONDecoder())
        networkService.callPokeAPI(with: .pokemon, by: nil) { (result: Result<PList, Error>) in
            switch result {
            case .success(let response):
                self.pokemonList = response
                DispatchQueue.main.async {
                    self.pokedexTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setupPokedexTable(table: UITableView) {
        self.view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: safeArea.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: "pokemonCell")
        table.dataSource = self
    }
}

extension ViewController: UITableViewDataSource {
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

