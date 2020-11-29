//
//  ViewController.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 15/11/20.
//

import UIKit

class BaseViewController: UIViewController {
   
   private lazy var spinner: UIActivityIndicatorView = initSpinner()
   
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
      self.view.backgroundColor = .white
      
      NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
   }

   deinit {
      NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      /// This Design choise is made to impove the UX on iPhone
      /// (in particoular when the user is in Detail View)
      AppUtil.isIPhone ? AppUtil.lockOrientation(.portraitUpsideDown) : AppUtil.lockOrientation(.all)
   }
   

   @objc open func rotated() {
      /// Is possible to checke the shared value UIDevice.current.orientation.isLandscape
      /// to understand which layout the app as
   }
   
   public func showAlert(title: String?, message: String?, error: Error? = nil) {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let close = UIAlertAction(title: "Close", style: .cancel) { (_) in }
      
      alert.addAction(close)
      
      self.present(alert, animated: true, completion: {})
   }
   
   private func initSpinner() -> UIActivityIndicatorView {
      let indicator = UIActivityIndicatorView(style: .whiteLarge)
      indicator.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
      indicator.translatesAutoresizingMaskIntoConstraints = false
      
      view.addSubview(indicator)
      NSLayoutConstraint.activate([
         indicator.topAnchor.constraint(equalTo: view.topAnchor),
         indicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         indicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         indicator.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      ])
      
      return indicator
   }
   
   public func showSpinner() {
      DispatchQueue.main.async {
         self.spinner.startAnimating()
      }
   }
   
   
   public func hideSpinner() {
      DispatchQueue.main.async {
         self.spinner.stopAnimating()
      }
   }
}

