//
//  PokedexTableViewCell.swift
//  PokedexApp
//
//  Created by Ameer Bajwa on 3/26/24.
//

import Foundation
import UIKit

class PokedexTableViewCell: UITableViewCell {
    
    var pokemonNameLabel: UILabel!
    var pokemonImageView: UIImageView!
    var pokeballImageView: UIImageView!
    
    var pokemonListViewModel: PokemonListViewModel!
    
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
        setPokemonNameLabel()
        setPokemonImageView()
        setPokeballImageView()
    }
    
    func setPokemonImageView() {
        addSubview(pokemonImageView)
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokemonImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0),
            pokemonImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 80.0),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 80.0)
        ])
    }
    
    func setPokemonNameLabel() {
        addSubview(pokemonNameLabel)
        pokemonNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokemonNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pokemonNameLabel.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: 10.0)
        ])
    }
    
    func setPokeballImageView() {
        addSubview(pokeballImageView)
        pokeballImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokeballImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pokeballImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20.0),
            pokeballImageView.widthAnchor.constraint(equalToConstant: 30.0),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 30.0)
        ])
    }
    
}
