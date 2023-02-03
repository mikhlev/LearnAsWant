//
//  File.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.02.2023.
//

import UIKit

struct LanguageCellModel: PTableViewCellModel {

    let text: String

    func configure(cell: LanguageCell) {
        cell.textLabel?.text = text
    }
}
