//
//  ProgressLevelCellViewModelProtocol.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 29/11/20.
//

import Foundation

protocol ProgressLevelCellViewModelProtocol {
   var name: String { get }
   
   var levelPercentage: Double { get }
   
   func prepareCellForReuse()
}
