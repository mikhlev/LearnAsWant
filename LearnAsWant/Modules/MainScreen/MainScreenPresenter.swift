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
//        showOnboardingForFromLanguage()
    }

    func openAddTranslateScreen() {
        router.openAddTranslateScreen()
    }

    func openLanguagesScreen() {
        router.openLanguagesScreen()
    }

    private func setupTableData() {
        self.view?.showData(with: cellModels)

        let mainLanguage = Singleton.currentLanguageModel.fromLanguage
        let secondaryLanguage = Singleton.currentLanguageModel.toLanguage
        self.view?.setupData(mainLanguage: mainLanguage, secondaryLanguage: secondaryLanguage)
    }

    private func getCards() -> [CardModel] {
        let lastUsedMainLanguageString = Singleton.currentLanguageModel.fromLanguage.rawValue
        let allExistedCards = UserDefaults.cards ?? [:]
        return allExistedCards[lastUsedMainLanguageString] ?? []
    }
}

extension MainScreenPresenter {
    @objc func refreshScreen() {
        setupTableData()
        setupMenuForButtons()
    }
}

extension MainScreenPresenter {

    private func setupMenuForButtons() {

        let menuFrom = UIMenu(title: Strings.MainScreen.menuFromTitle,
                              children: createChildrenForMenu(languages: GlobalLanguage.allCases, isMain: true))

        let menuTo = UIMenu(title: Strings.MainScreen.menuToTitle,
                            children: createChildrenForMenu(languages: GlobalLanguage.allCases, isMain: false))

        self.view?.setupMenuForButton(isMain: true, menu: menuFrom)
        self.view?.setupMenuForButton(isMain: false, menu: menuTo)
    }

    private func createChildrenForMenu(languages: [GlobalLanguage], isMain: Bool) -> [UIAction] {

        let image = UIImage(systemName: "icloud.and.arrow.down.fill")

        let currentLanguage = isMain ? Singleton.currentLanguageModel.fromLanguage : Singleton.currentLanguageModel.toLanguage


        let actions: [UIAction] = languages.map { language in
            let action = UIAction(title: language.rawValue,
                                  image: image,
                                  state: language == currentLanguage ? .on : .off)
            { [weak self] action in
                self?.menuLanguageAction(language, isMain: isMain)
            }
            return action
        }

        return actions
    }

    private func menuLanguageAction(_ language: GlobalLanguage, isMain: Bool) {
        Singleton.setupNewLanguage(language, isMain: isMain)
        refreshScreen()
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
