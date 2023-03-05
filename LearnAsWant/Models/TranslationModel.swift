//
//  TranlsationModel.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.02.2023.
//

import Foundation

class TranslationModel: Codable {
    let id: Int
    var sourceLanguage: TranslationLanguage
    var targetLanguage: TranslationLanguage
    var fromText: String?
    var toText: String?

    init(id: Int,
         sourceLanguage: TranslationLanguage,
         targetLanguage: TranslationLanguage,
         fromText: String? = nil,
         toText: String? = nil)
    {
        self.id = id
        self.sourceLanguage = sourceLanguage
        self.targetLanguage = targetLanguage
        self.fromText = fromText
        self.toText = toText
    }
}
