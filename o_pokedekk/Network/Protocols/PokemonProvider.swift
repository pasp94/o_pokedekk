//
//  PokemonProvider.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 26/11/20.
//

import Foundation

/// Extension of APIProvider protocol, the class that implement its
/// has the method to fetch the Models required for the app
protocol PokemonProvider: APIProvider {
   
   /// Return a `PokemonPage` object for the given url string
   /// - Parameters:
   ///   - `urlString`: the string rappresenting the url absolute path already built
   ///                  with all query parameters
   func getPokemonPage(fromUrl: String, completion: @escaping (Result<PokemonPage, Error>) -> ())
   
   /// Build the url for the request using `fromPageNumber` and `pokemonPerPage`
   /// and return a `PokemonPage` object for it
   /// - Parameters:
   ///   - `fromPageNumber`: the starting index for the pokemons fetch operation
   ///   - `pokemonPerPage`: the number of pokemons to fetch
   func getPokemonPage(fromPageNumber: Int, pokemonPerPage: Int, completion: @escaping (Result<PokemonPage, Error>) -> ())
   
   /// Get the `PokemonDetail` information and parse it in a `Pokemon` object
   /// using the give url
   /// - Parameters:
   ///   - `urlString`: the string rappresenting the url absolute path for the pokemon detail
   func getPokemon(urlString: String, completion: @escaping (Result<Pokemon, Error>) -> ())
   
   /// Clean the cache memory implemented
   func flushCacheMemory()
}
