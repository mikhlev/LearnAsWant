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

    func setupNewCard(autodetectedLanguage: TranslationLanguage?, sourceText: String, translatedText: String) {
        let currentLanguage = Singleton.currentLanguageModel

        var allExistedCards = UserDefaults.cards ?? []

        allExistedCards.append(TranslationModel(id: Int.random(in: 1...1_000_000),
                                                sourceLanguage: autodetectedLanguage ?? currentLanguage.sourceLanguage,
                                                targetLanguage: currentLanguage.targetLanguage,
                                                fromText: sourceText,
                                                toText: translatedText))

        UserDefaults.cards = allExistedCards

        NotificationService.postMessage(for: .newCardAdded)
    }

    func removeItem(_ card: TranslationModel) {
        var allExistedCards = UserDefaults.cards ?? []

        allExistedCards.removeAll { model in
            return model.id == card.id
        }

        UserDefaults.cards = allExistedCards
        
        NotificationService.postMessage(for: .newCardAdded)
    }
}
