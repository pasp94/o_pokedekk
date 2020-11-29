//
//  Pokemon.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 16/11/20.
//

import Foundation
import UIKit

/// This is the real Model of the whole app.
struct Pokemon {
   let id: Int
   let name: String
   let image: UIImage
   let weight: Double
   let height: Double
   let types: [PokemonTypeElement]
   let abilities: [PokemonAbility]
   let stats: [PokemonStat]
}

struct PokemonTypeElement {
   let slot: Int
   let name: String
   let color: ElementColor
}

struct PokemonAbility {
   let slot: Int
   let name: String
}

struct PokemonStat {
   let baseStat: Int
   let name: String
}


extension PokemonTypeElement {
   enum ElementColor: String {
      case normal       = "normal"
      case fighting     = "fighting"
      case flying       = "flying"
      case poison       = "poison"
      case ground       = "ground"
      case rock         = "rock"
      case bug          = "bug"
      case ghost        = "ghost"
      case steel        = "steel"
      case fire         = "fire"
      case water        = "water"
      case grass        = "grass"
      case electric     = "electric"
      case psychic      = "psychic"
      case ice          = "ice"
      case dragon       = "dragon"
      case dark         = "dark"
      case fairy        = "fairy"
      case unknown      = "unknown"
      case shadow       = "shadow"
   }
}


extension PokemonTypeElement.ElementColor {
   var uiColor: UIColor {
      switch self {
         case .normal:
            return UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1)
         case .fighting:
            return UIColor(red: 147/255, green: 10/255, blue: 22/255, alpha: 1)
         case .flying:
            return UIColor(red: 135/255, green: 143/255, blue: 231/255, alpha: 1)
         case .poison:
            return UIColor(red: 139/255, green: 0/255, blue: 255/255, alpha: 1)
         case .ground:
            return UIColor(red: 79/255, green: 52/255, blue: 27/255, alpha: 1)
         case .rock:
            return UIColor(red: 169/255, green: 78/255, blue: 44/255, alpha: 1)
         case .bug:
            return UIColor(red: 166/255, green: 139/255, blue: 21/255, alpha: 1)
         case .ghost:
            return UIColor(red: 105/255, green: 109/255, blue: 114/255, alpha: 1)
         case .steel:
            return UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1)
         case .fire:
            return UIColor(red: 255/255, green: 119/255, blue: 0/255, alpha: 1)
         case .water:
            return UIColor(red: 33/255, green: 207/255, blue: 197/255, alpha: 1)
         case .grass:
            return UIColor(red: 118/255, green: 216/255, blue: 28/255, alpha: 1)
         case .electric:
            return UIColor(red: 252/255, green: 227/255, blue: 0/255, alpha: 1)
         case .psychic:
            return UIColor(red: 214/255, green: 0/255, blue: 175/255, alpha: 1)
         case .ice:
            return UIColor(red: 146/255, green: 190/255, blue: 226/255, alpha: 1)
         case .dragon:
            return UIColor(red: 235/255, green: 10/255, blue: 10/255, alpha: 1)
         case .dark:
            return UIColor(red: 33/255, green: 33/255, blue: 55/255, alpha: 1)
         case .fairy:
            return UIColor(red: 197/255, green: 52/255, blue: 217/255, alpha: 1)
         case .unknown:
            return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
         case .shadow:
            return UIColor(red: 194/255, green: 194/255, blue: 194/255, alpha: 1)
      }
   }
   
}
