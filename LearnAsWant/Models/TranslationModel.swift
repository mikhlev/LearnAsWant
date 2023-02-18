//
//  TranlsationModel.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.02.2023.
//

import Foundation

class TranslationModel: Codable {
    var sourceLanguage: TranslationLanguage
    var targetLanguage: TranslationLanguage
    var fromText: String?
    var toText: String?

    init(sourceLanguage: TranslationLanguage,
         targetLanguage: TranslationLanguage,
         fromText: String? = nil,
         toText: String? = nil)
    {
        self.sourceLanguage = sourceLanguage
        self.targetLanguage = targetLanguage
        self.fromText = fromText
        self.toText = toText
    }
}
