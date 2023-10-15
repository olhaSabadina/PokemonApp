//
//  CellForPhrase.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 14.10.2023.
//

import UIKit

class CellForPhrase: UITableViewCell {
    
    static var CellID = "CellForPhrase"
    
    var phraseLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
        setPhraseLabel()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func configureCell() {
        phraseLabel.text = "dfgdfgh"
    }
    
    private func setPhraseLabel() {
        phraseLabel.textColor = .black
        phraseLabel.textAlignment = .left
        phraseLabel.numberOfLines = 0
        phraseLabel.font = UIFont(name: FontsConstants.latoRegular, size: 15)
        phraseLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(phraseLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            phraseLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            phraseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            phraseLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            phraseLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
}
