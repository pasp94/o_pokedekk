//
//  PokemonDetailViewController.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 22/11/20.
//

import UIKit

enum StatsSection: Int {
   case abilities = 0
   case baseStats = 1
}

final class PokemonDetailViewController: BaseViewController {
   
   // MARK: - Detail UI Views
   fileprivate let pokemonImageView: UIImageView = {
      let view = UIImageView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.contentMode = .scaleAspectFit
      return view
   }()
   
   fileprivate let pokemonNameLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.font = UIFont.systemFont(ofSize: 26, weight: .heavy)
      label.adjustsFontSizeToFitWidth = true
      label.textAlignment = .center
      label.contentMode = .center
      label.textColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1.0)
      
      return label
   }()
   
   fileprivate let pokemonElementCollection: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .horizontal
      layout.minimumLineSpacing = 10
      layout.minimumInteritemSpacing = 10
      
      let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
      collection.translatesAutoresizingMaskIntoConstraints = false
      collection.showsVerticalScrollIndicator = false
      collection.showsHorizontalScrollIndicator = true
      collection.layer.masksToBounds = false
      collection.clipsToBounds = false
      collection.register(TypeElementCell.self, forCellWithReuseIdentifier: String(describing: TypeElementCell.self))
      collection.backgroundColor = .white
      
      return collection
   }()
   
   fileprivate let weightInfoView: MoreInfoView = {
      let view = MoreInfoView(frame: .zero)
      view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = .lightGray
      
      return view
   }()
   
   fileprivate let heightInfoView: MoreInfoView = {
      let view = MoreInfoView(frame: .zero)
      view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = .lightGray
      
      return view
   }()
   
   fileprivate let moreInfoStack: UIStackView = {
      let stackView = UIStackView()
      stackView.translatesAutoresizingMaskIntoConstraints = false
      stackView.axis = .horizontal
      stackView.spacing = Constants.spacing
      stackView.alignment = .center
      stackView.distribution = .fillEqually
      
      return stackView
   }()
   
   fileprivate let statsTableview: UITableView = {
      let table = UITableView(frame: .zero)
      table.translatesAutoresizingMaskIntoConstraints = false
      table.showsVerticalScrollIndicator = true
      table.tableFooterView = .init()
      table.separatorStyle = .none
      table.register(AbilityTableCell.self, forCellReuseIdentifier: String(describing: AbilityTableCell.self))
      table.register(BaseStatCell.self, forCellReuseIdentifier: String(describing: BaseStatCell.self))
      table.backgroundColor = .white
      
      return table
   }()
   
   var detailViewModel: PokemonDetailViewModelProtocol
   
   init(viewModel: PokemonDetailViewModelProtocol) {
      self.detailViewModel = viewModel
      super.init()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setupNavBarApparence()
      loadDetailSubviews()
      setupViewModel()
   }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      hideSpinner()
   }
   
   override func rotated() {
      pokemonElementCollection.collectionViewLayout.invalidateLayout()
      weightInfoView.setNeedsLayout()
      heightInfoView.setNeedsLayout()
   }
   
   func setupViewModel() {
      detailViewModel.bindDetailData { 
         DispatchQueue.main.async {
            self.pokemonImageView.image            = self.detailViewModel.icon
            self.pokemonImageView.backgroundColor  = self.detailViewModel.typeColor
            self.pokemonNameLabel.text             = self.detailViewModel.name.uppercased()
            self.weightInfoView.valueLabel.text    = self.detailViewModel.weight
            self.heightInfoView.valueLabel.text    = self.detailViewModel.height
            
            self.pokemonElementCollection.reloadData()
            self.statsTableview.reloadData()
         }
      }
      
      detailViewModel.bindError {[weak self] (error) in
         guard let self = self else {return}
         self.showAlert(title: "Warning!", message: "An error occurred.", error: error)
      }
      
      detailViewModel.fetchDetailInfo()
   }
   
   func setupNavBarApparence() {
      navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
      navigationController?.navigationBar.shadowImage = UIImage()
      navigationController?.navigationBar.isTranslucent = true
      navigationController?.navigationBar.tintColor = .white
      navigationController?.view.backgroundColor = .clear
   }
   
   func loadDetailSubviews() {
      pokemonElementCollection.dataSource = self
      pokemonElementCollection.delegate = self
      
      statsTableview.delegate = self
      statsTableview.dataSource = self
      
      view.addSubview(pokemonImageView)
      view.addSubview(pokemonNameLabel)
      view.addSubview(pokemonElementCollection)
      view.addSubview(moreInfoStack)
      view.addSubview(statsTableview)
      
      NSLayoutConstraint.activate([
         pokemonImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
         pokemonImageView.heightAnchor.constraint(equalToConstant: view.bounds.height/3),
         pokemonImageView.topAnchor.constraint(equalTo: view.topAnchor),
         pokemonImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         pokemonImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         
         pokemonNameLabel.bottomAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: -Constants.spacing),
         pokemonNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         pokemonNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         pokemonNameLabel.heightAnchor.constraint(equalToConstant: 30.0),
         
         pokemonElementCollection.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: Constants.spacing),
         pokemonElementCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         pokemonElementCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         pokemonElementCollection.heightAnchor.constraint(equalToConstant: 30.0),
         
         moreInfoStack.topAnchor.constraint(equalTo: pokemonElementCollection.bottomAnchor, constant: Constants.spacing),
         moreInfoStack.heightAnchor.constraint(equalToConstant: 72.0),
         moreInfoStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.spacing),
         moreInfoStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.spacing),
         
         statsTableview.topAnchor.constraint(equalTo: moreInfoStack.bottomAnchor, constant: Constants.spacing),
         statsTableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
         statsTableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         statsTableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      ])
      
      moreInfoStack.addArrangedSubview(weightInfoView)
      moreInfoStack.addArrangedSubview(heightInfoView)
      
      ///Place-holdel setting
      weightInfoView.infoTitleLabel.text = "weight".capitalized
      heightInfoView.infoTitleLabel.text = "height".capitalized
   }
   
}

