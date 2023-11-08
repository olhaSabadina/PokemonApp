//
//  SegmentButton.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 25.10.2023.
//

import UIKit

class SegmentButton: UIButton {
    
    private let redLine = UIView()
    private let grayLine = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectButton(_ isSelect: Bool) {
        self.redLine.isHidden = !isSelect
        setTitleColor(!isSelect ? .label : .red, for: .normal)
    }
    
    private func setButton() {
        redLine.backgroundColor = .red
        grayLine.backgroundColor = .lightGray.withAlphaComponent(0.5)
        redLine.translatesAutoresizingMaskIntoConstraints = false
        grayLine.translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = .systemFont(ofSize: 13)
        addSubview(grayLine)
        addSubview(redLine)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            grayLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            grayLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            grayLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            grayLine.heightAnchor.constraint(equalToConstant: 2),
            
            redLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            redLine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            redLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            redLine.heightAnchor.constraint(equalToConstant: 2),
        ])
    }
}
