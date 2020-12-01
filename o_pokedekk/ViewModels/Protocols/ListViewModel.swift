//
//  ListViewModel.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 22/11/20.
//

import Foundation

/// This protocol is the interface for ViewModels that manage views
/// made of a collection of objects, so it provides methods related to `fetch objects`,
/// to `manage selection` of one of them and provides methods
/// for the `binding cell view` (UITableViewCell or UICollectionViewCell)
/// This VM can manage a list of objs with only 1 section
protocol ListViewModel {
   /// Number of items used by a Collection/Table data source
   var numberOfItems: Int { get }
   
   /// Set the behaviour of the view model when the model change
   func bindDataList(completion: @escaping () -> ())
   
   /// Set the behaviour of the view model when an
   /// error occurred during an operation on model
   func bindError(completion: @escaping (Error) -> ())
   
   /// Fetch the starting information and update the
   /// view binding the initial data
   func initList()
   
   
   /// Instantiate the correct viewModel for the given Cell injecting in it
   /// the model on which update the cell view
   ///   - Parameters:
   ///      - `cell`: An object conform to `ConfigurableCell` protocol
   ///               (this means the is possible to inject the VM in cell)
   ///      - `indexPath`: the cell indexPath used for binding the right model
   func bindDataCell<CELL>(cell: CELL, at indexPath: IndexPath) where CELL: ConfigurableCell
   
   /// Fetch more object, update the model and notify to the view that
   /// something is change and the view should be updated
   ///   - Parameters:
   ///      - `index`: The starting index from which fetch more information
   func displayMoreObjects(from index: Int)
   
   /// Makes operation for the selected indexpath
   ///   - Parameters:
   ///      - `indexPath`: the index path linked to a specific information of the model
   func didSelectCell(at indexPath: IndexPath)
}
