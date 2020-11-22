//
//  ViewController.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 15/11/20.
//

import UIKit

class BaseViewController: UIViewController {

   override func viewDidLoad() {
      super.viewDidLoad()
   }

   public func showAlert(title: String?, message: String?, error: Error? = nil) {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let close = UIAlertAction(title: "Close", style: .cancel) { (_) in }
      
      alert.addAction(close)
      
      self.present(alert, animated: true, completion: {})
   }
   
}

