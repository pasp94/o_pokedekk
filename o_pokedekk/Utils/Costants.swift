//
//  Costants.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 29/11/20.
//

import Foundation
import UIKit

struct Constants {
   static var inset:                CGFloat { 20.0 }
   static var topInset:             CGFloat { 20.0 }
   static var bottomInset:          CGFloat { 20.0 }
   static var rightInset:           CGFloat { 20.0 }
   static var leftInset:            CGFloat { 20.0 }
   static var spacing:              CGFloat { 20.0 }
   
   
   static var iphoneCell:           CGFloat { 2.0 }
   static var landscapeIpadCell:    CGFloat { 4.0 }
   static var portraitIpadCell:     CGFloat { 3.0 }
   
   static var pokemonPerPage:       Int { return AppUtil.isIPhone ? 20 : 35 }
}
