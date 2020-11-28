//
//  String+NSString.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 26/11/20.
//

import Foundation

extension String {
   /// This extension allows to transform string (that is struct a value)
   /// into a class object (usefull as key for NSCache)
   var nsString: NSString {
      return self as NSString
   }
}
