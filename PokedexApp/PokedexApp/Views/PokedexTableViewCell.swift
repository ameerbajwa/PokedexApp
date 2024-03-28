//
//  PokedexTableViewCell.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 3/26/24.
//

import Foundation
import UIKit

class PokedexTableViewCell: UITableViewCell {
    
    var pokemonNameLabel = UILabel()
    var pokemonImageView = UIImageView()
    
    var pokemonListViewModel: PokemonListViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setPokemonImageView()
        setPokemonNameLabel()
    }
    
    func setPokemonImageView() {
        addSubview(pokemonImageView)
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokemonImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0),
            pokemonImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 80.0),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 80.0)
        ])
    }
    
    func setPokemonNameLabel() {
        pokemonNameLabel.font = .boldSystemFont(ofSize: 14)
        
        addSubview(pokemonNameLabel)
        pokemonNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokemonNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pokemonNameLabel.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: 10.0)
        ])
    }
}

extension PokedexTableViewCell {
    func setValues(for row: Int) {
        self.pokemonNameLabel.text = self.pokemonListViewModel?.pokemonList?.pokemon[row].name
        guard let pokemonImageUrl = self.pokemonListViewModel?.pokemonList?.pokemon[row].imageUrl else {
            return
        }
        Task {
            self.pokemonImageView.image = await self.pokemonListViewModel?.generatePokemonImage(using: pokemonImageUrl)
        }
    }
}
