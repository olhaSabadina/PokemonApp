//
//  PokemonsListVC+CollectionView.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 10.10.2023.
//

import UIKit

extension PokemonsListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonsListVCCollectionCell.identCell, for: indexPath) as? PokemonsListVCCollectionCell else {return UICollectionViewCell()}
       
        return cell
    }
}
