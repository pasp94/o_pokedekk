//
//  Router.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 22/11/20.
//

import Foundation
import UIKit


/// This protocol defines the interface for the App Coordinator
/// which has the role of managin the navigation among the views.
protocol Router: class {
   /// The object that manage the stack of visible view (viewcontrollers)
   var navigationController: UINavigationController { get set }
   
   /// The method that instantiate the initial view and brings the user to it
   /// cleaning the stack from other views and setting it as first.
   func goToStart()
   
   /// Instantiate the correct next view injecting in it the parameters passed
   /// to it, and changes the context pushing on navigation stack this new view
   ///   - Parameters:
   ///      - `nodeId`: The string that identify the next context
   ///                  (viewController to instantiate)
   ///      - `parameters`: Dictionary used to inject information derived from
   ///                     previos context
   func goForward(to nodeId: String, with parameters: [String: Any]?)
   
   /// Execute a pop action on navigation stack to
   /// brings the app to the previous context
   func goBack()
}
