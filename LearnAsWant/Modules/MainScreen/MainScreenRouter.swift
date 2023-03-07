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

     func openCardScreen(models: [TranslationModel]) {
         guard models.count > 0 else { return }
         let cardVC = CardAssembly(navigationController: navigationController, models: models).create()
         navigationController.present(cardVC, animated: true)
     }

     func openLanguagesScreen(forSource: Bool) {
         let languagesVC = LanguagesAssembly(navigationController: navigationController,
                                             forSourceLanguage: forSource).create()
         navigationController.present(languagesVC, animated: true)
     }
 }
