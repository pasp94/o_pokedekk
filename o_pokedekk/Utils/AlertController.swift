//
//  AlertController.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 02/12/20.
//

import UIKit

/// A customization of UIAlertController used to override the shouldAutorotate property
final class AlertController: UIAlertController {
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   override var shouldAutorotate: Bool {
      if AppUtil.isIPhone {
         return false
      } else {
         return true
      }
   }
}
