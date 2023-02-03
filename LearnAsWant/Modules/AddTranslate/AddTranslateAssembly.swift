//
//  AddTranslateAssembly.swift
//  LearnAsWant
//
//  Created by Aleksey on 02.02.2023.
//
//

import UIKit
import MLKitTranslate

 class AddTranslateAssembly {

     let navigationController: UINavigationController

     var translationModel: TranslationModel

     init(navigationController: UINavigationController,
          translationModel: TranslationModel) {
         self.navigationController = navigationController
         self.translationModel = translationModel
     }

     func create() -> AddTranslateViewController {
         let viewController = AddTranslateViewController()

         let router = AddTranslateRouter(navigationController: navigationController)
         let presenter = AddTranslatePresenter(view: viewController, router: router, translationModel: translationModel)
         viewController.presenter = presenter
         return viewController
    }
 }
