//
//  CardViewController.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.03.2023.
//
//

import UIKit

final class CardViewController: UIViewController {

    private let cardDetailsView = CardDetailsView()

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

    func setupDetails(model: TranslationModel) {
        cardDetailsView.setupData(model: model)
    }

    private func setupViews() {
        self.view.addSubview(cardDetailsView)
    }

    private func setupConstraints() {
        cardDetailsView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }

    }
}
