//
//  PokemonDetailViewController.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 22/11/20.
//

import UIKit

class PokemonDetailViewController: BaseViewController {
   
   var pokemonImageView: UIImageView = {
      let view = UIImageView()
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
   }()
   
   var detailViewModel: PokemonDetailViewModel
   
   init(viewModel: PokemonDetailViewModel) {
      self.detailViewModel = viewModel
      super.init()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      if #available(iOS 13.0, *) {
         self.overrideUserInterfaceStyle = .light
      } else {
         // Fallback on earlier versions
      }
      self.view.backgroundColor = .white
      
      loadImageView()
      
      detailViewModel.bindDetailImage { (sprite) in
         DispatchQueue.main.async {
            self.pokemonImageView.image = sprite
         }
      }
      
      detailViewModel.bindData {
         debugPrint("MODEL LOADED")
      }
      
      
      detailViewModel.getPokemonDetail()
   }
   
   func loadImageView() {
      self.view.addSubview(pokemonImageView)
      NSLayoutConstraint.activate([
         pokemonImageView.widthAnchor.constraint(equalToConstant: view.bounds.width/3),
         pokemonImageView.heightAnchor.constraint(equalToConstant: view.bounds.width/3),
         pokemonImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
         pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
      ])
   }
}
