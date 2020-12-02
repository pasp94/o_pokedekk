//
//  PokemonListCell.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 19/11/20.
//

import Foundation
import UIKit


final class PokemonListCell: UICollectionViewCell {
   
   let pokemonNameLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
      label.adjustsFontSizeToFitWidth = true
      label.contentMode = .center
      label.textColor = Constants.lightTextColor
      
      return label
   }()
   
   let pokemonIconImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.contentMode = .scaleAspectFit
      imageView.backgroundColor = .clear
      
      return imageView
   }()
   
   let spinner: UIActivityIndicatorView = {
      let indicator = UIActivityIndicatorView(style: .whiteLarge)
      indicator.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
      indicator.translatesAutoresizingMaskIntoConstraints = false
      indicator.layer.cornerRadius = Constants.cellCorner
      
      return indicator
   }()
   
   var viewModel: IconNameCellViewModelProtocol?
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      
      contentView.layer.masksToBounds = true
      
      layer.cornerRadius = Constants.cellCorner
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOffset = CGSize(width: 0, height: 2.0)
      layer.shadowRadius = 2.0
      layer.shadowOpacity = 0.5
      layer.masksToBounds = false
      
      /// Add cell subviews to content view
      contentView.addSubview(pokemonNameLabel)
      contentView.addSubview(pokemonIconImageView)
      contentView.addSubview(spinner)
      
      /// _Costraint defination and activation_
      NSLayoutConstraint.activate([
         /// `pokemonNameLabel` costraint
         pokemonNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
         pokemonNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15.0),
         pokemonNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 15.0),
         pokemonNameLabel.heightAnchor.constraint(equalToConstant: contentView.bounds.height * 0.25),
         
         /// `pokemonIconImageView` costrain
         pokemonIconImageView.bottomAnchor.constraint(equalTo: pokemonNameLabel.topAnchor),
         pokemonIconImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
         pokemonIconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         pokemonIconImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         
         /// `Spinner` costrain
         spinner.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
         spinner.topAnchor.constraint(equalTo: contentView.topAnchor),
         spinner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         spinner.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      ])
      
   }
   
   override func prepareForReuse() {
      self.viewModel?.prepareCellForReuse()
      self.pokemonNameLabel.text = Constants.namePlaceholder
      self.pokemonIconImageView.image = Constants.iconPlaceholder
      self.backgroundColor = .clear
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}


extension PokemonListCell: ConfigurableCell {
   func setViewModel<T>(_ viewModel: T) {
      self.viewModel = viewModel as? IconNameCellViewModelProtocol
      self.viewModel?.bindDataCell(completion: { [weak self] (viewIsLoaded) in
         
         guard let self = self else { return }
         
         if viewIsLoaded {
            DispatchQueue.main.async {
               self.pokemonNameLabel.text = self.viewModel?.name.uppercased()
               self.pokemonIconImageView.image = self.viewModel?.icon
               self.backgroundColor = self.viewModel?.backgroundColor
               self.spinner.stopAnimating()
            }
         } else {
            DispatchQueue.main.async {
               self.pokemonNameLabel.text = Constants.namePlaceholder
               self.pokemonIconImageView.image = Constants.iconPlaceholder
               self.backgroundColor = .gray
               self.spinner.startAnimating()
            }
         }
      })
      
      self.viewModel?.bindErrorCell(completion: { [weak self] (_) in
         
         guard let self = self else { return }
         DispatchQueue.main.async {
            self.spinner.stopAnimating()
         }
      })
      
      self.viewModel?.fetchViewData()
   }
}
