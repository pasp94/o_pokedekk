//
//  PokemonApi.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 16/11/20.

import Foundation

protocol EndpointType {
   var baseUrl:      String { get }
   var path:         String { get }
   
   func buildURL()throws -> String
}

/// Allows to build the corrects urls releated to this app
enum PokemonApi<T> {
   case pokemonPage(index: T? = nil, offset:T? = nil)
   case pokemonDetail(_ searchKey: T)
}

extension PokemonApi: EndpointType {
   
   var baseUrl: String { return "https://pokeapi.co/api/v2/" }
   
   var path: String {
      switch self {
         case .pokemonPage(_, _):
            return "pokemon"
            
         case .pokemonDetail(let searchComponent):
            return "pokemon/\(searchComponent)/"
      }
   }
   
   func buildURL()throws -> String {
      switch self {
         case .pokemonPage(let offset, let limit):
            var queryItems = [URLQueryItem]()
            if let offset = offset, let limit = limit {
               queryItems.append(URLQueryItem(name: "offset", value: "\(offset)"))
               queryItems.append(URLQueryItem(name: "limit", value: "\(limit)"))
            }
            
            let uri = baseUrl.appending(path)
            var components = URLComponents(string: uri)
            components?.queryItems = queryItems
            
            guard let url = components?.url else { throw NetworkError.badURL }
            
            return url.absoluteString
            
         case .pokemonDetail(_):
            return baseUrl.appending(path)
      }
   }
}
