//
//  TranslatedCardCellModel.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.02.2023.
//

import Foundation

struct TranslatedCardCellModel: PTableViewCellModel {

    let languageModel: TranslationModel

    func configure(cell: TranslatedCardCell) {
        cell.setupData(fromText: languageModel.fromText, toText: languageModel.toText)
    }
}
