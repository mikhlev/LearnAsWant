//
//  Singleton.swift
//  LearnAsWant
//
//  Created by Aleksey on 04.02.2023.
//

import Foundation

final class Singleton {

    static var googleAPIKey: String = ""

    static var currentLanguageModel: TranslationModel {
        if let language = UserDefaults.lastUsedLanguageModel {
            return language
        } else {
            let defaultModel = TranslationModel(sourceLanguage: .defaultEnglish, targetLanguage: .defaultSpanish)

            UserDefaults.lastUsedLanguageModel = defaultModel
            return defaultModel
        }
    }

    static func setupNewLanguage(_ language: TranslationLanguage, isMain: Bool) {
        let currentModel = self.currentLanguageModel

        let currentSourceLanguage = currentModel.sourceLanguage
        let currentTargetLanguage = currentModel.targetLanguage

        let newLanguageCode = language.code

        if
            isMain &&
            currentSourceLanguage.code == TranslationLanguage.autoDetect.code &&
            currentTargetLanguage.code == newLanguageCode
        {
            return
        }

        if
            (isMain && currentTargetLanguage.code == newLanguageCode) ||
            (!isMain && currentSourceLanguage.code == newLanguageCode)
        {
            // reverse model if language already set
            UserDefaults.lastUsedLanguageModel = TranslationModel(sourceLanguage: currentTargetLanguage,
                                                                  targetLanguage: currentSourceLanguage)
            return
        }


        if isMain {
            UserDefaults.lastUsedLanguageModel = TranslationModel(sourceLanguage: language,
                                                                  targetLanguage: currentTargetLanguage)
        } else {
            UserDefaults.lastUsedLanguageModel = TranslationModel(sourceLanguage: currentSourceLanguage,
                                                                  targetLanguage: language)
        }

        setupTranslationServiceOptions()
    }

    static func setupNewCard(sourceText: String, translatedText: String) {
        let currentLanguage = Singleton.currentLanguageModel

        var allExistedCards = UserDefaults.cards ?? []

        allExistedCards.append(TranslationModel(sourceLanguage: currentLanguage.sourceLanguage,
                                                targetLanguage: currentLanguage.targetLanguage,
                                                fromText: sourceText,
                                                toText: translatedText))

        UserDefaults.cards = allExistedCards

        NotificationService.postMessage(for: .newCardAdded)
    }

    private static func setupTranslationServiceOptions() {
        TranslationService.shared.sourceLanguageCode = Singleton.currentLanguageModel.sourceLanguage.code
        TranslationService.shared.targetLanguageCode = Singleton.currentLanguageModel.targetLanguage.code
    }

    static func setupGoogleApiKey() {
        if
            let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let apiKey = dict["API_KEY"] as? String {
                Singleton.googleAPIKey = apiKey
        }
    }
}
