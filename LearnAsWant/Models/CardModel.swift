//
//  CardModel.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.02.2023.
//

import Foundation

struct CardModel: Codable {
    var text: String
    var translatedText: String

    init(text: String, translatedText: String) {
        self.text = text
        self.translatedText = translatedText
    }
}
