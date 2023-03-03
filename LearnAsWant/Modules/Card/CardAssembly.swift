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
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(
            identifier: String(describing: CardViewController.self)
        ) as? CardViewController else {
            preconditionFailure("Cannot create CardViewController")
        }

        let router = CardRouter(navigationController: navigationController)
        let presenter = CardPresenter(view: viewController, router: router)
        viewController.presenter = presenter

        return viewController
    }
 }
