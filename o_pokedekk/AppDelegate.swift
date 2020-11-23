//
//  AppDelegate.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 15/11/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?

   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
      let navController = UINavigationController()
      let router = AppRouter(navController: navController)
      
      router.goToStart()
      
      let window = UIWindow(frame: UIScreen.main.bounds)
      window.rootViewController = navController
      window.makeKeyAndVisible()
      
      self.window = window
      
      return true
   }


}

