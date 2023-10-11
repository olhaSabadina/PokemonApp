//
//  UIView+Extension.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 11.10.2023.
//

import UIKit

extension UIView {
    func setShadow(colorShadow: UIColor, offset: CGSize, opacity: Float, radius: CGFloat, cornerRadius: CGFloat ) {
        layer.shadowColor = colorShadow.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.masksToBounds = false
        layer.cornerRadius = cornerRadius
    }
}
