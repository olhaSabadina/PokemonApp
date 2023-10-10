//
//  FirstScreen+CollectionView.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 10.10.2023.
//

import UIKit

extension FirstScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstScreenVCCollectionCell.identCell, for: indexPath) as? FirstScreenVCCollectionCell else {return UICollectionViewCell()}
        cell.backgroundColor = .blue
        return cell
    }
}
