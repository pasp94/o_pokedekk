//
//  ConfigurableCell.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 27/11/20.
//

import Foundation
import UIKit

/// All the cells the can be configured with ViewModels
/// that conform to the defined protocols: `IconNameCellViewModelProtocol`, `TitledCellViewModelProtocol`, `ProgressLevelCellViewModelProtocol`
protocol ConfigurableCell {
   
   /// Allow to a genercs cell to be configured with one of the following ViewModelCell Protocols
   ///   - Parameters
   ///      - `viewModels`: the object in charge of matching the data of cells with them UI
   func setViewModel<T>(_ viewModel: T) where T: IconNameCellViewModelProtocol, T: TitledCellViewModelProtocol, T: ProgressLevelCellViewModelProtocol
}
