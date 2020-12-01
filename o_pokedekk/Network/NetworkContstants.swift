//
//  NetworkContstants.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 17/11/20.
//

import Foundation

enum NetworkError: Error {
   case authenticationError
   case badURL
   case failed
   case noData
   case unableToDecode
}

extension NetworkError: LocalizedError {
   var errorDescription: String? {
      switch self {
         case .authenticationError:    return "You must be authenticated!!!"
         case .badURL:                 return "The URL is incorrect or not valid"
         case .failed:                 return "Generic error occurred! Check device connectivity."
         case .noData:                 return "No data found in response."
         case .unableToDecode:         return "Unable to decode data recieved"
      }
   }
}
