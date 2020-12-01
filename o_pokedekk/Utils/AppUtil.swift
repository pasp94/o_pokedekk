//
//  AppUtil.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 29/11/20.
//

import Foundation
import UIKit


/// Halper that specify the device type in particoular
/// - `isIPhone`
///      -> `true` the device is an iPhone
///      -> `false` the device is an iPad
struct AppUtil {
   static var isIPhone: Bool {
      switch UIDevice.current.userInterfaceIdiom {
         case .phone:
            return true
         case .pad:
            return false
         case .unspecified:
            return false
         case .tv:
            return false
         case .carPlay:
            return false
         case .mac:
            return false
         @unknown default:
            return false
      }
   }
}
