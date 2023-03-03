//
//  CardModel.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.02.2023.
//

import Foundation

struct CardsModel {

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
}
