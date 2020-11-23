//
//  PokemonDetailViewModel.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 22/11/20.
//

import Foundation
import UIKit

class PokemonDetailViewModel {
   
   var pokemon: Observable<Pokemon?> = Observable(nil)
   var detailImage: Observable<UIImage> = Observable(UIImage()) //use placeholder for image
   var detailURL: String?
   
   var apiManager: APIProvider?
   var appRouter: Router?

   init(detailUrl: String?, provider: APIProvider, router: Router) {
      self.apiManager = provider
      self.appRouter = router
      self.detailURL = detailUrl
   }
   
   func bindData(completion: @escaping () -> ()) {
      self.pokemon.bind { [weak self] newValue in
         completion()
         
         guard let strongSelf = self else { return }
         
         strongSelf.apiManager?.getImage(urlString: newValue?.sprites?.frontDefault, completion: { [weak self] (sprite, error) in
            guard let strongSelf = self else { return }
            
            guard error == nil,
                  let image = sprite
            else { return }
            
            strongSelf.detailImage.value = image
         })
      }
   }
   
   func bindDetailImage(completion: @escaping (UIImage) -> ()){
      self.detailImage.bind { newValue in
         completion(newValue)
      }
   }
   
   func getPokemonDetail() {
      apiManager?.getDetail(urlString: detailURL, decodingType: Pokemon.self, completion: { (pokemonDetail, error) in
         guard error == nil,
               let pokemonValue = pokemonDetail
         else { /*show message error in view*/return }
         
         self.pokemon.value = pokemonValue
      })
   }
}
