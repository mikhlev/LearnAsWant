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

     func openAddTranslateScreen() {
         let model = TranslationModel(fromLanguage: .russian, toLanguage: .english)
         let addTranslateVC = AddTranslateAssembly(navigationController: navigationController,
                                                   translationModel: model).create()
         navigationController.present(addTranslateVC, animated: true)
     }

     func openLanguagesScreen() {
         let languagesVC = LanguagesAssembly(navigationController: navigationController).create()
         navigationController.present(languagesVC, animated: true)
     }
 }
