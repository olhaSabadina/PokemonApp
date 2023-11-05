//
//  ViewController+Alert.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 26.10.2023.
//

import UIKit

extension UIViewController {
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Attention!", message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default)
        alert.addAction(actionOk)
        self.present(alert, animated: true)
    }
    
}
