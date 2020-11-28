//
//  PokemonListCell.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 19/11/20.
//

import Foundation
import UIKit


class PokemonListCell: UICollectionViewCell {
   
   let pokemonNameLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
      label.adjustsFontSizeToFitWidth = true
      label.contentMode = .left
      return label
   }()
   
   let pokemonIconImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.contentMode = .scaleAspectFit
      imageView.backgroundColor = .gray
      
      return imageView
   }()
   
   var viewModel: IconNameCellViewModelProtocol?
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      layer.masksToBounds = true
      layer.cornerRadius = 15
      layer.shadowColor = UIColor.darkGray.cgColor
      layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
      layer.borderWidth = 2.0
      layer.borderColor = UIColor.darkGray.cgColor
      
      /// Add cell subviews to content view
      contentView.addSubview(pokemonNameLabel)
      contentView.addSubview(pokemonIconImageView)
      
      /// _Costraint defination and activation_
      NSLayoutConstraint.activate([
         /// `NameLabel` costraint
         pokemonNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
         pokemonNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0),
         pokemonNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 15.0),
         pokemonNameLabel.heightAnchor.constraint(equalToConstant: contentView.bounds.height * 0.25),
         
         /// `IconImage` costrain
         pokemonIconImageView.bottomAnchor.constraint(equalTo: pokemonNameLabel.topAnchor),
         pokemonIconImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
         pokemonIconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         pokemonIconImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      ])
      
   }
   
   override func prepareForReuse() {
      self.viewModel?.prepareCellForReuse()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}


extension PokemonListCell: ConfigurableCell {
   func setViewModel(_ viewModel: IconNameCellViewModelProtocol) {
      
      self.viewModel = viewModel
      self.viewModel?.bindDataCell(completion: { [weak self] (viewIsLoaded) in
         
         guard let self = self else { return }
         
         if viewIsLoaded {
            DispatchQueue.main.async {
               self.pokemonNameLabel.text = self.viewModel?.name.uppercased()
               self.pokemonIconImageView.image = self.viewModel?.icon
            }
         }
      })
      
      self.viewModel?.fetchViewData()
      
   }
}
