//
//  PokemonProvider.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 26/11/20.
//

import Foundation

protocol PokemonProvider {
   /// Da commentare
   func getPokemonPage(fromUrl: String, completion: @escaping (Result<PokemonPage, Error>) -> ())
   
   func getPokemonPage(fromPageNumber: Int, pokemonPerPage: Int, completion: @escaping (Result<PokemonPage, Error>) -> ())
   
   func getPokemon(urlString: String, completion: @escaping (Result<Pokemon, Error>) -> ())
   
   func flushCacheMemory()
}
