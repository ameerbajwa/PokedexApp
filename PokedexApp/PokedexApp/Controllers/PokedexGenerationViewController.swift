//
//  PokedexGenerationViewController.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 3/30/24.
//

import Foundation
import UIKit

class PokedexGenerationViewController: UIViewController {
    
    weak var coordinator: PokedexGenerationCoordinator?
    let networkService: NetworkService
    
    var safeArea: UILayoutGuide!
    var pokedexGenerationView: PokedexGenerationView
    
    init(service: NetworkService, view: PokedexGenerationView) {
        self.networkService = service
        self.pokedexGenerationView = view
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = .white
        self.safeArea = self.view.layoutMarginsGuide
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.setupPokedexGenerationView()
        }
    }
    
    func setupPokedexGenerationView() {
        self.pokedexGenerationView.setupView()
        
        pokedexGenerationView.pokedexGenerationCollectionView.register(PokedexGenerationCollectionViewCell.self, forCellWithReuseIdentifier: "generationCell")
        pokedexGenerationView.pokedexGenerationCollectionView.delegate = self
        pokedexGenerationView.pokedexGenerationCollectionView.dataSource = self
        
        self.view.addSubview(pokedexGenerationView)
        pokedexGenerationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokedexGenerationView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            pokedexGenerationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pokedexGenerationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pokedexGenerationView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

extension PokedexGenerationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "generationCell", for: indexPath as IndexPath) as! PokedexGenerationCollectionViewCell
        cell.backgroundColor = .white
        cell.setupGenerationLabel(of: (indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected Generation \(indexPath.row + 1)")
        coordinator?.selectPokemonGeneration()
    }
}
