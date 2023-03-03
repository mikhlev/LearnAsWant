//
//  CardAssembly.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.03.2023.
//
//

import UIKit

 class CardAssembly {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func create() -> CardViewController {
        let viewController = CardViewController()

        let router = CardRouter(navigationController: navigationController)
        let presenter = CardPresenter(view: viewController, router: router)
        viewController.presenter = presenter

        return viewController
    }
 }
