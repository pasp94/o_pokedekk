//
//  PokemonDetailViewModelProtocol.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 22/11/20.
//

import Foundation
import UIKit

protocol PokemonDetailViewModelProtocol {
   
   var name: String { get }
   var icon: UIImage { get }
   var weight: String { get }
   var height: String { get }
   var typeColor: UIColor { get }
   
   var numberOfTypeElement: Int { get }
   
   var numberOfSectionForStats: Int { get }
   
   func getItemsForStatsSection(section: Int) -> Int
   
   func fetchDetailInfo()
   
   func bindDetailData(completion: @escaping () -> ())
   
   func bindError(completion: @escaping (Error) -> ())

   func bindCellOfDetail<CELL: ConfigurableCell>(_ cell: CELL, for indexPath: IndexPath)
   
}
