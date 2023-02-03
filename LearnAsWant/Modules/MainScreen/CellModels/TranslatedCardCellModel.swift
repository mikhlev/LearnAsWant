//
//  TranslatedCardCellModel.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.02.2023.
//

import Foundation

struct TranslatedCardCellModel: PTableViewCellModel {

    let text: String
    let translatedText: String

    func configure(cell: TranslatedCardCell) {
        cell.setupData(text: text, translatedText: translatedText)
    }
}
