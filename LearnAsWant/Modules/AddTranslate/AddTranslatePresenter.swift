//
//  AddTranslatePresenter.swift
//  LearnAsWant
//
//  Created by Aleksey on 02.02.2023.
//
//

import Foundation

final class AddTranslatePresenter {

    private weak var view: AddTranslateViewController?
    private let router: AddTranslateRouter

    private var translationModel: TranslationModel

    init(
        view: AddTranslateViewController,
        router: AddTranslateRouter,
        translationModel: TranslationModel
    ) {
        self.view = view
        self.router = router
        self.translationModel = translationModel
    }

    func viewDidLoad() {
        self.view?.setupData(translationModel: translationModel)
    }

    func saveText() {

        let model = self.translationModel

        guard
            let text = model.fromText,
            let translatedText = model.toText
        else { return }

        let currentLanguage = Singleton.currentLanguageModel

        var allExistedCards = UserDefaults.cards ?? []

        UserDefaults.cards = allExistedCards
        
        NotificationService.postMessage(for: .newCardAdded)
        router.closeScreen()
    }

    private func updateModel(sourceText: String?, targetedText: String?) {
        translationModel.fromText = sourceText
        translationModel.toText = targetedText
    }
}

// MARK: - Navigation.

extension AddTranslatePresenter {
    func openLanguagesScreen(forSource: Bool) {
        router.openLanguagesScreen(forSource: forSource)
    }
}

// MARK: - Traslate methods.

extension AddTranslatePresenter {

    func translate(text: String, fromSourceLanguage: Bool) {
        guard !text.isEmpty else { return }
        
        TranslationService.shared.textToTranslate = text
        TranslationService.shared.targetLanguageCode = translationModel.targetLanguage.code

        // Check if it is language autodetect mode
        if translationModel.sourceLanguage.code == TranslationLanguage.autoDetect.code {
            translateWithDetectLanguage(text: text)
        } else {
            translateWithLanguage(translationModel.sourceLanguage, text: text)
        }
    }

    private func translateWithDetectLanguage(text: String) {
        // Check text language and setup as source language
        TranslationService.shared.detectLanguage(forText: text) { [weak self] (language) in
            guard
                let lang = TranslationService.shared.supportedLanguages.first(where: { $0.code == language })
            else { return }

            let name = lang.name

            DispatchQueue.main.async {
                self?.view?.setupSourceLanguage(name)
            }
            self?.translateWithLanguage(lang, text: text)
        }
    }

    private func translateWithLanguage(_ language: TranslationLanguage, text: String) {
        TranslationService.shared.translate { [weak self] translation in
            if let translation = translation {
                DispatchQueue.main.async {
                    self?.updateModel(sourceText: text, targetedText: translation)
                    self?.view?.setupTranslatedData(text: translation)
                }
            }
        }
    }

    func checkForLanguagesExistence() {

        if TranslationService.shared.supportedLanguages.count == 0 {
            self.fetchSupportedLanguages()
        }
    }

    func fetchSupportedLanguages() {
        // Show a "Please wait..." alert.
//        alertCollection.presentActivityAlert(withTitle: "Supported Languages", message: "Please wait while translation supported languages are being fetched...") { (presented) in

//            if presented {
                TranslationService.shared.fetchSupportedLanguages(completion: { (success) in
                    // Dismiss the alert.
//                    self.alertCollection.dismissAlert(completion: nil)

                    // Check if supported languages were fetched successfully or not.
                    if success {
                        // Display languages in the tableview.
                        DispatchQueue.main.async { [unowned self] in
//                            router.openLanguagesScreen(languages: TranslationService.shared.supportedLanguages)
                        }
                    } else {
                        // Show an alert saying that something went wrong.
//                        self.alertCollection.presentSingleButtonAlert(withTitle: "Supported Languages", message: "Oops! It seems that something went wrong and supported languages cannot be fetched.", buttonTitle: "OK", actionHandler: {
//
//                        })
                    }

                })
//            }

//        }
    }
}
