//
//  PokemonListViewController.swift
//  o_pokedekk
//
//  Created by Pasquale Spisto on 16/11/20.
//

import UIKit

class PokemonListViewController: BaseViewController {
   
   fileprivate var collectionView: UICollectionView = {
      let layout = UICollectionViewFlowLayout()
      layout.scrollDirection = .vertical
      layout.minimumLineSpacing = Constants.spacing
      layout.minimumInteritemSpacing = Constants.spacing
      
      let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
      collection.translatesAutoresizingMaskIntoConstraints = false
      collection.showsVerticalScrollIndicator = false
      collection.showsHorizontalScrollIndicator = false
      collection.layer.masksToBounds = false
      collection.clipsToBounds = false
      collection.register(PokemonListCell.self, forCellWithReuseIdentifier: String(describing: PokemonListCell.self))
      collection.backgroundColor = .white
      
      return collection
   }()
   
   var listViewModel: ListViewModel
   
   init(viewModel: PokemonListViewModel) {
      self.listViewModel = viewModel
      super.init()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      setupCollectionView()
      setupViewModel()
      
      listViewModel.initList()
   }
   
   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      setupNavBarApparence()
   }
   
   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      hideSpinner()
   }
   
   
   override func rotated() {
      collectionView.collectionViewLayout.invalidateLayout()
   }
   
   
   // MARK: SETUP VIEWMODEL
   fileprivate func setupViewModel() {
      self.listViewModel.bindDataList {
         DispatchQueue.main.async {
            self.hideSpinner()
            self.collectionView.reloadData()
         }
      }
   }
   
   
   // MARK: SETUP VIEWS COSTRAINTS
   private func setupCollectionView() {
      collectionView.delegate = self
      collectionView.dataSource = self
      
      view.addSubview(collectionView)
      NSLayoutConstraint.activate([
         collectionView.topAnchor.constraint(equalTo: view.topAnchor),
         collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
         collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
      ])
   }
   
   func setupNavBarApparence() {
      navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
      navigationController?.navigationBar.shadowImage = UIImage()
      navigationController?.navigationBar.isTranslucent = false
      navigationController?.navigationBar.barTintColor = Constants.appColor
      navigationController?.view.backgroundColor = .white
   }
}

extension PokemonListViewController: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      /// Squared cell are used in this app
      var numberOfCell: CGFloat
      
      if AppUtil.isIPhone {
         /// iPhone Screen: the rotation is locked (Design choise)
         numberOfCell = Constants.iphoneCell
      
      } else {
         /// iPad Screen: the rotation is not locked
         /// so we can have portrait or landscape mode
         numberOfCell = UIDevice.current.orientation.isLandscape ? Constants.landscapeIpadCell : Constants.portraitIpadCell
      }
      let cellSize = (collectionView.bounds.width - Constants.spacing * (numberOfCell + 1)) / numberOfCell
      
      return CGSize(width: cellSize, height: cellSize)
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return UIEdgeInsets(top: Constants.inset,
                          left: Constants.inset,
                          bottom: Constants.inset,
                          right: Constants.inset)
   }
}

extension PokemonListViewController: UICollectionViewDataSource {
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return listViewModel.numberOfItems
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PokemonListCell.self), for: indexPath) as? PokemonListCell
      else { return .init() }
      
      listViewModel.bindDataCell(cell: cell, at: indexPath)
      
      return cell
   }
}

extension PokemonListViewController: UICollectionViewDelegate {
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      showSpinner()
      listViewModel.didSelectCell(at: indexPath)
   }
   
   func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
      guard indexPath.row == (listViewModel.numberOfItems - 5) else { return }
      self.showSpinner()
      listViewModel.displayMoreObjects(from: indexPath.row)
   }
}
