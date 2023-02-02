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
         let addTranslateVC = AddTranslateAssembly(navigationController: navigationController).create()
         navigationController.present(addTranslateVC, animated: true)
     }
 }
