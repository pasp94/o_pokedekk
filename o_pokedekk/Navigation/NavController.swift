//
//  NavController.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 30/11/20.
//

import UIKit

/// The navigation controller that can be customize
/// for the app (used to customize the orientation supported)
class NavController: UINavigationController {
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
      /// This Design choise is made to impove the UX on iPhone
      /// (in particoular when the user is in Detail View)
      if AppUtil.isIPhone {
         return .portraitUpsideDown
      } else {
         return .all
      }
   }
   
   override var shouldAutorotate: Bool {
      if AppUtil.isIPhone {
         return false
      } else {
         return true
      }
   }
   
   override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
   }
}
