//
//  NameImageViewModel.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 25/11/20.
//

import UIKit

protocol IconNameCellViewModelProtocol {
   var name: String? { get }
   var icon: UIImage? { get }
   
   func prepareForReuse()
}


final class IconNameCellViewModel {
   
}

extension IconNameCellViewModel: IconNameCellViewModelProtocol{
   
   var name: String? {
      <#code#>
   }
   
   var icon: UIImage? {
      return UIImage(named: "place")
   }
   
   func prepareForReuse() {
      //
   }
}
