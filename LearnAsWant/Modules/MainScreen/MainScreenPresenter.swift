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
        return getCards()
            .reversed()
            .map { TranslatedCardCellModel(languageModel: $0) }
    }

    private var addTranslateIsOpened: Bool = false

    init(
        view: MainScreenViewController,
        router: MainScreenRouter
    ) {
        self.view = view
        self.router = router
    }

    func viewDidLoad() {
        setupTableData()
        checkForLanguagesExistence()
        NotificationService.addObserver(vc: self, selector: #selector(refreshScreen), for: .newCardAdded)
        NotificationService.addObserver(vc: self, selector: #selector(refreshScreen), for: .languageFromChanged)
        NotificationService.addObserver(vc: self, selector: #selector(refreshScreen), for: .languageToChanged)
    }

    func viewDidAppear() {
//        showOnboardingForsourceLanguage()
    }

    func openAddTranslateScreen() {
        router.openAddTranslateScreen(model: Singleton.currentLanguageModel)
    }

    func openAddTranslateScreenForCell(row: Int) {
        guard row < cellModels.count else { return }
        router.openAddTranslateScreen(model: cellModels[row].languageModel)
    }

    private func setupTableData() {
        self.view?.showData(with: cellModels)
        self.view?.setupData(sourceLanguage: Singleton.currentLanguageModel.sourceLanguage,
                             targetLanguage: Singleton.currentLanguageModel.targetLanguage)
    }

    private func getCards() -> [TranslationModel] {
        let lastUsedMainLanguageString = Singleton.currentLanguageModel.sourceLanguage.code
        let allExistedCards = UserDefaults.cards ?? [:]
        return allExistedCards[lastUsedMainLanguageString] ?? []
    }

    func updateTranslateViewState() {
        addTranslateIsOpened.toggle()
        view?.animateUpdateTranslateView(toShow: addTranslateIsOpened)
    }
}

extension MainScreenPresenter {
    @objc func refreshScreen() {
        setupTableData()
    }

    func openLanguagesScreen(forSource: Bool) {
        router.openLanguagesScreen(forSource: forSource)
    }
}

extension MainScreenPresenter {

//    private func setupMenuForButtons() {
//
//        let menuFrom = UIMenu(title: Strings.MainScreen.menuFromTitle,
//                              children: createChildrenForMenu(languages: GlobalLanguage.allCases, isMain: true))
//
//        let menuTo = UIMenu(title: Strings.MainScreen.menuToTitle,
//                            children: createChildrenForMenu(languages: GlobalLanguage.allCases, isMain: false))
//
//        self.view?.setupMenuForButton(isMain: true, menu: menuFrom)
//        self.view?.setupMenuForButton(isMain: false, menu: menuTo)
//    }
//
//    private func createChildrenForMenu(languages: [GlobalLanguage], isMain: Bool) -> [UIAction] {
//
//        let image = UIImage(systemName: "icloud.and.arrow.down.fill")
//
//        let currentLanguage = isMain ? Singleton.currentLanguageModel.sourceLanguage : Singleton.currentLanguageModel.targetLanguage
//
//
//        let actions: [UIAction] = languages.map { language in
//            let action = UIAction(title: language.rawValue,
//                                  image: image,
//                                  state: language == currentLanguage ? .on : .off)
//            { [weak self] action in
//                self?.menuLanguageAction(language, isMain: isMain)
//            }
//            return action
//        }
//
//        return actions
//    }
//
// 
}

// MARK: - Onboarding.

extension MainScreenPresenter {

    private func showOnboardingForsourceLanguage() {
        self.view?.showOnboardingForsourceLanguage(with: "Please choose first language")

    }

    private func showOnboardingFortargetLanguage() {
        self.view?.showOnboardingFortargetLanguage(with: "Please choose second language")
    }
}

extension MainScreenPresenter {
    func checkForLanguagesExistence() {
        if TranslationService.shared.supportedLanguages.count == 0 {
            self.fetchSupportedLanguages()
        }
    }

    func fetchSupportedLanguages() {
        TranslationService.shared.fetchSupportedLanguages(completion: { (success) in
                    if success {
                        // Display languages in the tableview.
//                        DispatchQueue.main.async { [unowned self] in
//                            router.openLanguagesScreen(languages: TranslationService.shared.supportedLanguages)
//                        }
                    } else {
                        // Show an alert saying that something went wrong.
//                        self.alertCollection.presentSingleButtonAlert(withTitle: "Supported Languages", message: "Oops! It seems that something went wrong and supported languages cannot be fetched.", buttonTitle: "OK", actionHandler: {
//
//                        })
                    }

                })
    }
}
