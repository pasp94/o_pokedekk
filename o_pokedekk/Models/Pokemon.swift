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
    let types: [PokemonTypeElement]
    let locationAreaEncounters: String
    let abilities: [PokemonAbility]
    let stats: [PokemonStat]
}

struct PokemonTypeElement: Decodable {
   let slot: Int
   let name: String
}

struct PokemonAbility {
   let slot: Int
   let name: String
}

struct PokemonStat {
   let baseStat: Int
   let name: String
}
