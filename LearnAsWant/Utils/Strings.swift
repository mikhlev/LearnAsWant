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
            switch Singleton.currentUsingLanguage {
            case .russian: return "Добавить"
            case .english: return "Add new"
            }
        }

        static var learnButtonButton: String {
            switch Singleton.currentUsingLanguage {
            case .russian: return "Повторить"
            case .english: return "Learn"
            }
        }
    }

    enum GlobalNotification: String {
        case newCardAdded
    }
}