extension PokemonDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
   func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
   }
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return detailViewModel.numberOfTypeElement
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TypeElementCell.self), for: indexPath) as? TypeElementCell else { return .init() }
      
      detailViewModel.bindCellOfDetail(cell, for: indexPath)
      
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: 100.0, height: collectionView.frame.height)
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      let totalCellWidth = 100 * detailViewModel.numberOfTypeElement
      let totalSpacingWidth = 10 * (detailViewModel.numberOfTypeElement - 1)
      let sideInset = (collectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
      
      return UIEdgeInsets(top: 0, left: sideInset, bottom: 0, right: sideInset)
   }
}

extension PokemonDetailViewController: UITableViewDelegate, UITableViewDataSource {
   func numberOfSections(in tableView: UITableView) -> Int {
      return detailViewModel.numberOfSectionForStats
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return detailViewModel.getItemsForStatsSection(section: section)
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      switch indexPath.section {
         case StatsSection.baseStats.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BaseStatCell.self), for: indexPath) as? BaseStatCell else { return .init() }
            detailViewModel.bindCellOfDetail(cell, for: indexPath)
            cell.selectionStyle = .none
            return cell
            
         case StatsSection.abilities.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AbilityTableCell.self), for: indexPath) as? AbilityTableCell else { return .init() }
            detailViewModel.bindCellOfDetail(cell, for: indexPath)
            cell.selectionStyle = .none
            return cell
            
         default:
            return .init()
      }
   }
   
   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      switch section {
         case StatsSection.baseStats.rawValue:
            return "Base Stats"
            
         case StatsSection.abilities.rawValue:
            return "Abilities"
            
         default:
            return ""
      }
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 52.0
   }
}


