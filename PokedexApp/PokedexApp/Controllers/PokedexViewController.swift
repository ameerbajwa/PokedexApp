//
//  PokedexViewController.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 3/5/24.
//

import Foundation
import UIKit

class PokedexViewController: UIViewController {
    
    weak var coordinator: PokedexCoordinator?
    var pokemonListViewModel: PokemonListViewModel
    
    var loadingView: LoadingView!
    var pokedexTableView: UITableView!
    var safeArea: UILayoutGuide!
    
    init(viewModel: PokemonListViewModel) {
        pokemonListViewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        loadingView = LoadingView()
        pokedexTableView = UITableView()
        
        self.view.backgroundColor = .white
        self.safeArea = view.layoutMarginsGuide
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func back() {
        self.coordinator?.goBackToPokedexGenerationList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "Pokemon Generation", style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = backButton
        
        DispatchQueue.main.async {
            self.loadingView.displayLoadingView(with: "Loading Pokemon", on: self.view)
        }
        
        pokemonListViewModel.retrievePokemonList { result in
            switch result {
            case .success:
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.setupPokedexTable()
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
        
        pokedexTableView.register(PokedexTableViewCell.self, forCellReuseIdentifier: "pokedexCell")
        pokedexTableView.dataSource = self
        pokedexTableView.delegate = self
    }
}

extension PokedexViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let pokemonCount = self.pokemonListViewModel.pokemonList?.pokemon.count else {
            return 1
        }
        return pokemonCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokedexCell = pokedexTableView.dequeueReusableCell(withIdentifier: "pokedexCell", for: indexPath) as? PokedexTableViewCell else {
            return UITableViewCell()
        }
        pokedexCell.pokemonListViewModel = pokemonListViewModel
        pokedexCell.setValues(for: indexPath.row)
        return pokedexCell
    }
}

extension PokedexViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemonId = pokemonListViewModel.calculatePokemonId(with: indexPath.row)
        coordinator?.selectPokemon(configuration: self.pokemonListViewModel.configuration, with: pokemonId)
    }
}
