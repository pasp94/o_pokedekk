//
//  AbilityTableCellViewModel.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 29/11/20.
//

import Foundation
import UIKit

final class AbilityTableCellViewModel {
   
   var ability: PokemonAbility?
   
   init(pokemonAbility: PokemonAbility) {
      self.ability = pokemonAbility
   }
}

extension AbilityTableCellViewModel: TitledCellViewModelProtocol {
   var title: String {
      return ability?.name.capitalized ?? "Not defined"
   }
   
   var backgroundColor: UIColor {
      return .gray
   }
   
   func prepareCellForReuse() {
      ability = nil
   }
}
