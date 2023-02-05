//
//  MainScreenPresenter.swift
//  LearnAsWant
//
//  Created by Aleksey on 01.02.2023.
//
//

import UIKit

class MainScreenPresenter {
    
    private weak var view: MainScreenViewController?
    private let router: MainScreenRouter
    private var cellModels: [TranslatedCardCellModel] {
        return getCards().reversed().map { TranslatedCardCellModel(text: $0.text, translatedText: $0.translatedText) }
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
        setupMenuForButtons()
        NotificationService.addObserver(vc: self, selector: #selector(refreshScreen), for: .newCardAdded)
    }

    func viewDidAppear() {
        showOnboardingForFromLanguage()
    }

    func openAddTranslateScreen() {
        router.openAddTranslateScreen()
    }

    func openLanguagesScreen() {
        router.openLanguagesScreen()
    }

    private func setupTableData() {
        self.view?.showData(with: cellModels)

        let mainLanguage = Singleton.currentMainLanguage
        let secondaryLanguage = Singleton.currentSecondaryLanguage
        self.view?.setupData(mainLanguage: mainLanguage, secondaryLanguage: secondaryLanguage)
    }

    private func getCards() -> [CardModel] {
        let lastUsedLanguageString = UserDefaults.lastUsedLanguage ?? GlobalLanguage.russian.rawValue
        UserDefaults.lastUsedLanguage = lastUsedLanguageString
        let allExistedCards = UserDefaults.cards ?? [:]
        return allExistedCards[lastUsedLanguageString] ?? []
    }
}

extension MainScreenPresenter {
    @objc func refreshScreen() {
        setupTableData()
    }
}


extension MainScreenPresenter {

    private func setupMenuForButtons() {
        let menuFrom = UIMenu(title: Strings.MainScreen.menuFromTitle,
                                         children: createChildrenForMenu(languages: [.russian, .english]))

        let menuTo = UIMenu(title: Strings.MainScreen.menuToTitle,
                            children: createChildrenForMenu(languages: [.english, .russian]))

        self.view?.setupMenuForButton(isMain: true, menu: menuFrom)
        self.view?.setupMenuForButton(isMain: false, menu: menuTo)
    }

    private func createChildrenForMenu(languages: [GlobalLanguage]) -> [UIAction] {

        let image = UIImage(systemName: "icloud.and.arrow.down.fill")

        let actions: [UIAction] = languages.map { language in
            let action = UIAction(title: language.rawValue,
                                  image: image,
                                  attributes: [.keepsMenuPresented]) { [weak self] action in
                self?.menuLanguageAction(language)
            }

            return action
        }

        return actions
    }

    private func menuLanguageAction(_ language: GlobalLanguage) {
        print("language - " + language.rawValue)
    }
}

// MARK: - Onboarding.

extension MainScreenPresenter {

    private func showOnboardingForFromLanguage() {
        self.view?.showOnboardingForFromLanguage(with: "Please choose first language")

    }

    private func showOnboardingForToLanguage() {
        self.view?.showOnboardingForToLanguage(with: "Please choose second language")
    }
}
