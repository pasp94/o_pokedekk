//
//  PokemonListCell.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 19/11/20.
//

import UIKit

class PokemonListCell: UICollectionViewCell {
   
   public static var reuseIdentifier: String {
      return "pokemonListCell"
   }
   
   var name: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
      label.contentMode = .center
      return label
   }()
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      self.layer.cornerRadius = 15.0
      
      contentView.addSubview(name)
      NSLayoutConstraint.activate([
         name.topAnchor.constraint(equalTo: contentView.topAnchor),
         name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
         name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
      ])
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
