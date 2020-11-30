//
//  AppRouter.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 22/11/20.
//

import Foundation
import UIKit


final class AppRouter: Router {
   
   internal var navigationController: UINavigationController
   
   init(navController: UINavigationController) {
      self.navigationController = navController
   }
   
   func goToStart() {
      self.goForward(to: AppContexts.list.rawValue, with: nil)
   }
   
   func goForward(to nodeId: String, with parameters: [String : Any]?) {
      switch nodeId {
         case AppContexts.list.rawValue:
            
            let apiManager = PokemonAPIManager.share
            let vm = PokemonListViewModel(provider: apiManager, router: self)
            let vc = PokemonListViewController(viewModel: vm)
            
            navigationController.pushViewController(vc, animated: true)
            
            break
         case AppContexts.detail.rawValue:
            let url = parameters?["detailUrl"] as? String
            
            let apiManager = PokemonAPIManager.share
            let vm = PokemonDetailViewModel(detailUrl: url, provider: apiManager, router: self)
            let vc = PokemonDetailViewController(viewModel: vm)
            
            navigationController.pushViewController(vc, animated: true)
            
            break
         default:
            break
      }
   }
   
   
   func goBack() {
      navigationController.popViewController(animated: true)
   }
}

extension AppRouter {
   //This are the list of all the Context available in the app
   enum AppContexts: String {
      case list   = "list"
      case detail = "detail"
   }
}
