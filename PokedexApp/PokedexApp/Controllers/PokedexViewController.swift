//
//  PokedexViewController.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 3/5/24.
//

import Foundation
import UIKit

class PokedexViewController: UIViewController {
    
    var pokemonListViewModel: PokemonListViewModel
    
    var loadingView: LoadingView!
    var pokedexTableView: UITableView!
    var safeArea: UILayoutGuide!
    
    init(service networkService: NetworkService) {
        self.pokemonListViewModel = PokemonListViewModel(networkService: networkService)
        super.init(nibName: nil, bundle: nil)
        
        loadingView = LoadingView()
        pokedexTableView = UITableView()
        
        self.view.backgroundColor = .white
        self.safeArea = view.layoutMarginsGuide
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.loadingView.displayLoadingView(with: "Loading Pokemon", on: self.view)
            self.setupPokedexTable()
        }
        
        pokemonListViewModel.retrievePokemonList { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.pokedexTableView.reloadData()
                    self.loadingView.dismissLoadingView()
                }
            case .failure:
                print(self.pokemonListViewModel.pokemonListError?.localizedDescription ?? "Error")
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
            pokedexTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        pokedexTableView.register(UITableViewCell.self, forCellReuseIdentifier: "pokemonCell")
        pokedexTableView.dataSource = self
        pokedexTableView.delegate = self
    }
}

extension PokedexViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let pokemonCount = self.pokemonListViewModel.pokemonList?.results.count else {
            return 10
        }
        return pokemonCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokemonList = pokemonListViewModel.pokemonList else {
            return UITableViewCell()
        }
        let pokemonCell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)
        pokemonCell.textLabel?.text = pokemonList.results[indexPath.row].name
        return pokemonCell
    }
}

extension PokedexViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(self.pokemonListViewModel.pokemonList?.results[indexPath.row].spriteUrl ?? "No Url")
    }
}
