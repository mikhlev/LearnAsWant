//
//  LanguagesPresenter.swift
//  LearnAsWant
//
//  Created by Aleksey on 02.02.2023.
//
//

import Foundation

class LanguagesPresenter {

   private weak var view: LanguagesViewController?
   private let router: LanguagesRouter

   init(
       view: LanguagesViewController,
       router: LanguagesRouter
   ) {
       self.view = view
       self.router = router
   }

   func viewDidLoad() {
   }
}
