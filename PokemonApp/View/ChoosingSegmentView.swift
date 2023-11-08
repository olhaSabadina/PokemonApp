//
//  PokemonSegmentControl.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 25.10.2023.
//

import Combine
import UIKit

class ChoosingSegmentView: UIView {
    
    private let titleButtons = ["About","Stats","Evolution","Moves"]
    private var stackView = UIStackView()
    
    @Published var selectedSegmentIndex = 0 {
        didSet {
            selectedButton()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSegment()
        setConstraint()
        selectedButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func pushButton(_ sender: UIButton) {
        selectedSegmentIndex = sender.tag
    }
    
    private func selectedButton() {
        stackView.arrangedSubviews.enumerated().forEach { index, button in
            guard let btn = button as? SegmentButton else {return}
            btn.selectButton(index == selectedSegmentIndex)
        }
    }
    
    private func setSegment() {
        titleButtons.enumerated().forEach { index,title in
            let button = SegmentButton(frame: .zero)
            button.setTitle(title, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(pushButton), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        addSubview(stackView)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}
