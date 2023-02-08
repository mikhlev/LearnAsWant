//
//  UserDefaults+Extensions.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.02.2023.
//
//
//  UserDefaultsExtension.swift
//  Latoken
//
//  Created by Diffco.us
//  Copyright © 2018 Diffco.us. All rights reserved.
//

import Foundation
import UIKit

extension UserDefaults {

    enum Keys: String {
        case cards
        case lastUsedLanguageModel
    }

    static var lastUsedLanguageModel: TranslationModel? {
        get {
            if let data = UserDefaults.standard.data(forKey: Keys.lastUsedLanguageModel.rawValue) {
                do {
                    return try JSONDecoder().decode(TranslationModel.self, from: data)
                } catch {
                    return nil
                }
            } else {
                return nil
            }
        }
        set {
            do {
                let encodedDictionary = try JSONEncoder().encode(newValue ?? TranslationModel(fromLanguage: .english, toLanguage: .spanish))
                print(encodedDictionary)
                UserDefaults.standard.set(encodedDictionary, forKey: Keys.lastUsedLanguageModel.rawValue)
            } catch {
                print("Error: ", error)
            }
        }
    }
    
    static var cards: [String: [CardModel]]? {
        get {
            if let data = UserDefaults.standard.data(forKey: Keys.cards.rawValue) {
                do {
                    return try JSONDecoder().decode([String: [CardModel]].self, from: data)
                } catch {
                    return [:]
                }
            } else {
                return [:]
            }
        }
        set {

            do {
                let encodedDictionary = try JSONEncoder().encode(newValue ?? [:])
                print(encodedDictionary)
                UserDefaults.standard.set(encodedDictionary, forKey: Keys.cards.rawValue)
            } catch {
                print("Error: ", error)
            }
        }
    }
}

// MARK: - Tranform [String] from/to Data

extension UserDefaults {


    func dictToData(dict: [String: Any]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: dict, options: [])
    }

    func dataToDict(data: Data) -> [String: Any]? {
        return (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any]
    }

    func stringArrayToData(stringArray: [String]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: stringArray, options: [])
    }

    func dataToStringArray(data: Data) -> [String]? {
        return (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String]
    }
}
