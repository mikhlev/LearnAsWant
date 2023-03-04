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

    private var currentShowCardIndex: Int = 0

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

    func showNextCard() {
        guard currentShowCardIndex >= 0, currentShowCardIndex < models.count - 1 else { return }
        currentShowCardIndex += 1
        updateScroll()
    }

    func showPreviousCard() {
        guard currentShowCardIndex > 0, currentShowCardIndex < models.count else { return }
        currentShowCardIndex -= 1
        updateScroll()
    }

    private func updateScroll() {
        view?.scrollView(to: currentShowCardIndex)
        view?.updatePageControl(with: currentShowCardIndex)
    }
}
