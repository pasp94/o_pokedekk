//
//  MoreInfoView.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 29/11/20.
//

import Foundation
import UIKit


final class MoreInfoView: UIView {
   
   let valueLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
      label.adjustsFontSizeToFitWidth = true
      label.contentMode = .center
      label.textAlignment = .center
      label.textColor = .white
      
      return label
   }()
   
   
   let infoTitleLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
      label.adjustsFontSizeToFitWidth = true
      label.contentMode = .center
      label.textAlignment = .center
      label.textColor = .white
      
      return label
   }()
   
   
   override init(frame: CGRect) {
      super.init(frame: frame)
      
      self.layer.cornerRadius = Constants.moreInfoCorner
      
      /// Add cell subviews to content view
      addSubview(valueLabel)
      addSubview(infoTitleLabel)
      
      /// _Costraint defination and activation_
      NSLayoutConstraint.activate([
         /// `valueLabel` costraint
         valueLabel.topAnchor.constraint(equalTo: self.topAnchor),
         valueLabel.heightAnchor.constraint(equalToConstant: 50),
         valueLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         valueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         
         /// `infoTitleLabel` costraint
         infoTitleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor),
         infoTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         infoTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         infoTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      ])
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
