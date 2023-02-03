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

    private var tranlsationModel: TranlsationModel

    lazy var mainOptions = TranslatorOptions(sourceLanguage: tranlsationModel.fromLanguage.libraryName,
                                             targetLanguage: tranlsationModel.toLanguage.libraryName)

    lazy var reverseOptions = TranslatorOptions(sourceLanguage: tranlsationModel.toLanguage.libraryName,
                                                targetLanguage: tranlsationModel.fromLanguage.libraryName)

    lazy var mainTranslator = Translator.translator(options: mainOptions)
    lazy var reverseTranslator = Translator.translator(options: reverseOptions)

    init(
        view: AddTranslateViewController,
        router: AddTranslateRouter,
        tranlsationModel: TranlsationModel
    ) {
        self.view = view
        self.router = router
        self.tranlsationModel = tranlsationModel
    }

    func viewDidLoad() {
        self.view?.setupData(tranlsationModel: tranlsationModel)
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
