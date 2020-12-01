//
//  CacheWrapper.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 26/11/20.
//

import Foundation

/// This class is a wrapper used to manage NSCache mechanisms
/// to store structs retrieved by API
final class CacheWrapper<Value> {
   
   private let storage = NSCache<NSString, ObjectWrapper>()
   
   init() {
      
   }
   /// Insert in CacheWrapper the given Object
   /// - Parameters:
   ///   - `object`: the value to store in cache
   ///   - `key`: the key used to access to the object
   func insertObject(_ object: Value, for key: String) {
      storage.setObject(ObjectWrapper(object), forKey: key.nsString)
   }
   
   /// Retrieve from CacheWrapper the object for the given key or return nil
   /// - Parameters:
   ///   - `key`: the key used to access to the object
   func value(for key: String) -> Value? {
      guard let object = storage.object(forKey: key.nsString) else { return nil }
      return object.value
   }
   
   /// Remove the object for the given key from MemoryCache
   /// - Parameters:
   ///   - `key`: the key used to access to the object
   func removeObject(for key: String) {
      storage.removeObject(forKey: key.nsString)
   }
   
   /// Clean the memory
   func flush() {
      storage.removeAllObjects()
   }
}


private extension CacheWrapper {
   
   /// Implemented to make storable in NSCache any structs
   /// (NSCache has costraint on the value to store in)
   final class ObjectWrapper {
      let value:  Value
      
      init(_ value: Value) {
         self.value = value
      }
   }
}
