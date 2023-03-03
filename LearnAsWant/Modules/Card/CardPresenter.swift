//
//  CardPresenter.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.03.2023.
//
//

import Foundation

class CardPresenter {


    private weak var view: CardViewController?

    private let router: CardRouter

    private let models: [TranslationModel]

    init(
        view: CardViewController,
        router: CardRouter,
        models: [TranslationModel]
    ) {
        self.view = view
        self.router = router
        self.models = models
    }

    func viewDidLoad() {
        view?.setupCards(models: models)
    }
}
