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
   static var cellCorner:           CGFloat { 15.0 }
   static var moreInfoCorner:       CGFloat { 15.0 }
   static var progressCorner:       CGFloat { 15.0 }
   
   static var iphoneCell:           CGFloat { 2.0 }
   static var landscapeIpadCell:    CGFloat { 4.0 }
   static var portraitIpadCell:     CGFloat { 3.0 }
   
   static var pokemonPerPage:       Int { return AppUtil.isIPhone ? 20 : 40 }
   
   static var appColor:             UIColor { .init(red: 180/255, green: 41/255, blue: 17/255, alpha: 1.0) }
   static var namePlaceholder:      String { "????????" }
   static var iconPlaceholder:      UIImage { UIImage(named: "placeholder") ?? UIImage() }
}
