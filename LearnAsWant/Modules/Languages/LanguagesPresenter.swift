//
//  LanguagesPresenter.swift
//  LearnAsWant
//
//  Created by Aleksey on 02.02.2023.
//
//

import Foundation
import MLKitTranslate

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
       let languagesList = Array(TranslateLanguage.allLanguages()).sorted(by: { $0.rawValue > $1.rawValue })
       view?.showData(with: languagesList.map { LanguageCellModel(text: $0.rawValue) })
   }
}
