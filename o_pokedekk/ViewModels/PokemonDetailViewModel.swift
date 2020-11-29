//
//  PokemonDetailViewModel.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 22/11/20.
//

import Foundation
import UIKit

final class PokemonDetailViewModel {
   
   var pokemon: Observable<Pokemon?> = Observable(nil)
   var detailImage: Observable<UIImage> = Observable(UIImage()) //use placeholder for image
   
   var error: Observable<Error?> = Observable(nil)
   
   var detailURL: String?
   
   var apiManager: PokemonProvider
   var appRouter: Router

   init(detailUrl: String?, provider: PokemonProvider, router: Router) {
      self.apiManager = provider
      self.appRouter = router
      self.detailURL = detailUrl
   }
}

extension PokemonDetailViewModel: PokemonDetailViewModelProtocol {
   
   var name: String {
      return pokemon.value?.name ?? "??????"
   }
   
   var icon: UIImage {
      return pokemon.value?.image ?? UIImage() //place-holder
   }
   
   var weight: String {
      guard let weight = pokemon.value?.weight else { return "N/A" }
      return "\(weight) lb"
   }
   
   var height: String {
      guard let height = pokemon.value?.height else { return "N/A" }
      return "\(height) ft"
   }
   
   var typeColor: UIColor {
      guard let pokemon = pokemon.value else { return .clear }
      return pokemon.types.first?.color.uiColor ?? .clear
   }
   
   var numberOfTypeElement: Int {
      return pokemon.value?.types.count ?? 0
   }
   
   var numberOfSectionForStats: Int {
      return 2
   }
   
   func getItemsForStatsSection(section: Int) -> Int {
      switch section {
         case StatsSection.abilities.rawValue:
            return pokemon.value?.abilities.count ?? 0
            
         case StatsSection.baseStats.rawValue:
            return pokemon.value?.stats.count ?? 0
            
         default:
            return 0
      }
   }
   
   
   func fetchDetailInfo() {
      guard let url = detailURL else {
         error.value = NetworkError.badURL
         return
      }
      
      apiManager.getPokemon(urlString: url) { [weak self] (result) in
         guard let self = self else { return }
         
         switch result {
            case .success(let pokemon):
               self.pokemon.value = pokemon
               break
            case .failure(let error):
               self.error.value = error
               break
         }
      }
   }
   
   func bindDetailData(completion: @escaping () -> ()) {
      pokemon.bind { (_) in
         completion()
      }
   }
   
   func bindError(completion: @escaping (Error) -> ()) {
      error.bind { (error) in
         guard let error = error else { return }
         
         completion(error)
      }
   }
   
   func bindCellOfDetail<CELL>(_ cell: CELL, for indexPath: IndexPath) where CELL : ConfigurableCell {
      if let cell = cell as? TypeElementCell {
         guard let element = pokemon.value?.types[indexPath.row] else { return }
         let viewModel = TypeElementCellViewModel(pokemonElement: element)
         
         cell.setViewModel(viewModel)
      
      } else if let cell = cell as? AbilityTableCell {
         guard let ability = pokemon.value?.abilities[indexPath.row] else { return }
         let viewModel = AbilityTableCellViewModel(pokemonAbility: ability)
         
         cell.setViewModel(viewModel)
      
      } else if let cell = cell as? BaseStatCell {
         guard let stats = pokemon.value?.stats[indexPath.row] else { return }
         let viewModel = BaseStatCellViewModel(pokemonStat: stats)
         
         cell.setViewModel(viewModel)
      }
   }
   
}
