//
//  PokemonsListViewController.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 10.10.2023.
//

import UIKit

class PokemonsListViewController: UIViewController {
    
    var collectionView : UICollectionView?
    var viewModel = PokemonsListViewModel()
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setCollectionView()
        setConstraints()
    }
    
    // MARK: - private func:
    
    private func setView() {
        view.backgroundColor = .systemBackground
        title = TitleConstants.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font : UIFont(name: FontsEnum.latoBold, size: 26) ?? UIFont.systemFont(ofSize: 34)]
    }
    
    // MARK: - CollectionView:
    
    private func setCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView?.register(PokemonsListVCCollectionCell.self, forCellWithReuseIdentifier: PokemonsListVCCollectionCell.identCell)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView ?? UICollectionView())
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { _, _ in
            let item = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), spacing: 10)
            
            let group = CompositionalLayout.createGroupeCount(aligment: .horizontal, width: .fractionalWidth(0.5), height: .fractionalHeight(1/5), item: item, count: 2)
            group.contentInsets = .init(top: 5, leading: 0, bottom: 0, trailing: 0)
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
     return layout
    }
    
    // MARK: - set Constraints:
    
    private func setConstraints() {
        guard let collectionView = collectionView else { return }
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
