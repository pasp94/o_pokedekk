//
//  TypeElementCellViewModel.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 29/11/20.
//

import Foundation
import UIKit

final class TypeElementCellViewModel {
   
   var element: PokemonTypeElement?
   
   init(pokemonElement: PokemonTypeElement) {
      self.element = pokemonElement
   }
}

extension TypeElementCellViewModel : TitledCellViewModelProtocol {
   var title: String {
      return element?.name ?? ""
   }
   var backgroundColor: UIColor {
      return element?.color.uiColor ?? PokemonTypeElement.ElementColor.unknown.uiColor
   }
   
   func prepareCellForReuse() {
      self.element = nil
   }
}
