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
      collection.register(PokemonListCell.self, forCellWithReuseIdentifier: PokemonListCell.reuseIdentifier)
      collection.backgroundColor = .clear
      
      return collection
   }()
   
   var listViewModel: PokemonListViewModel
   
   init(viewModel: PokemonListViewModel) {
      self.listViewModel = viewModel
      super.init()
   }
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      self.view.backgroundColor = .white
   
      self.setCollectionViewConstraints()
      self.initViewModel()
      
      listViewModel.fetchNextPokemons()
   }
   
   
   // MARK: SETUP VIEWMODEL
   fileprivate func initViewModel() {
      self.listViewModel.bindData {
         
         DispatchQueue.main.async {
            self.collectionView.reloadData()
         }
      }
   }
   
   
   // MARK: SETUP VIEWS COSTRAINTS
   fileprivate func setCollectionViewConstraints() {
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

extension PokemonListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
      let cellSize = (collectionView.bounds.width - 60) * 0.5
      return CGSize(width: cellSize, height: cellSize)
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      
      return UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
   }
   
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return listViewModel.pokemonList.value.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonListCell.reuseIdentifier, for: indexPath) as! PokemonListCell
      
      cell.backgroundColor = .red
      cell.name.text = listViewModel.pokemonList.value[indexPath.row].name
      
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      //Chiamata la router per la navigazione
      listViewModel.showPokemonDetail(index: indexPath.row)
   }
   
   func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
      if indexPath.row % 15 == 0 {
         listViewModel.fetchNextPokemons()
      }
   }
}
