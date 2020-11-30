//
//  BaseStatCell.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 29/11/20.
//

import Foundation
import UIKit

final class BaseStatCell: UITableViewCell {

   let statLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
      label.adjustsFontSizeToFitWidth = true
      label.contentMode = .center
      label.textAlignment = .center
      label.textColor = .gray
      
      return label
   }()
   
   let progressBar: UIProgressView = {
      let progress = UIProgressView(progressViewStyle: .default)
      progress.translatesAutoresizingMaskIntoConstraints = false
      progress.layer.cornerRadius = Constants.progressCorner
      
      return progress
   }()
   
   var viewModel: ProgressLevelCellViewModelProtocol?
   
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      
      /// Add cell subviews to content view
      contentView.addSubview(statLabel)
      contentView.addSubview(progressBar)
      
      /// _Costraint defination and activation_
      NSLayoutConstraint.activate([
         /// `NameLabel` costraint
         statLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
         statLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
         statLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
         statLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width*0.15),
         
         progressBar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0),
         progressBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20.0),
         progressBar.leadingAnchor.constraint(equalTo: statLabel.trailingAnchor, constant: 30.0),
         progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15.0),
      ])
      
   }
   
   override func prepareForReuse() {
      self.viewModel?.prepareCellForReuse()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}

extension BaseStatCell: ConfigurableCell {
   func setViewModel<T>(_ viewModel: T) {
      self.viewModel = viewModel as? ProgressLevelCellViewModelProtocol
      
      DispatchQueue.main.async {
         self.statLabel.text = self.viewModel?.name.uppercased()
         let percentage = self.viewModel?.levelPercentage ?? 0
         
         UIView.animate(withDuration: 0.7) {
             self.progressBar.setProgress(Float(percentage), animated: true)
         }
      }
   }
}
