//
//  APIProvider.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 20/11/20.
//

import Foundation
import UIKit


protocol APIProvider: class {
   /// It will use to make dataTasks
   var session: URLSession { get }
   
   /// Return a parsed Object for the given type that is conforme to Codable Protocol
   /// - Parameters:
   ///   - `urlString`: the string rappresenting the resource absolute path
   func get<T: Codable>(urlString: String?, decodingType: T.Type, completion:@escaping (Result<T, Error>) -> Void)
   
   /// Returns an image for the given url resource
   /// - Parameters:
   ///   - `urlString`: the string rappresenting the resource absolute path
   func downloadImage(urlString: String?, completion:@escaping (Result<UIImage, Error>)-> Void)
   
   /// An helper method that check the response status code
   /// - Parameters:
   ///   - `response`: the HTTPURLResponse on which is checked the status code
   func validate(_ response: HTTPURLResponse) -> Result<Void, Error>
}
