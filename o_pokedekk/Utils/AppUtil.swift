//
//  AppUtil.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 29/11/20.
//

import Foundation
import UIKit

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
   
   static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
      if let delegate = UIApplication.shared.delegate as? AppDelegate {
         delegate.supportedOrientation = orientation
      }
   }
}
