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
    
    var viewModel: PropertySkillViewModel
    var nameLabel = UILabel()
    var imageView = UIImageView()
    let segmentedControl = PokemonSegmentControl()
    let detailTable = UITableView()
    var subscribers = Set<AnyCancellable>()
    
    init(viewModel: PropertySkillViewModel) {
        self.viewModel = viewModel
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
        setSegmentedControl()
        setItemsOnView()
        sinkToSkillModels()
        setConstraints()
    }
    
    //MARK: - @obj func:
    
    @objc func backToPokemonsListViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func selectedTag(_ sender: UISegmentedControl) {
       let selectedSegmentTag = sender.selectedSegmentIndex
        viewModel.selectedTag = selectedSegmentTag        
    }
    
    //MARK: - Private func:
    
    private func setView() {
        view.backgroundColor = .systemBackground
        
    }
    
    private func setLeftBarButton() {
        let backButton = UIButton(type: .system)
        backButton.setImage(ImageConstants.backBarImage, for: .normal)
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
    
    private func setSegmentedControl() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        segmentedControl.$selectedSegmentIndex
            .sink { index in
                self.viewModel.selectedTag = index
            }
            .store(in: &subscribers)
    }
    
    private func setDetailTable() {
        detailTable.register(CellForSkills.self, forCellReuseIdentifier: CellForSkills.CellID)
        detailTable.delegate = self
        detailTable.dataSource = self
        detailTable.separatorStyle = .none
        detailTable.showsVerticalScrollIndicator = false
        detailTable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailTable)
    }
    
    private func setItemsOnView() {
        nameLabel.text = viewModel.pokemon.name.capitalizeFirstLetter()
        guard let urlImage = URL(string: viewModel.pokemon.sprites.frontDefault) else {
            return
        }
        imageView.sd_setImage(with: urlImage)
    }
    
    private func sinkToSkillModels() {
        viewModel.$cellModels
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
            
            segmentedControl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30),
            
            detailTable.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            detailTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
}

//MARK: - TableViewDelegate, DataSource:

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellForSkills.CellID, for: indexPath) as? CellForSkills  else { return UITableViewCell() }
        
        cell.model = viewModel.cellModels[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
