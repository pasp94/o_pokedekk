//
//  APIProvider.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 20/11/20.
//

import Foundation
import UIKit

protocol APIProvider: class {
   
   var session: URLSession { get }
   
   func getPage<T: Codable>(urlString: String?, decodingType: T.Type, completion:@escaping (T?, Error?) -> Void)
   func getDetail<T: Codable>(urlString: String?, decodingType: T.Type, completion:@escaping (T?, Error?) -> Void)
   func getImage(urlString: String?, completion:@escaping (UIImage?, Error?) -> Void)
   
}
