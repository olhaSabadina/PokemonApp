//
//  SceneDelegate.swift
//  PokemonApp
//
//  Created by Olga Sabadina on 10.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let navigationVC = UINavigationController()
        coordinator = AppCoordinator(navigationController: navigationVC)
        coordinator?.start()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
    }
}

