//
//  IconNameCellViewModelProtocol.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 27/11/20.
//

import Foundation
import UIKit

protocol IconNameCellViewModelProtocol {
   
   var name: String { get }
   var icon: UIImage { get }
   var backgroundColor: UIColor { get }
   
   func fetchViewData()
   
   func bindDataCell(completion: @escaping (_ isLoaded: Bool) -> ())
   
   func bindErrorCell(completion: @escaping (Error) -> ())
   
   func prepareCellForReuse()
}
