//
//  ListCell.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 10.10.2023.
//

import UIKit
import SDWebImage

class ListCell: UICollectionViewCell {

    static var CellID = "FirstScreenVCColletyionCell"
    
    private let imageView = UIImageView()
    private var nameLabel = UILabel()
    private var skillsLabel = UILabel()
    private var stack = UIStackView()
    var pokemon: PokemonModel? {
        didSet {
            updateCell()
        }
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        configureCell()
        setLabels()
        setImageView()
        setStack()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        skillsLabel.text = ""
        imageView.image = nil
        
    }
    //MARK: -  Private function:
    
    private func updateCell() {
        nameLabel.text = pokemon?.name.uppercased()
        skillsLabel.text = pokemon?.species.name
        guard let imageString = pokemon?.sprites.frontDefault,
              let urlImage = URL(string: imageString) else {
            return
        }
        imageView.sd_setImage(with: urlImage)
    }
    
    private func configureCell() {
        backgroundColor = .systemBackground
        setShadow(colorShadow: .gray,
                  offset: .init(width: 5, height: 5),
                  opacity: 5,
                  radius: 5,
                  cornerRadius: 5)
    }
    
    private func setLabels() {
        let labels = [nameLabel, skillsLabel]
        labels.forEach { label in
            label.textAlignment = .left
            label.numberOfLines = 0
        }
        nameLabel.font = UIFont(name: FontsConstants.latoBold, size: 13)
        nameLabel.textColor = .red
        skillsLabel.font = UIFont(name: FontsConstants.latoRegular, size: 11)
        skillsLabel.textColor = UIColor(named: "CustomGray")
    }
    
    private func setStack() {
        stack = UIStackView(arrangedSubviews: [nameLabel, skillsLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fillEqually
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
    }
    
    private func setImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
    }
    
    //MARK: - Constraints:
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            stack.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 15),
            
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.65),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
        ])
    }
}
