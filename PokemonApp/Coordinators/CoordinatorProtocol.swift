//
//  CoordinatorProtocol.swift
//  trainCoordinator
//
//  Created by Olga Sabadina on 03.11.2023.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    
    var childCoordinators: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController { get set }
    
    func start ()
}
