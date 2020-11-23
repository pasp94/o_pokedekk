//
//  ViewController.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 15/11/20.
//

import UIKit

class BaseViewController: UIViewController {
   
   init() {
      super.init(nibName: nil, bundle: nil)
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      if #available(iOS 13.0, *) {
         self.overrideUserInterfaceStyle = .light
      }
   }

   public func showAlert(title: String?, message: String?, error: Error? = nil) {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let close = UIAlertAction(title: "Close", style: .cancel) { (_) in }
      
      alert.addAction(close)
      
      self.present(alert, animated: true, completion: {})
   }
   
}

