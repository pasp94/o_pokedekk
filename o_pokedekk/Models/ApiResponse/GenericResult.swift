//
//  GenericResult.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 24/11/20.
//

import Foundation

/// These sturct map a generic object of the API,
/// made by name and url
struct GenericResult: Codable, Hashable {
   let name: String
   let url: String
}
