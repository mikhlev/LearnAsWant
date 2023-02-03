//
//  LanguagesAssembly.swift
//  LearnAsWant
//
//  Created by Aleksey on 02.02.2023.
//
//

import UIKit

 class LanguagesAssembly {

     let navigationController: UINavigationController

     init(navigationController: UINavigationController) {
         self.navigationController = navigationController
     }

     func create() -> LanguagesViewController {
         let viewController = LanguagesViewController()

         let router = LanguagesRouter(navigationController: navigationController)
         let presenter = LanguagesPresenter(view: viewController, router: router)
         viewController.presenter = presenter

         return viewController
     }
 }
