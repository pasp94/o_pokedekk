//
//  AbilityTableCell.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 29/11/20.
//

import Foundation
import UIKit

final class AbilityTableCell: UITableViewCell {

   let abilityLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
      label.adjustsFontSizeToFitWidth = true
      label.contentMode = .center
      label.textAlignment = .center
      label.textColor = Constants.darkTextColor
      
      return label
   }()
   
   var viewModel: TitledCellViewModelProtocol?
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      
      /// Add cell subviews to content view
      contentView.addSubview(abilityLabel)
      
      /// _Costraint defination and activation_
      NSLayoutConstraint.activate([
         /// `NameLabel` costraint
         abilityLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
         abilityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
         abilityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         abilityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      ])
      
   }
   
   override func prepareForReuse() {
      self.viewModel?.prepareCellForReuse()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

extension AbilityTableCell: ConfigurableCell {
   func setViewModel<T>(_ viewModel: T) {
      self.viewModel = viewModel as? TitledCellViewModelProtocol
      
      DispatchQueue.main.async {
         self.abilityLabel.text = self.viewModel?.title
      }
   }
}




