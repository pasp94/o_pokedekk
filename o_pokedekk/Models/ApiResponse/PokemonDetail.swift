//
//  PokemonDetail.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 24/11/20.
//

import Foundation
import UIKit

/// These sturct map the response of pokemon detail request
/// The informations decode or encoded don't rappresent the whole response
/// (It's parsed only what we need for this app)
struct PokemonDetail: Codable {
   let id: Int
   let name: String
   let sprites: Sprites
   let weight: Double
   let height: Double
   let types: [TypeElement]
   let abilities: [Ability]
   let stats: [Stat]
   
   func toPokemon(withSprite image: UIImage) -> Pokemon {
      let types      = self.types.map { PokemonTypeElement(slot: $0.slot, name: $0.name, color: PokemonTypeElement.ElementColor(rawValue: $0.name) ?? .unknown) }
      let abilities  = self.abilities.map { PokemonAbility(slot: $0.slot, name: $0.name) }
      let stats      = self.stats.map { PokemonStat(baseStat: $0.baseStat, name: $0.name) }
      
      return Pokemon(id: id,
                     name: name,
                     image: image,
                     weight: weight,
                     height: height,
                     types: types,
                     abilities: abilities,
                     stats: stats)
   }
   
   enum CodingKeys: String, CodingKey {
      case id, name, sprites, weight, height, types, abilities, stats
   }
   
}

struct Sprites: Codable {
   
   let frontDefaultUrl: String
   
   enum CodingKeys: String, CodingKey {
      case frontDefaultUrl = "front_default"
   }
}

struct Ability: Codable {
   var name: String { abilityResource.name }
   var url: String { abilityResource.url }
   
   private let abilityResource: GenericResult
   
   
   let slot: Int
   
   enum CodingKeys: String, CodingKey {
      case slot
      case abilityResource = "ability"
   }
}

struct TypeElement: Codable {
   let slot: Int
   private let type: GenericResult
   
   var name: String { type.name }
}

struct Stat: Codable {
   let baseStat: Int
   var name: String { stat.name }
   private let stat: GenericResult
   
   enum CodingKeys: String, CodingKey {
      case stat
      case baseStat = "base_stat"
   }
}

