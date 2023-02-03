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
    private var cellModels: [TranslatedCardCellModel] {
        return getCards().map { TranslatedCardCellModel(text: $0.text, translatedText: $0.translatedText) }
    }

    init(
        view: MainScreenViewController,
        router: MainScreenRouter
    ) {
        self.view = view
        self.router = router
    }

    func viewDidLoad() {
        setupTableData()
    }

    func openAddTranslateScreen() {
        router.openAddTranslateScreen()
    }

    func openLanguagesScreen() {
        router.openLanguagesScreen()
    }

    private func setupTableData() {
        self.view?.showData(with: cellModels)
    }

    private func getCards() -> [CardModel] {
        let lastUsedLanguageString = UserDefaults.lastUsedLanguage ?? GlobalLanguage.russian.rawValue
        UserDefaults.lastUsedLanguage = lastUsedLanguageString
        let allExistedCards = UserDefaults.cards ?? [:]
        return allExistedCards[lastUsedLanguageString] ?? []
    }
}

extension MainScreenPresenter: MainRefresh {
    func refreshScreen() {
        setupTableData()
    }
}

protocol MainRefresh: AnyObject {
    func refreshScreen()
}
