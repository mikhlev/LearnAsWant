//
//  AddTranslatePresenter.swift
//  LearnAsWant
//
//  Created by Aleksey on 02.02.2023.
//
//

import Foundation

class AddTranslatePresenter {

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

        var allExistedCards = UserDefaults.cards ?? [:]
        var array = allExistedCards[currentLanguage.fromLanguage.rawValue] ?? []

        array.append(TranslationModel(fromLanguage: currentLanguage.fromLanguage,
                                      toLanguage: currentLanguage.toLanguage,
                                      fromText: text,
                                      toText: translatedText))

        allExistedCards.updateValue(array, forKey: currentLanguage.fromLanguage.rawValue)
        UserDefaults.cards = allExistedCards
        
        NotificationService.postMessage(for: .newCardAdded)
        router.closeScreen()
    }

    private func updateModel(sourceText: String?, targetedText: String?) {
        translationModel.fromText = sourceText
        translationModel.toText = targetedText
    }
}

// MARK: - Traslate methods.

extension AddTranslatePresenter {

    func translate(text: String, fromSourceLanguage: Bool) {
        if text != "" {

            TranslationService.shared.textToTranslate = text
            TranslationService.shared.targetLanguageCode = translationModel.toLanguage.code

            TranslationService.shared.detectLanguage(forText: text) { [weak self] (language) in
                guard
                    let lang = TranslationService.shared.supportedLanguages.first(where: { $0.code == language }),
                    let name = lang.name
                else { return }

                DispatchQueue.main.async {
                    self?.view?.setupSourceLanguage(name)
                }

                TranslationService.shared.translate { translation in
                    if let translation = translation {
                        DispatchQueue.main.async {
                            self?.updateModel(sourceText: text, targetedText: translation)
                            self?.view?.setupTranslatedData(text: translation)
                        }
                    }
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
                            router.openLanguagesScreen(languages: TranslationService.shared.supportedLanguages)
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
