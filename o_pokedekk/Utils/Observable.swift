//
//  Observable.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 16/11/20.
//

import Foundation

/// An helper class that allows to implement a trigger when the objects
/// of which has a reference change it's value (state)
class Observable<T> {
   typealias Listener = (T) -> Void
   
   private var listener: Listener?
   
   var value: T {
      didSet {
         listener?(value)
      }
   }
   
   init(_ v: T) {
      self.value = v
   }
   
   /// Set the closure to fire when value change state
   ///   - Parameters:
   ///      - `listener`: the closure to fire
   func bind(_ listener: @escaping Listener) {
      self.listener = listener
   }
   
   /// Set the closure to fire when value change state
   /// and fire it with the current state
   ///   - Parameters:
   ///      - `listener`: the closure to fire
   func bindAnFire(_ listener: @escaping Listener) {
      self.listener = listener
      listener(value)
   }
}
