//
//  AddTranslateAssembly.swift
//  LearnAsWant
//
//  Created by Aleksey on 02.02.2023.
//
//

import UIKit

 class AddTranslateAssembly {
    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func create() -> AddTranslateViewController {
        let viewController = AddTranslateViewController()

        let router = AddTranslateRouter(navigationController: navigationController)
        let presenter = AddTranslatePresenter(view: viewController, router: router)
        viewController.presenter = presenter

        return viewController
    }
 }
