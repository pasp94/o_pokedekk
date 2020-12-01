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
   case outdated
   case failed
   case noData
   case unableToDecode
}
