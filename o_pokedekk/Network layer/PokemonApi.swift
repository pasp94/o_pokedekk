//
//  PokemonApi.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 16/11/20.

import Foundation

public enum HTTPMethod: String {
   case get    = "GET"
   case post   = "POST"
}

protocol EndpointType {
   var baseUrl:      URL { get }
   var path:         String { get }
   var httpMethod:   HTTPMethod { get }
   
   func buildURL() -> URL
}

enum PokemonApi<T> {
   case pokemonFirstPage
   case pokemonDetail(T)
}

extension PokemonApi: EndpointType {
   
   var basePath: String {
      return "https://pokeapi.co/api/v2/"
   }
   
   var baseUrl: URL {
      guard let url = URL(string: basePath) else { fatalError("ERROR: baseURL could not be configured") }
      return url
   }
   
   var path: String {
      switch self {
         case .pokemonFirstPage:
            return "pokemon/"
            
         case .pokemonDetail(let searchComponent):
            return "pokemon/\(searchComponent)/"
      }
   }
   
   var httpMethod: HTTPMethod {
      switch self {
         case .pokemonFirstPage,
              .pokemonDetail(_):
            return .get
      }
   }
   
   func buildURL() -> URL {
      return self.baseUrl.appendingPathComponent(self.path)
   }
}
