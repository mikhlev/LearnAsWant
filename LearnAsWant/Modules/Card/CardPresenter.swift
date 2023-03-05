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

    private var models: [TranslationModel]

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
        view?.setPageControlNumberOfPages(models.count)
    }

    func deleteCurrentItem() {

        CardsModel.shared.removeItem(models[currentShowCardIndex])

        guard
            models.count > 1
        else {
            router.closeScreen()
            return
        }

        models.remove(at: currentShowCardIndex)
        view?.removeCard(index: currentShowCardIndex)

        if currentShowCardIndex == models.count {
            currentShowCardIndex -= 1
        }

        view?.setPageControlNumberOfPages(models.count)
    }

    func closeScreen() {
        router.closeScreen()
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
