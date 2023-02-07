//
//  Singleton.swift
//  LearnAsWant
//
//  Created by Aleksey on 04.02.2023.
//

import Foundation

final class Singleton {
    static var currentMainLanguage: GlobalLanguage {
        let languageString = UserDefaults.lastUsedLanguage ?? ""
        return GlobalLanguage(rawValue: languageString) ?? .russian
    }

    static var currentSecondaryLanguage: GlobalLanguage {
        let languageString = UserDefaults.lastUsedSecondaryLanguage ?? ""
        return GlobalLanguage(rawValue: languageString) ?? .russian
    }
}
