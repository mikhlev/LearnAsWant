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

    private let model: TranslationModel

    init(
        view: CardViewController,
        router: CardRouter,
        model: TranslationModel
    ) {
        self.view = view
        self.router = router
        self.model = model
    }

    func viewDidLoad() {
        view?.setupDetails(model: model)
    }
}
