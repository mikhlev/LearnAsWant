//
//  File.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.02.2023.
//

import UIKit

struct LanguageCellModel: PTableViewCellModel {

    let model: TranslationLanguage

    func configure(cell: LanguageCell) {
        cell.setupData(title: model.name, isAutoDetectCell: model.code == TranslationLanguage.autoDetect.code)
    }
}
