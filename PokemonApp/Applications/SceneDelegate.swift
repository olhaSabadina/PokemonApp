//
//  SceneDelegate.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 10.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let startVC = ListViewController()
        let navigationVC = UINavigationController(rootViewController: startVC)
     
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
    }
}

