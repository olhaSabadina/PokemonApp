//
//  DetailViewController.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 12.10.2023.
//

import UIKit
import Combine

class DetailViewController: UIViewController {
    
    var viewModel: PropertyTableViewModel
    let activityIndicator = UIActivityIndicatorView()
    var nameLabel = UILabel()
    var imageView = UIImageView()
    let segmentedControl = UISegmentedControl(items: ["About", "Stats", "Evolution", "Moves"])
    let detailTable = UITableView()
    var subscribers = Set<AnyCancellable>()
    
    init(viewModel: PropertyTableViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.activityIndicator.startAnimating()
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
        sinkToModelsForCells()
        setConstraints()
    }
    
    //MARK: - @obj func:
    
    @objc func backToPokemonsListViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Private func:
    
    private func setView() {
        view.backgroundColor = .systemBackground
        setActivityIndicator()
    }
    
    private func setActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = .blue
        view.addSubview(activityIndicator)
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
        segmentedControl.selectedSegmentTintColor = .none
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor: UIColor.red], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: FontsConstants.latoRegular, size: 15) ?? UIFont.systemFont(ofSize: 15)], for: .normal)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
    }
    
    private func setDetailTable() {
        detailTable.register(CellForSkills.self, forCellReuseIdentifier: CellForSkills.CellID)
        detailTable.register(CellForPhrase.self, forCellReuseIdentifier: CellForPhrase.CellID)
        detailTable.delegate = self
        detailTable.dataSource = self
        detailTable.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailTable)
    }
    
    private func sinkToModelsForCells() {
        viewModel.$cellModels
            .filter{!$0.isEmpty}
            .sink { array in
            DispatchQueue.main.async {
                self.addDataFromModelsForCells()
            }
        }.store(in: &subscribers)
    }
    
    private func addDataFromModelsForCells() {
        activityIndicator.stopAnimating()
        nameLabel.text = "Mock name"
        imageView.image = UIImage(named: "cat") //mock image
        detailTable.reloadData()
    }
    
    //MARK: - Constraints:
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            imageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40),
            
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
        return viewModel.detailNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 5 , let cell = tableView.dequeueReusableCell(withIdentifier: CellForPhrase.CellID, for: indexPath) as? CellForPhrase {
            
            cell.phraseLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Facilisi morbi tempus iaculis urna id volutpat lacus laoreet."
            
            return cell
            
        } else if let cell = tableView.dequeueReusableCell(withIdentifier: CellForSkills.CellID, for: indexPath) as? CellForSkills {
            
            cell.model = viewModel.cellModels[indexPath.row]
            
            return cell
        }
        return UITableViewCell()
    }
}
