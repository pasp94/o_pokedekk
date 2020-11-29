//
//  TypeElementCell.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 29/11/20.
//

import Foundation
import UIKit


class TypeElementCell: UICollectionViewCell {
   
   let typeLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
      label.adjustsFontSizeToFitWidth = true
      label.contentMode = .center
      label.textAlignment = .center
      label.textColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
      
      return label
   }()
   
   var viewModel: TitledCellViewModelProtocol?
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      layer.cornerRadius = frame.height*0.5
      
      /// Add cell subviews to content view
      contentView.addSubview(typeLabel)
      
      /// _Costraint defination and activation_
      NSLayoutConstraint.activate([
         /// `NameLabel` costraint
         typeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
         typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
         typeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
         typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      ])
      
   }
   
   override func prepareForReuse() {
      self.viewModel?.prepareCellForReuse()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}


extension TypeElementCell: ConfigurableCell {
   func setViewModel<T>(_ viewModel: T) {
      self.viewModel = viewModel as? TitledCellViewModelProtocol
      
      DispatchQueue.main.async {
         self.typeLabel.text = self.viewModel?.title
         self.backgroundColor = self.viewModel?.backgroundColor
      }
   }
}
