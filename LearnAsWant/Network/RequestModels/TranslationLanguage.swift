//
//  TranslationLanguage.swift
//  LearnAsWant
//
//  Created by Aleksey on 17.02.2023.
//

import Foundation

struct TranslationLanguage: Codable {
    var code: String = ""
    var name: String = ""
}

extension TranslationLanguage {

    static var autoDetect: TranslationLanguage {
        return TranslationLanguage(code: "auto", name: "Auto detect")
    }

    static var defaultEnglish: TranslationLanguage {
        return TranslationLanguage(code: "en", name: "English")
    }

    static var defaultSpanish: TranslationLanguage {
        return TranslationLanguage(code: "es", name: "Spanish")
    }
}
