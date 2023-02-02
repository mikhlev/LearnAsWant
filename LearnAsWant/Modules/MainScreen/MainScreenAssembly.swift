//
//  MainScreenAssembly.swift
//  LearnAsWant
//
//  Created by Aleksey on 01.02.2023.
//
//

import UIKit

 class MainScreenAssembly {

    func create() -> UIViewController {
        let viewController = MainScreenViewController()

        let navigationController = UINavigationController(rootViewController: viewController)
        let router = MainScreenRouter(navigationController: navigationController)
        let presenter = MainScreenPresenter(view: viewController, router: router)
        viewController.presenter = presenter

        return navigationController
    }
 }
