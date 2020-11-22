//
//  NetworkContstants.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 17/11/20.
//

import Foundation

enum Result<String> {
   case success
   case failure(String)
}

enum NetworkError: String {
   case authenticationError   = "You need to be authenticated first."
   case badRequest            = "Bad request!"
   case outdated              = "The url of your request is outdated."
   case failed                = "Network request failed."
   case noData                = "Response returned with no data to decode."
   case unableToDecode        = "Impossible to decode the response."
}
