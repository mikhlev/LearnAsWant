//
//  TranslationAPI.swift
//  LearnAsWant
//
//  Created by Aleksey on 09.02.2023.
//

import Foundation

enum TranslationAPI {
    case detectLanguage
    case translate
    case supportedLanguages

    func getURL() -> String {
            var urlString = ""

            switch self {
            case .detectLanguage:
                urlString = "https://translation.googleapis.com/language/translate/v2/detect"

            case .translate:
                urlString = "https://translation.googleapis.com/language/translate/v2"

            case .supportedLanguages:
                urlString = "https://translation.googleapis.com/language/translate/v2/languages"
            }

            return urlString
        }

    func getHTTPMethod() -> String {
        switch self {
        case .detectLanguage, .translate:
            return "POST"
        case .supportedLanguages:
            return "GET"
        }
    }
}
