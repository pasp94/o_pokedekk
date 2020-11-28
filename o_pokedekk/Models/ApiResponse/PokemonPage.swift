//
//  PokemonPage.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 17/11/20.
//

import Foundation

struct PokemonPage: Codable {
   let count: Int?
   let next: String?
   let previous: String?
   let results: [GenericResult]?
}
