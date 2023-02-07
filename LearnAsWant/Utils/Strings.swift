//
//  Strings.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.02.2023.
//

import Foundation

enum Strings {

    enum MainScreen {
        static var addNewButton: String {
            return "Add new"
//            switch Singleton.currentMainLanguage {
//            case .russian: return "Добавить"
//            case .english: return "Add new"
//            }
        }

        static var learnButtonButton: String {
            return "Learn"
//            switch Singleton.currentMainLanguage {
//            case .russian: return "Повторить"
//            case .english: return "Learn"
//            }
        }

        static var menuFromTitle: String {
            return "Translate from"
//            switch Singleton.currentMainLanguage {
//            case .russian: return "Перевести с"
//            case .english: return "Translate from"
//            }
        }

        static var menuToTitle: String {
            return "Translate to"
//            switch Singleton.currentMainLanguage {
//            case .russian: return "Перевести на"
//            case .english: return "Translate to"
//            }
        }

    }

    enum GlobalNotification: String {
        case newCardAdded
        case languageFromChanged
        case languageToChanged
    }
}
