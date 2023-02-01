//
//  MainScreenAssembly.swift
//  LearnAsWant
//
//  Created by Aleksey on 01.02.2023.
//
//

import UIKit

 class MainScreenAssembly {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func create() -> MainScreenViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(
            identifier: String(describing: MainScreenViewController.self)
        ) as? MainScreenViewController else {
            preconditionFailure("Cannot create MainScreenViewController")
        }

        let router = MainScreenRouter(navigationController: navigationController)
        let presenter = MainScreenPresenter(view: viewController, router: router)
        viewController.presenter = presenter

        return viewController
    }
 }
