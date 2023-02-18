//
//  LanguagesPresenter.swift
//  LearnAsWant
//
//  Created by Aleksey on 02.02.2023.
//
//

import Foundation

final class LanguagesPresenter {

    private weak var view: LanguagesViewController?
    private let router: LanguagesRouter

    private let forSourceLanguage: Bool

    private var languages: [TranslationLanguage] = [] {
        didSet {
            updateTable()
        }
    }

   init(
       view: LanguagesViewController,
       router: LanguagesRouter,
       forSourceLanguage: Bool
   ) {
       self.view = view
       self.router = router
       self.forSourceLanguage = forSourceLanguage

   }

    func viewDidLoad() {
        let title = forSourceLanguage ? Strings.MainScreen.menuFromTitle : Strings.MainScreen.menuToTitle
       
        view?.setupTitle(text: title)

        languages = TranslationService.shared.supportedLanguages
    }

    func closeScreen() {
        router.closeScreen()
    }

    func languageSelected(model: LanguageCellModel) {
        Singleton.setupNewLanguage(model.model, isMain: forSourceLanguage)
        NotificationService.postMessage(for: forSourceLanguage ? .languageFromChanged : .languageToChanged)
        router.closeScreen()
    }

    func updateTable(by searchText: String?) {
        var resultLanguages = TranslationService.shared.supportedLanguages

        if let searchText = searchText, !searchText.isEmpty {
            resultLanguages = resultLanguages.filter({ $0.name.lowercased().contains(searchText.lowercased()) })
        }
        languages = resultLanguages
    }
}

// MARK: - Private methods
extension LanguagesPresenter {
    private func updateTable() {
        let models = languages.map { LanguageCellModel(model: $0) }
        let autoDetectModel = LanguageCellModel(model: .autoDetect)
        view?.showData(with: [autoDetectModel] + models)
    }
}
