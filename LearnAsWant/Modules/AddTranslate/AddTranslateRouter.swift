//
//  AddTranslateRouter.swift
//  LearnAsWant
//
//  Created by Aleksey on 02.02.2023.
//
//

import UIKit

 class AddTranslateRouter {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

     func closeScreen() {
         navigationController.dismiss(animated: true)
     }
 }
