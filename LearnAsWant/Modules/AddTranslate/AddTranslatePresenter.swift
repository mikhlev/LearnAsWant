//
//  AddTranslatePresenter.swift
//  LearnAsWant
//
//  Created by Aleksey on 02.02.2023.
//
//

import Foundation

class AddTranslatePresenter {

   private weak var view: AddTranslateViewController?
   private let router: AddTranslateRouter

   init(
       view: AddTranslateViewController,
       router: AddTranslateRouter
   ) {
       self.view = view
       self.router = router
   }

   func viewDidLoad() {
   }
}
