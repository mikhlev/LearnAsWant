//
//  MainScreenPresenter.swift
//  LearnAsWant
//
//  Created by Aleksey on 01.02.2023.
//
//

import Foundation

class MainScreenPresenter {

   private weak var view: MainScreenViewController?
   private let router: MainScreenRouter

   init(
       view: MainScreenViewController,
       router: MainScreenRouter
   ) {
       self.view = view
       self.router = router
   }

   func viewDidLoad() {
   }
}
