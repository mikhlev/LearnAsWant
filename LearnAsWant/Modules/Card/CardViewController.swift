//
//  CardViewController.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.03.2023.
//
//

import UIKit

final class CardViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()

    var presenter: CardPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground

        setupViews()
        setupConstraints()
        presenter.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    func setupCards(models: [TranslationModel]) {
        models.forEach { model in

            let cardDetailsView = CardDetailsView()
            cardDetailsView.setupData(model: model)

            contentStack.addArrangedSubview(cardDetailsView)

            cardDetailsView.snp.makeConstraints { make in
                make.width.equalTo(self.view.frame.size.width)
            }
        }
    }

    private func setupViews() {

        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentStack)
    }

    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }

        contentStack.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }



    }
}
