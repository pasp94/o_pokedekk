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

protocol ListViewModel {
   var numberOfItems: Int { get }
   
   func bindDataList(completion: @escaping () -> ())
   
   func bindError(completion: @escaping (Error) -> ())
   
   func initList()
   
   func bindDataCell<CELL>(cell: CELL, at indexPath: IndexPath) where CELL: ConfigurableCell
   
   func displayMoreObjects(from index: Int)
   
   func didSelectCell(at indexPath: IndexPath)
}
