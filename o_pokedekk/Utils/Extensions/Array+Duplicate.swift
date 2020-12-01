//
//  Array+Duplicate.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 30/11/20.
//

import Foundation

/// Custom methods that allow to remove duplicate appending a new sequence
extension Array where Element: Hashable {
   mutating func appendRemovingDuplicate(sequence: [Element]) {
      self.append(contentsOf: sequence)
      self = removingDuplicates()
   }
   
   mutating func removingDuplicates() -> [Element] {
      var addedDict = [Element: Bool]()
      
      return self.filter {
         addedDict.updateValue(true, forKey: $0) == nil
      }
   }
}




    
