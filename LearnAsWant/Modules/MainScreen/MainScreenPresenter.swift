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
    private var cardCellModels: [TranslatedCardCellModel] {
        return model.cardList
            .reversed()
            .map { TranslatedCardCellModel(translationModel: $0) }
    }

    private var addTranslateIsOpened: Bool = false

    private let model = CardsModel.shared

    private var autoDetectedLanguage: TranslationLanguage?

    private var autoDetectedModeisOn: Bool {
        return Singleton.currentLanguageModel.sourceLanguage.code == TranslationLanguage.autoDetect.code
    }

    init(
        view: MainScreenViewController,
        router: MainScreenRouter
    ) {
        self.view = view
        self.router = router
    }

    func viewDidLoad() {
        setupScreenData()
        checkForLanguagesExistence()
        NotificationService.addObserver(vc: self, selector: #selector(refreshScreen), for: .newCardAdded)
        NotificationService.addObserver(vc: self, selector: #selector(refreshScreen), for: .languageChanged)
    }

    private func setupScreenData() {

        let tableCells: [PTableViewCellAnyModel] = cardCellModels.isEmpty ? [OnboardingCellModel()] : cardCellModels
        let tableContentTopOffset: CGFloat = cardCellModels.isEmpty ? 0 : 20

        self.view?.updateOnboardingLineState(isHidden: !cardCellModels.isEmpty)
        self.view?.updateLearnButtonState(isEnabled: !cardCellModels.isEmpty)

        self.view?.showData(with: tableCells)
        self.view?.setupTableContentOffset(top: tableContentTopOffset)

        self.view?.setupData(sourceLanguage: Singleton.currentLanguageModel.sourceLanguage,
                             targetLanguage: Singleton.currentLanguageModel.targetLanguage)
    }

    func updateTranslateViewState() {
        addTranslateIsOpened ? hideTranslateView() : showTranslateView()
    }

    private func hideTranslateView() {
        addTranslateIsOpened = false
        view?.updateAddTranslateViewState(toShow: addTranslateIsOpened)
        self.view?.clearTranslateView()
    }

    private func showTranslateView() {
        addTranslateIsOpened = true
        view?.updateAddTranslateViewState(toShow: addTranslateIsOpened)
    }
}

extension MainScreenPresenter {
    @objc func refreshScreen() {
        setupScreenData()

        if addTranslateIsOpened {
            refreshTranslate()
        }
    }

    func openLanguagesScreen(forSource: Bool) {
        router.openLanguagesScreen(forSource: forSource)
    }

    func openAllCardsScreen() {
        router.openCardScreen(models: model.cardList.reversed())
    }

    func openCardScreen(index: Int) {
        router.openCardScreen(models: [model.cardList.reversed()[index]])
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

        let auto = autoDetectedModeisOn ? autoDetectedLanguage : nil
        model.setupNewCard(autodetectedLanguage: auto, sourceText: sourceText, translatedText: translatedText)
        TranslationService.shared.clearTexts()
        self.hideTranslateView()
    }

    func translate(text: String?, fromSourceLanguage: Bool) {
        guard let text = text, !text.isEmpty else { return }

        TranslationService.shared.textToTranslate = text
        TranslationService.shared.targetLanguageCode = Singleton.currentLanguageModel.targetLanguage.code

        // Check if it is language autodetect mode
        if Singleton.currentLanguageModel.sourceLanguage.code == TranslationLanguage.autoDetect.code {
            translateWithDetectedLanguage(text: text)
        } else {
            translateWithLanguage(Singleton.currentLanguageModel.sourceLanguage)
        }
    }

    private func translateWithDetectedLanguage(text: String) {
        // Check text language and setup as source language
        TranslationService.shared.detectLanguage(forText: text) { [weak self] (language) in
            guard
                let lang = TranslationService.shared.supportedLanguages.first(where: { $0.code == language })
            else { return }

            self?.autoDetectedLanguage = lang
            self?.translateWithLanguage(lang)
        }
    }

    private func translateWithLanguage(_ language: TranslationLanguage) {
        TranslationService.shared.translate { [weak self] translation in
            self?.setupTranslatedText(translation)
        }
    }

    private func refreshTranslate() {
        TranslationService.shared.refreshTranslate {[weak self] translation in
            self?.setupTranslatedText(translation)
        }
    }

    private func setupTranslatedText(_ text: String?) {
        if let translation = text, addTranslateIsOpened {
            DispatchQueue.main.async {
                self.view?.setupTranslatedText(translation)
            }
        }
    }
}
