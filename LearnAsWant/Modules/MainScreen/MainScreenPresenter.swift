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
        addTranslateIsOpened ? hideTranslateView() : showTranslateView()
    }

    private func hideTranslateView() {
        addTranslateIsOpened = false
        view?.updateViewState(toShow: addTranslateIsOpened)
        self.view?.clearTranslateView()
    }

    private func showTranslateView() {
        addTranslateIsOpened = true
        view?.updateViewState(toShow: addTranslateIsOpened)
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


// MARK: - Add transalte.

extension MainScreenPresenter {
    func saveText(sourceText: String?, translatedText: String?) {

        guard
            let sourceText = sourceText,
            let translatedText = translatedText,
            !sourceText.isEmpty,
            !translatedText.isEmpty
        else { return }

        Singleton.setupNewCard(sourceText: sourceText, translatedText: translatedText)
        TranslationService.shared.clearTexts()
        self.hideTranslateView()
    }

    func translate(text: String?, fromSourceLanguage: Bool) {
        guard let text = text, !text.isEmpty else { return }

        TranslationService.shared.textToTranslate = text
        TranslationService.shared.targetLanguageCode = Singleton.currentLanguageModel.targetLanguage.code

        // Check if it is language autodetect mode
        if Singleton.currentLanguageModel.sourceLanguage.code == TranslationLanguage.autoDetect.code {
            translateWithDetectLanguage(text: text)
        } else {
            translateWithLanguage(Singleton.currentLanguageModel.sourceLanguage, text: text)
        }
    }

    private func translateWithDetectLanguage(text: String) {
//         Check text language and setup as source language
        TranslationService.shared.detectLanguage(forText: text) { [weak self] (language) in
            guard
                let lang = TranslationService.shared.supportedLanguages.first(where: { $0.code == language })
            else { return }

            let name = lang.name
            self?.translateWithLanguage(lang, text: text)
        }
    }

    private func translateWithLanguage(_ language: TranslationLanguage, text: String) {
        TranslationService.shared.translate { [weak self] translation in
            if let translation = translation {
                DispatchQueue.main.async {
                    self?.view?.setupTranslatedtext(text: translation)
                }
            }
        }
    }
}
