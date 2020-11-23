//
//  PokemonAPIManager.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 17/11/20.
//

import Foundation
import UIKit

class PokemonAPIManager: APIProvider {
   
   public static let share: PokemonAPIManager = PokemonAPIManager()
   
   private init() {}
   
   var session: URLSession {
      return URLSession.shared
   }
   
   
   fileprivate func validate(_ response: HTTPURLResponse) -> Result<String> {
      switch response.statusCode {
         // MARK:- Range of status code for Success response
         case 200...299:   return .success
            
         // MARK:- Range of status code for Error response
         case 400...500:   return .failure(NetworkError.authenticationError.rawValue)
         case 501...599:   return .failure(NetworkError.badRequest.rawValue)
         case 600:         return .failure(NetworkError.outdated.rawValue)
            
         // MARK:- Generic Error Response
         default:          return .failure(NetworkError.failed.rawValue)
      }
   }
   
   
   
   func getPage<T: Codable>(urlString: String?, decodingType: T.Type, completion: @escaping (T?, Error?) -> Void) {
      let url: URL
      
      if let uri = urlString {
         guard let strogUrl = URL(string: uri) else { return /*AGGIUNGERE GESTIONE DEGLI ERRORI*/}
         url = strogUrl
      } else {
         /// Used to build the url for the first page
         /// (without any offset or page index)
         url = PokemonApi<Any>.pokemonFirstPage.buildURL()
      }
      
      let _ = session.dataTask(with: url) { (data, response, error) in
         guard let httpResponse = response as? HTTPURLResponse else { completion(nil, error); return }
         switch self.validate(httpResponse) {
            case .success:
               guard let dataResponse = data else {
                  completion(nil, error)
                  return
               }
               
               let decoder = JSONDecoder()
               do {
                  let page = try decoder.decode(decodingType, from: dataResponse)
                  completion(page, error)
               } catch {
                  completion(nil, error);
               }
               break
               
            case .failure(let errorMessage):
               debugPrint(errorMessage)
               completion(nil, error);
               break
         }
         
      }.resume()
   }
   
   func getDetail<T: Codable>(urlString: String?, decodingType: T.Type, completion: @escaping (T?, Error?) -> Void) {
      
      guard let uri = urlString,
            let url = URL(string: uri)
      else { return /*AGGIUNGERE GESTIONE DEGLI ERRORI*/}
      
      let _ = session.dataTask(with: url) { (data, response, error) in
         guard let httpResponse = response as? HTTPURLResponse else { completion(nil, error); return }
         
         switch self.validate(httpResponse) {
            case .success:
               guard let dataResponse = data else {
                  completion(nil, error)
                  return
               }
               
               let decoder = JSONDecoder()
               do {
                  let pokemon = try decoder.decode(decodingType, from: dataResponse)
                  completion(pokemon, error)
               } catch {
                  completion(nil, error)
               }
               
               break
            case .failure(let errorMessage):
               debugPrint(errorMessage)
               completion(nil, error)
               
               break
         }
         
      }.resume()
   }
   
   func getImage(urlString: String?, completion: @escaping (UIImage?, Error?) -> Void) {
      
      guard let uri = urlString,
            let url = URL(string: uri)
      else { return /*AGGIUNGERE GESTIONE DEGLI ERRORI*/}
      
      let _ = session.dataTask(with: url) { (data, response, error) in
         guard let httpResponse = response as? HTTPURLResponse else { completion(nil, error); return }
         
         switch self.validate(httpResponse) {
            case .success:
               guard let dataResponse = data else {
                  completion(nil, error)
                  return
               }
               let image = UIImage(data: dataResponse)
               completion(image, error)
               
               break
            case .failure(let errorMessage):
               debugPrint(errorMessage)
               completion(nil, error)
               
               break
         }
      }.resume()
   }
}
