//
//  BaseStatCellViewModel.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 29/11/20.
//

import Foundation

final class BaseStatCellViewModel {
   
   var stat: PokemonStat?
   
   init(pokemonStat: PokemonStat) {
      self.stat = pokemonStat
   }
}

extension BaseStatCellViewModel: ProgressLevelCellViewModelProtocol {
   var name: String {
      return stat?.name ?? ""
   }
   
   var levelPercentage: Double {
      return Double(stat?.baseStat ?? 0) / 300.0
   }
   
   func prepareCellForReuse() {
      self.stat = nil
   }
}
