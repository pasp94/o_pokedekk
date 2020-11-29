//
//  ConfigurableCell.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 27/11/20.
//

import Foundation

protocol ConfigurableCell {
   func setViewModel<T>(_ viewModel: T) where T: IconNameCellViewModelProtocol, T: TitledCellViewModelProtocol, T: ProgressLevelCellViewModelProtocol
}
