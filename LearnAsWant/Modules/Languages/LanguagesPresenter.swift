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
    let languages: [TranslationLanguage]
    let forSourceLanguage: Bool
    
   init(
       view: LanguagesViewController,
       router: LanguagesRouter,
       languages: [TranslationLanguage],
       forSourceLanguage: Bool
   ) {
       self.view = view
       self.router = router
       self.languages = languages
       self.forSourceLanguage = forSourceLanguage

   }

   func viewDidLoad() {
       let title = forSourceLanguage ? Strings.MainScreen.menuFromTitle : Strings.MainScreen.menuToTitle
       
       view?.setupTitle(text: title)

       let models = languages.map { LanguageCellModel(model: $0) }
       let autoDetectModel = LanguageCellModel(model: .autoDetect)
       view?.showData(with: [autoDetectModel] + models)
   }

    func closeScreen() {
        router.closeScreen()
    }

    func languageSelected(model: LanguageCellModel) {
        Singleton.setupNewLanguage(model.model, isMain: forSourceLanguage)
        NotificationService.postMessage(for: forSourceLanguage ? .languageFromChanged : .languageToChanged)
        router.closeScreen()
    }
}
