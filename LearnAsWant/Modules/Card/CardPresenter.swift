//
//  CardPresenter.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.03.2023.
//
//

import Foundation

class CardPresenter {

   private weak var view: CardViewController?
   private let router: CardRouter

   init(
       view: CardViewController,
       router: CardRouter
   ) {
       self.view = view
       self.router = router
   }

   func viewDidLoad() {
   }
}
