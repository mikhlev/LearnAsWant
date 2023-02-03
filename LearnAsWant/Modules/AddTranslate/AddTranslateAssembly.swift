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

     var tranlsationModel: TranlsationModel

     init(navigationController: UINavigationController, tranlsationModel: TranlsationModel) {
         self.navigationController = navigationController
         self.tranlsationModel = tranlsationModel
     }

     func create() -> AddTranslateViewController {
         let viewController = AddTranslateViewController()

         let router = AddTranslateRouter(navigationController: navigationController)
         let presenter = AddTranslatePresenter(view: viewController, router: router, tranlsationModel: tranlsationModel)
         viewController.presenter = presenter

         return viewController
    }
 }
