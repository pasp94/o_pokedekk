//
//  PokemonPage.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 17/11/20.
//

import Foundation

/// This sturct maps the response of http request
/// https://pokeapi.co/api/v2/pokemon/?offset={page_index}&limit={number_of_objects}
struct PokemonPage: Codable {
   let count: Int?
   let next: String?
   let previous: String?
   let results: [GenericResult]?
}
