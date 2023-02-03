//
//  MainScreenAssembly.swift
//  LearnAsWant
//
//  Created by Aleksey on 01.02.2023.
//
//

import UIKit

class MainScreenAssembly {

    func create() -> UINavigationController {
        let viewController = MainScreenViewController()

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.isHidden = true

        let router = MainScreenRouter(navigationController: navigationController)
        let presenter = MainScreenPresenter(view: viewController, router: router)
        viewController.presenter = presenter

        return navigationController
    }
 }
