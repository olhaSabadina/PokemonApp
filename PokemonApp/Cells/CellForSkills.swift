//
//  CellForSkills.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 12.10.2023.
//

import UIKit

class CellForSkills: UITableViewCell {
    
    static var CellID = "CellForSkills"
    
    var skillsNameLabel = UILabel()
    var skillsDescriptionLabel = UILabel()
    var skillsStack = UIStackView()
    var skillsStackWithName = UIStackView()
    var model: SkillsCellModel? {
        didSet {
            configureCell()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setSkillsLabels()
        setSkillsStack()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        skillsNameLabel.text = ""
        skillsDescriptionLabel.text = ""
        for view in skillsStack.arrangedSubviews {
            skillsStack.removeArrangedSubview(view)
        }
    }
    
    private func configureCell() {
        guard let model = model else { return }
        skillsNameLabel.text = model.titleProperty
        skillsDescriptionLabel.text = model.valueProperty
        configureStack(count: model.attackPowerCount ?? 0)
    }
    
    private func configureStack(count: Int) {
        if model?.attackPowerCount != nil {
            for _ in 0..<count {
                let imageView = UIImageView(image: .checkmark)
                imageView.contentMode = .scaleAspectFit
                skillsStack.addArrangedSubview(imageView)
            }
        }
        skillsStack.addArrangedSubview(skillsDescriptionLabel)
        skillsDescriptionLabel.setContentHuggingPriority(.init(240), for: .horizontal)
    }
    
    private func setSkillsLabels() {
        skillsNameLabel.font = UIFont(name: FontsConstants.latoRegular, size: 15)
        skillsNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(skillsNameLabel)
        skillsDescriptionLabel.font = UIFont(name: FontsConstants.latoRegular, size: 15)
        skillsDescriptionLabel.textColor = UIColor(named: "CustomGray")
    }
    
    private func setSkillsStack() {
        skillsStack.axis = .horizontal
        skillsStack.spacing = 5
        skillsStack.distribution = .fill
        skillsStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(skillsStack)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            skillsNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            skillsNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            skillsNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            skillsNameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            
            skillsStack.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            skillsStack.leadingAnchor.constraint(equalTo: skillsNameLabel.trailingAnchor, constant: 10),
            skillsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            skillsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
        ])
    }
}
