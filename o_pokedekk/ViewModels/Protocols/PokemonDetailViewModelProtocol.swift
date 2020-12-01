//
//  PokemonDetailViewModelProtocol.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 22/11/20.
//

import Foundation
import UIKit

/// The inteface for View Model that manage the detail UI of the pokemon
/// (could be improved making it more general)
protocol PokemonDetailViewModelProtocol {
   
   
   var name: String { get }
   var icon: UIImage { get }
   var weight: String { get }
   var height: String { get }
   var typeColor: UIColor { get }
   
   var numberOfTypeElement: Int { get }
   
   var numberOfSectionForStats: Int { get }
   
   func getItemsForStatsSection(section: Int) -> Int
   
   /// Fetch the information and update the
   /// view binding the detail data
   func fetchDetailInfo()
   
   /// Set the behaviour of the view model when the model change
   func bindDetailData(completion: @escaping () -> ())
   
   /// Set the behaviour of the view model when an
   /// error occurred during an operation on model
   func bindError(completion: @escaping (Error) -> ())
   
   /// Instantiate the correct viewModel for the given Cell injecting in it
   /// the model on which update the cell view
   ///   - Parameters:
   ///      - `cell`: An object conform to `ConfigurableCell` protocol
   ///               (this means the is possible to inject the VM in cell)
   ///      - `indexPath`: the cell indexPath used for binding the right model
   func bindCellOfDetail<CELL: ConfigurableCell>(_ cell: CELL, for indexPath: IndexPath)
   
}
