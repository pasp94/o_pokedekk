//
//  PokemonListViewModel.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 16/11/20.
//

import Foundation
import UIKit /// da rimuovere

final class PokemonListViewModel {
   var numberOfItems: Int {
      return pokemonList.value.count
   }
   
   ///Contain the list of Pokemon's name (used as data source)
   var pokemonList: Observable<[GenericResult]> = Observable([])
   var error: Observable<Error?> = Observable(nil)
   
   var apiManager:   PokemonProvider
   var appRouter:    Router
   
   var nextPageURL: String?

   init(provider: PokemonProvider, router: Router) {
      self.apiManager = provider
      self.appRouter = router
   }
   
   private func fetchMorePokemons(from index: Int) {
      apiManager.getPokemonPage(fromPageNumber: index, pokemonPerPage: Constants.pokemonPerPage, completion: { [weak self] (result) in
         guard let self = self else { return }
         
         switch result {
            case .success(let newPokemonPage):
               self.nextPageURL  = newPokemonPage.next
               guard let results = newPokemonPage.results else { return }
               //remove replicate before
               self.pokemonList.value.append(contentsOf: results)
               break
               
            case .failure(let error):
               self.error.value = error
               break
         }
      })
   }
   
   private func fetchMorePokemons(from url: String) {
      apiManager.getPokemonPage(fromUrl: url, completion: { [weak self] (result) in
         guard let self = self else { return }
         
         switch result {
            case .success(let newPokemonPage):
               self.nextPageURL  = newPokemonPage.next
               guard let results = newPokemonPage.results else { return }
               //remove replicate before
               self.pokemonList.value.append(contentsOf: results)
               break
               
            case .failure(let error):
               self.error.value = error
               break
         }
      })
   }
}


extension PokemonListViewModel: ListViewModel {
   func bindDataList(completion: @escaping () -> ()) {
      self.pokemonList.bind { (_) in
         completion()
      }
   }
   
   func bindError(completion: @escaping (Error) -> ()) {
//      self.error.bind { (value) in
//         completion(value)
//      }
   }
   
   func initList() {
      apiManager.flushCacheMemory()
      pokemonList.value.removeAll()
      fetchMorePokemons(from: 0)
   }
   
   func bindDataCell<CELL>(cell: CELL, at indexPath: IndexPath) where CELL: ConfigurableCell {
      let pokemon = self.pokemonList.value[indexPath.row]
      
      
      if let cell = cell as? PokemonListCell {
         let viewModel = PokemonListCellViewModel(provider: apiManager, resourcePath: pokemon.url)
         cell.setViewModel(viewModel)
      }
   }
   
   func displayMoreObjects(from index: Int) {
      if AppUtil.isIPhone {
         if let url = nextPageURL {
            fetchMorePokemons(from: url)
         } else {
            fetchMorePokemons(from: index)
         }
      } else {
         fetchMorePokemons(from: index)
      }
   }
   
   func didSelectCell(at indexPath: IndexPath) {
      let pokemonSelected = pokemonList.value[indexPath.row].url
      appRouter.goForward(to: "detail", with: ["detailUrl": pokemonSelected as Any])
   }
   
}
