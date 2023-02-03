//
//  TranlsationModel.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.02.2023.
//

import Foundation
import MLKitTranslate

class TranslationModel {
    var fromLanguage: GlobalLanguage
    var toLanguage: GlobalLanguage
    var fromText: String?
    var toText: String?

    init(fromLanguage: GlobalLanguage, toLanguage: GlobalLanguage, fromText: String? = nil, toText: String? = nil) {
        self.fromLanguage = fromLanguage
        self.toLanguage = toLanguage
        self.fromText = fromText
        self.toText = toText
    }
}

enum GlobalLanguage: String {
    case russian = "Russian"
    case english = "English"

    var libraryName: TranslateLanguage {
        switch self {
        case .russian:
            return .russian
        case .english:
            return .english
        }
    }
}
