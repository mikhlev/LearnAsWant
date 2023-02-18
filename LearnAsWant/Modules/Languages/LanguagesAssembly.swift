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
     let forSourceLanguage: Bool

     init(navigationController: UINavigationController, forSourceLanguage: Bool) {
         self.navigationController = navigationController
         self.forSourceLanguage = forSourceLanguage
     }

     func create() -> LanguagesViewController {
         let viewController = LanguagesViewController()

         let router = LanguagesRouter(navigationController: navigationController)
         let presenter = LanguagesPresenter(view: viewController,
                                            router: router,
                                            forSourceLanguage: forSourceLanguage)
         
         viewController.presenter = presenter

         return viewController
     }
 }
