//
//  AddTranslatePresenter.swift
//  LearnAsWant
//
//  Created by Aleksey on 02.02.2023.
//
//

import Foundation
import MLKitTranslate

class AddTranslatePresenter {

    private weak var view: AddTranslateViewController?
    private let router: AddTranslateRouter

    private var translationModel: TranslationModel

    lazy var mainOptions = TranslatorOptions(sourceLanguage: translationModel.fromLanguage.libraryName,
                                             targetLanguage: translationModel.toLanguage.libraryName)

    lazy var reverseOptions = TranslatorOptions(sourceLanguage: translationModel.toLanguage.libraryName,
                                                targetLanguage: translationModel.fromLanguage.libraryName)

    lazy var mainTranslator = Translator.translator(options: mainOptions)
    lazy var reverseTranslator = Translator.translator(options: reverseOptions)

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

    func saveText(model: TranslationModel?) {

        guard
            let model = model,
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
}

// MARK: - Traslate methods.

extension AddTranslatePresenter {
    func translateTextFromMainLanguage(translatedText: String?, completion: @escaping (String) -> Void) {
        guard let translatedText = translatedText else { return }

        mainTranslator.translate(translatedText) { text, error in
            guard error == nil else { return }
            completion(text ?? "")
        }
    }

    func translateTextToMainLanguage(translatedText: String?, completion: @escaping (String) -> Void) {
        guard let translatedText = translatedText else { return }

        reverseTranslator.translate(translatedText) { text, error in
            guard error == nil else { return }
            completion(text ?? "")
        }
    }
}
