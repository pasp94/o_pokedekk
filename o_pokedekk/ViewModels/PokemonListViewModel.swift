//
//  PokemonListViewModel.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 16/11/20.
//

import Foundation

class PokemonListViewModel {
   
   var nextPage: String?
   var previousPage: String?
   
   ///Contain the list of Pokemon's name (used as data source)
   var pokemonList: Observable<[PokemonPageResult]> = Observable([])
   
   var apiManager: APIProvider?
   var appRouter: Router?

   init(provider: APIProvider, router: Router) {
      self.apiManager = provider
      self.appRouter = router
   }
   
   func bindData(completion: @escaping () -> ()){
      self.pokemonList.bind { (_) in
         completion()
      }
   }
   
   
   func fetchNextPokemons() {
      apiManager?.getPage(urlString: nextPage, decodingType: PokemonPage.self, completion: {[weak self] (newPokemoPage, error) in
         
         guard let strongSelf = self else { return }
         
         if error != nil {
            ///messaggio di error e fermo l'esecuzione
            return
         }
         
         strongSelf.nextPage = newPokemoPage?.next
         strongSelf.previousPage = newPokemoPage?.previous
   
         guard let pokemons = newPokemoPage?.results  else { return }
         strongSelf.pokemonList.value.append(contentsOf: pokemons)
      })
   }
   
   func showPokemonDetail(index: Int) {
      let pokemonSelected = pokemonList.value[index].urlDetail
      
      appRouter?.goForward(to: "detail", with: ["detailUrl": pokemonSelected as Any])
   }
}
