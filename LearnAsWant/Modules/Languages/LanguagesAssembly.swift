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
     let languages: [TranslationLanguage]
     let forSourceLanguage: Bool

     init(navigationController: UINavigationController, languages: [TranslationLanguage], forSourceLanguage: Bool) {
         self.navigationController = navigationController
         self.languages = languages
         self.forSourceLanguage = forSourceLanguage
     }

     func create() -> LanguagesViewController {
         let viewController = LanguagesViewController()

         let router = LanguagesRouter(navigationController: navigationController)
         let presenter = LanguagesPresenter(view: viewController,
                                            router: router,
                                            languages: languages,
                                            forSourceLanguage: forSourceLanguage)
         
         viewController.presenter = presenter

         return viewController
     }
 }
