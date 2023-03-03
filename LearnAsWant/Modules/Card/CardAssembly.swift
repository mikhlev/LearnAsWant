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
     let models: [TranslationModel]

     init(navigationController: UINavigationController, models: [TranslationModel]) {
         self.navigationController = navigationController
         self.models = models
     }

     func create() -> CardViewController {
         let viewController = CardViewController()

    let router = CardRouter(navigationController: navigationController)
        let presenter = CardPresenter(view: viewController, router: router, models: models)
        viewController.presenter = presenter

        return viewController
    }
 }
