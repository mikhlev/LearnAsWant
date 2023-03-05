//
//  CardModel.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.02.2023.
//

import Foundation

final class CardsModel {

    static let shared = CardsModel()

    var cardList: [TranslationModel] {
        return UserDefaults.cards ?? []
    }

    func setupNewCard(sourceText: String, translatedText: String) {
        let currentLanguage = Singleton.currentLanguageModel

        var allExistedCards = UserDefaults.cards ?? []

        allExistedCards.append(TranslationModel(sourceLanguage: currentLanguage.sourceLanguage,
                                                targetLanguage: currentLanguage.targetLanguage,
                                                fromText: sourceText,
                                                toText: translatedText))

        UserDefaults.cards = allExistedCards

        NotificationService.postMessage(for: .newCardAdded)
    }

    func removeItem(_ card: TranslationModel) {
        var allExistedCards = UserDefaults.cards ?? []

        allExistedCards.removeAll { model in
            let result =
                model.sourceLanguage.code == card.sourceLanguage.code &&
                model.targetLanguage.code == card.targetLanguage.code &&
                model.fromText == card.fromText &&
                model.toText == card.toText

            return result
        }

        UserDefaults.cards = allExistedCards
        
        NotificationService.postMessage(for: .newCardAdded)
    }
}
