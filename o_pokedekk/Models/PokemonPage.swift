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
   let results: [PokemonPageResult]?
}

struct PokemonPageResult: Codable {
   let name: String?
   let urlDetail: String?
   
   enum CodingKeys: String, CodingKey {
      case name
      case urlDetail = "url"
   }
}
