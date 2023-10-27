//
//  CellForSkills.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 12.10.2023.
//

import UIKit

class CellForSkills: UITableViewCell {
    
    static var cellID = "CellForSkills"
    
    private let skillsStackImage = UIImage(named: "Vector")
    private var skillsNameLabel = UILabel()
    private var skillsDescriptionLabel = UILabel()
    private var skillsStack = UIStackView()
    private var skillsStackWithName = UIStackView()
    private var isTitlePresent: Bool {
        skillsCellModel?.titleProperty != nil
    }
    var skillsCellModel: SkillsCellModel? {
        didSet {
            configureCell()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setLabels()
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
        skillsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        skillsStackWithName.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    //MARK: -  Private function:
    
    private func configureCell() {
        guard let model = skillsCellModel else { return }
        skillsNameLabel.text = model.titleProperty
        skillsDescriptionLabel.text = model.valueProperty
        configureStack(count: model.attackPowerCount)
    }
    
    private func configureStack(count: Int) {
        
        if skillsCellModel?.titleProperty != nil {
            skillsStackWithName.addArrangedSubview(skillsNameLabel)
            skillsNameLabel.widthAnchor.constraint(equalToConstant: 110).isActive = true
        }
        skillsStackWithName.addArrangedSubview(skillsStack)
        if count != 0 {
            for _ in 0..<count {
                let imageView = UIImageView(image: skillsStackImage)
                imageView.contentMode = .scaleAspectFit
                skillsStack.addArrangedSubview(imageView)
            }
        }
        skillsStack.addArrangedSubview(skillsDescriptionLabel)
        skillsDescriptionLabel.setContentHuggingPriority(.init(240), for: .horizontal)
    }
    
    private func setLabels() {
        skillsNameLabel.font = UIFont(name: FontsConstants.latoRegular, size: 13)
        skillsDescriptionLabel.font = UIFont(name: FontsConstants.latoRegular, size: 13)
        skillsDescriptionLabel.textColor = UIColor(named: "CustomGray")
        skillsDescriptionLabel.numberOfLines = 0
    }
    
    private func setSkillsStack() {
        skillsStack.axis = .horizontal
        skillsStack.spacing = 5
        skillsStack.distribution = .fill
       
        skillsStackWithName.axis = .horizontal
        skillsStackWithName.translatesAutoresizingMaskIntoConstraints = false
        skillsStackWithName.spacing = 15
        addSubview(skillsStackWithName)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            skillsStackWithName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            skillsStackWithName.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            skillsStackWithName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            skillsStackWithName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
}
