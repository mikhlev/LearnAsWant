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
     let model: TranslationModel

     init(navigationController: UINavigationController, model: TranslationModel) {
         self.navigationController = navigationController
         self.model = model
     }

     func create() -> CardViewController {
         let viewController = CardViewController()

    let router = CardRouter(navigationController: navigationController)
        let presenter = CardPresenter(view: viewController, router: router, model: model)
        viewController.presenter = presenter

        return viewController
    }
 }
