//
//  Router.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 22/11/20.
//

import Foundation
import UIKit


///     This protocol defines the interface for the App Coordinator
///     which has the role of manager of the navigation among the views.
protocol Router: class {
   
   var navigationController: UINavigationController { get set }
   
   func goToStart()
   func goForward(to nodeId: String, with parameters: [String: Any]?)
   func goBack()
}
