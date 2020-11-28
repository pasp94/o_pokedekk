//
//  IconNameCellViewModel.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 27/11/20.
//

import Foundation
import UIKit

final class IconNameCellViewModel {
   
   var pokemon: Pokemon?
   
   var isLoaded: Observable<Bool> = Observable(false)
   var error: Observable<Error?> = Observable(nil)
   
   var urlResource: String
   
   var apiManager: PokemonProvider
   
   init(provider: PokemonProvider, resourcePath: String) {
      self.apiManager = provider
      self.urlResource = resourcePath
   }
}

extension IconNameCellViewModel: IconNameCellViewModelProtocol {
   
   var name: String {
      return pokemon?.name ?? "??????"
   }
   
   var icon: UIImage {
      return pokemon?.image ?? UIImage() //place-holder
   }
   
   
   func fetchViewData() {
      apiManager.getPokemon(urlString: urlResource) { [weak self](result) in
         
         guard let self = self else { return }
         
         switch result {
            case .success(let pokemon):
               self.pokemon = pokemon
               
               self.isLoaded.value = true
               break
            case .failure(let error):
               self.error.value = error
               break
         }
      }
   }
   
   func bindDataCell(completion: @escaping (_ isLoaded: Bool) -> ()) {
      self.isLoaded.bind { (isLoaded) in
         completion(isLoaded)
      }
   }
   
   func bindErrorCell(completion: @escaping (Error) -> ()) {
      self.error.bind { (error) in
         guard let error = error else { return }
         debugPrint(error.localizedDescription)
         completion(error)
      }
   }
   
   func prepareCellForReuse() {
      self.pokemon = nil
      self.error.value = nil
   }
}
