//
//  TranslatedCardCellModel.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.02.2023.
//

import Foundation

struct TranslatedCardCellModel: PTableViewCellModel {

    let translationModel: TranslationModel

    func configure(cell: TranslatedCardCell) {
        cell.setupData(translationModel: translationModel)
    }
}
