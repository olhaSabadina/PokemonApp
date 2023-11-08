//
//  DetailViewController.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 12.10.2023.
//

import UIKit
import Combine
import SDWebImage

class DetailViewController: UIViewController {
    
    weak var coordinator: DetailSkillsCoordinator?
    
    private let backBarImage = UIImage(systemName: "arrow.backward")
    private let choosingSegmentView = ChoosingSegmentView()
    private let detailTable = UITableView()
    private var propertySkillViewModel: PropertySkillViewModel
    private var nameLabel = UILabel()
    private var imageView = UIImageView()
    private var subscribers = Set<AnyCancellable>()
    
    init(viewModel: PropertySkillViewModel) {
        self.propertySkillViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life cycle:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDetailTable()
        setView()
        setLeftBarButton()
        setNameLabel()
        setImageView()
        setChoosingSegmentView()
        setItemsOnView()
        singToError()
        sinkToSkillModels()
        setConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 0.5
        view.window?.layer.add(transition, forKey: kCATransition)
    }
    
    //MARK: - @obj func:
    
    @objc func backToPokemonsListViewController() {
        coordinator?.stop(andMoveTo: .mainScreen)
    }
    
    @objc func selectedTag(_ sender: UISegmentedControl) {
        let selectedSegmentTag = sender.selectedSegmentIndex
        propertySkillViewModel.selectedTag = selectedSegmentTag
    }
    
    //MARK: - Private func:
    
    private func setView() {
        view.backgroundColor = .systemBackground
    }
    
    private func singToError() {
        propertySkillViewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { error in
                guard let error = error else { return }
                self.showErrorAlert(message: error.localizedDescription)
            }.store(in: &subscribers)
    }
    
    private func setLeftBarButton() {
        let backButton = UIButton(type: .system)
        backButton.setImage(backBarImage, for: .normal)
        backButton.sizeToFit()
        backButton.tintColor = .label
        backButton.addTarget(self, action: #selector(backToPokemonsListViewController), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func setNameLabel() {
        nameLabel.font = UIFont(name: FontsConstants.latoBold, size: 26)
        nameLabel.textColor = .label
        nameLabel.textAlignment = .left
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
    }
    
    private func setImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
    }
    
    private func setChoosingSegmentView() {
        choosingSegmentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(choosingSegmentView)
        choosingSegmentView.$selectedSegmentIndex
            .sink { index in
                self.propertySkillViewModel.selectedTag = index
            }
            .store(in: &subscribers)
    }
    
    private func setDetailTable() {
        detailTable.register(CellForSkills.self, forCellReuseIdentifier: CellForSkills.cellID)
        detailTable.delegate = self
        detailTable.dataSource = self
        detailTable.separatorStyle = .none
        detailTable.showsVerticalScrollIndicator = false
        detailTable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailTable)
    }
    
    private func setItemsOnView() {
        nameLabel.text = propertySkillViewModel.pokemon.name.capitalizeFirstLetter()
        guard let urlImage = URL(string: propertySkillViewModel.pokemon.sprites.frontDefault) else {
            return
        }
        imageView.sd_setImage(with: urlImage)
    }
    
    private func sinkToSkillModels() {
        propertySkillViewModel.$cellModels
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.detailTable.reloadData()
            }
            .store(in: &subscribers)
    }
    
    //MARK: - Constraints:
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            imageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageView.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            
            choosingSegmentView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            choosingSegmentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            choosingSegmentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            choosingSegmentView.heightAnchor.constraint(equalToConstant: 30),
            
            detailTable.topAnchor.constraint(equalTo: choosingSegmentView.bottomAnchor, constant: 10),
            detailTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
}

//MARK: - TableViewDelegate, DataSource:

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propertySkillViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellForSkills.cellID, for: indexPath) as? CellForSkills  else { return UITableViewCell() }
        
        cell.skillsCellModel = propertySkillViewModel.cellModels[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
