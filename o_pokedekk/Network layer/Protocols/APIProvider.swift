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
   
   /// Return a parsed Object for the generic type given
   func get<T: Codable>(urlString: String?, decodingType: T.Type, completion:@escaping (Result<T, Error>) -> Void)
   
   /// Returns an image for the given url resource
   func downloadImage(urlString: String?, completion:@escaping (Result<UIImage, Error>)-> Void)
   
   /// An helper method that check the response code
   func validate(_ response: HTTPURLResponse) -> Result<Void, Error>
}
