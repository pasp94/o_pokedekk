//
//  PokemonAPIManager.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 17/11/20.
//

import Foundation
import UIKit

final class PokemonAPIManager: PokemonProvider {
   
   public static let share: PokemonAPIManager = PokemonAPIManager()
   
   private let pokemonCache = CacheWrapper<Pokemon>()
   private let pageCache = CacheWrapper<PokemonPage>()
   
   func getPokemonPage(fromUrl: String, completion: @escaping (Result<PokemonPage, Error>) -> ()) {
      
      if let page = pageCache.value(for: fromUrl) {
         completion(.success(page))
         return
      }
      
      self.get(urlString: fromUrl, decodingType: PokemonPage.self) {[weak self] (result) in
         switch result {
            case .success(let page):
               completion(.success(page))
               guard let self = self else { return }
               self.pageCache.insertObject(page, for: fromUrl)
               break
            case .failure(let error):
               completion(.failure(error))
               break
         }
      }
   }
   
   func getPokemonPage(fromPageNumber: Int, pokemonPerPage: Int, completion: @escaping (Result<PokemonPage, Error>) -> ()) {
      
      guard let uri = try? PokemonApi<Int>.pokemonPage(index: fromPageNumber, offset: pokemonPerPage).buildURL()
      else {
         completion(.failure(NetworkError.badURL))
         return
      }
      
      if let page = pageCache.value(for: uri) {
         completion(.success(page))
         return
      }
      
      self.get(urlString: uri, decodingType: PokemonPage.self) {[weak self] (result) in
         switch result {
            case .success(let page):
               completion(.success(page))
               guard let self = self else { return }
               self.pageCache.insertObject(page, for: uri)
               break
            case .failure(let error):
               completion(.failure(error))
               break
         }
      }
   }
   
   func getPokemon(urlString: String, completion: @escaping (Result<Pokemon, Error>) -> ()) {
      
      self.get(urlString: urlString, decodingType: PokemonDetail.self) { (result) in
         switch result {
            case .success(let pokemonDetail):
               self.downloadImage(urlString: pokemonDetail.sprites.frontDefaultUrl) { (result) in
                  switch result {
                  case .success(let sprite):
                     completion(.success(pokemonDetail.toPokemon(withSprite: sprite)))
                     break
                  case .failure(let error):
                     completion(.failure(error))
                     break
                  }
               }
               break
            case .failure(let error):
               completion(.failure(error))
               break
         }
      }
   }
   
   func flushCacheMemory() {
      pokemonCache.flush()
      pageCache.flush()
   }
   
   private init() {}
   
}

extension PokemonAPIManager: APIProvider {
   
   var session: URLSession {
      return URLSession.shared
   }
   
   func get<T: Codable>(urlString: String?, decodingType: T.Type, completion:@escaping (Result<T, Error>) -> Void) {
      guard let uri = urlString,
            let url = URL(string: uri)
      else {
         completion(.failure(NetworkError.badURL))
         return
      }
      
      let _ = session.dataTask(with: url) { (data, response, error) in
         guard let httpResponse = response as? HTTPURLResponse else {
            if let error = error {
               completion(.failure(error))
            }
            return
         }
         
         switch self.validate(httpResponse) {
            case .success:
               guard let dataResponse = data else {
                  completion(.failure(NetworkError.noData))
                  return
               }
               
               let decoder = JSONDecoder()
               do {
                  let decodedObj = try decoder.decode(decodingType, from: dataResponse)
                  completion(.success(decodedObj))
                  
               } catch {
                  completion(.failure(error));
               }
               break
               
            case .failure(let error):
               completion(.failure(error));
               break
         }
         
      }.resume()
   }
   
   func downloadImage(urlString: String?, completion:@escaping (Result<UIImage, Error>)-> Void) {
      guard let uri = urlString,
            let url = URL(string: uri)
      else {
         completion(.failure(NetworkError.badURL))
         return
      }
      
      let _ = session.dataTask(with: url) { (data, response, error) in
         guard let httpResponse = response as? HTTPURLResponse else {
            if let error = error {
               completion(.failure(error))
            }
            return
         }
         
         switch self.validate(httpResponse) {
            case .success:
               guard let dataResponse = data else {
                  completion(.failure(NetworkError.noData))
                  return
               }
               guard let image = UIImage(data: dataResponse) else {
                  completion(.failure(NetworkError.unableToDecode))
                  return
               }
               completion(.success(image))
               
               break
            case .failure(let error):
               debugPrint(error)
               completion(.failure(error))
               
               break
         }
      }.resume()
   }
   
   internal func validate(_ response: HTTPURLResponse) -> Result<Void, Error> {
      switch response.statusCode {
         /// Range of status code for Success response
         case 200...299:   return .success(())
            
         /// Range of status code for Error response
         case 400...500:   return .failure(NetworkError.authenticationError)
         case 501...599:   return .failure(NetworkError.badURL)
         case 600:         return .failure(NetworkError.outdated)
            
         /// Generic Error Response
         default:          return .failure(NetworkError.failed)
      }
   }
}
