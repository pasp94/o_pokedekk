//
//  Observable.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 16/11/20.
//

import Foundation


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
   
   func bind(_ listener: @escaping Listener) {
      self.listener = listener
   }
   
   func bindAnFire(_ listener: @escaping Listener) {
      self.listener = listener
      listener(value)
   }
}
