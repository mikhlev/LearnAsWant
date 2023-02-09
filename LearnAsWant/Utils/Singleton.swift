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
            let defaultModel = TranslationModel(fromLanguage: .english, toLanguage: .spanish)

            UserDefaults.lastUsedLanguageModel = defaultModel
            return defaultModel
        }
    }

    static func setupNewLanguage(_ language: GlobalLanguage, isMain: Bool) {
        let currentModel = self.currentLanguageModel

        if (isMain && currentModel.toLanguage == language) || (!isMain && currentModel.fromLanguage == language) {

            UserDefaults.lastUsedLanguageModel = TranslationModel(fromLanguage: currentModel.toLanguage,
                                                                  toLanguage: currentModel.fromLanguage)
            return
        }

        if isMain {
            UserDefaults.lastUsedLanguageModel = TranslationModel(fromLanguage: language,
                                                                  toLanguage: currentModel.toLanguage)
        } else {
            UserDefaults.lastUsedLanguageModel = TranslationModel(fromLanguage: currentModel.fromLanguage,
                                                                  toLanguage: language)
        }
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
