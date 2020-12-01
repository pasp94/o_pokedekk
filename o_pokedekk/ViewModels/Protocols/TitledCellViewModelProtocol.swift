//
//  TitledCellViewModelProtocol.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 29/11/20.
//

import Foundation
import UIKit

protocol TitledCellViewModelProtocol {
   var title: String { get }
   
   var backgroundColor: UIColor { get }
   
   func prepareCellForReuse()
}
