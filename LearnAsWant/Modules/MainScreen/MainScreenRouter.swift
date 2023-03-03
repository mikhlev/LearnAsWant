//
//  MainScreenRouter.swift
//  LearnAsWant
//
//  Created by Aleksey on 01.02.2023.
//
//

import UIKit

 class MainScreenRouter {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

     func openAddTranslateScreen(model: TranslationModel) {
         let addTranslateVC = AddTranslateAssembly(navigationController: navigationController,
                                                   translationModel: model).create()
         navigationController.present(addTranslateVC, animated: true)
     }

     func openCardScreen(models: [TranslationModel]) {
         let cardVC = CardAssembly(navigationController: navigationController, models: models).create()
         navigationController.present(cardVC, animated: true)
     }

     func openLanguagesScreen(forSource: Bool) {
         let languagesVC = LanguagesAssembly(navigationController: navigationController,
                                             forSourceLanguage: forSource).create()
         navigationController.present(languagesVC, animated: true)
     }
 }
