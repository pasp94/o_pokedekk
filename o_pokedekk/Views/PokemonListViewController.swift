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
      
      let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
      collection.translatesAutoresizingMaskIntoConstraints = false
      collection.showsVerticalScrollIndicator = false
      collection.showsHorizontalScrollIndicator = false
      collection.register(PokemonListCell.self, forCellWithReuseIdentifier: String(describing: PokemonListCell.self))
      collection.backgroundColor = .clear
      
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
}

extension PokemonListViewController: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let cellSize = (collectionView.bounds.width - 60.0) / 2
      return CGSize(width: cellSize, height: cellSize)
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
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
//      listViewModel.didSelectCell(at: indexPath)
   }
   
   func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
      guard indexPath.row == (listViewModel.numberOfItems - 5) else { return }
      self.showSpinner()
      listViewModel.displayMoreObjects(from: indexPath.row)
   }
}
