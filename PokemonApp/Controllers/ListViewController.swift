//
//  ListViewController.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 10.10.2023.
//

import UIKit
import Combine

class ListViewController: UIViewController {
    
    weak var coordinator: MainScreenCoordinator?
    
    private var collectionView : UICollectionView?
    private var lightningsView = LightningsView()
    private var listPokemonViewModel = ListPokemonViewModel()
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: - life cycle:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setLightningsView()
        setCollectionView()
        sinkToError()
        sinkToPokemons()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - set view func:
    
    private func setView() {
        view.backgroundColor = .systemBackground
        title = "Know Them All"
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font : UIFont(name: FontsConstants.latoBold, size: 26) ?? UIFont.systemFont(ofSize: 34)]
    }
    
    private func sinkToError() {
        listPokemonViewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { error in
                guard let error = error else { return }
                self.showErrorAlert(message: error.localizedDescription)
            }.store(in: &cancellable)
    }
    
    private func setLightningsView() {
        lightningsView = LightningsView(frame: .init(x: 100, y: 0, width: 268, height: 596))
        view.addSubview(lightningsView)
    }
    
    //MARK: - fech pokemons func:
    
    private func sinkToPokemons() {
        listPokemonViewModel.$pokemonsList
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.collectionView?.reloadData()
            }.store(in: &cancellable)
    }
    
    // MARK: - CollectionView:
    
    private func setCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView?.register(ListCell.self, forCellWithReuseIdentifier: ListCell.cellID)
        collectionView?.backgroundColor = .clear
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
            collectionView.topAnchor.constraint(equalTo: navigationItem.titleView?.bottomAnchor ?? view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
//MARK: - CollectionViewDelegate, DataSource:

extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listPokemonViewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.cellID, for: indexPath) as? ListCell else {return UICollectionViewCell()}
        cell.pokemon = listPokemonViewModel.pokemonsList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? ListCell
        
        guard let pokemon = cell?.pokemon else { return }
        
        coordinator?.openPokemomDescription(pokemon)        
  }
}
