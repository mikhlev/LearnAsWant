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

    private let pageControl: UIPageControl = {
        let control = UIPageControl()
        control.hidesForSinglePage = true
        control.pageIndicatorTintColor = .lightGray
        control.currentPageIndicatorTintColor = .darkGray
        control.isUserInteractionEnabled = false
        return control
    }()

    private lazy var previousCardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .link
        return button
    }()

    private lazy var nextCardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .link
        return button
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        return button
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

        pageControl.numberOfPages = models.count

        models.forEach { model in

            let cardDetailsView = CardDetailsView()
            cardDetailsView.setupData(model: model)

            contentStack.addArrangedSubview(cardDetailsView)

            cardDetailsView.snp.makeConstraints { make in
                make.width.equalTo(self.view.frame.size.width)
            }
        }
    }

    private func setupActions() {
        self.previousCardButton.addTarget(self, action: #selector(showPreviousCard), for: .touchUpInside)
        self.nextCardButton.addTarget(self, action: #selector(showNextCard), for: .touchUpInside)
    }

    @objc private func showNextCard() {
        presenter.showNextCard()
    }

    @objc private func showPreviousCard() {
        presenter.showPreviousCard()
    }

    func scrollView(to page: Int) {
        self.scrollView.scrollTo(horizontalPage: page)
    }

    func updatePageControl(with page: Int) {
        self.pageControl.currentPage = page
    }
}

// MARK: - Setup UI.

extension CardViewController {
    private func setupViews() {

        setupActions()

        self.view.addSubviews(closeButton, scrollView, pageControl, previousCardButton, nextCardButton)
        self.scrollView.addSubview(contentStack)
    }

    private func setupConstraints() {
        closeButton.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.top.equalToSuperview().inset(20)
            make.right.equalToSuperview().inset(20)
        }

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(50)
            make.left.right.equalToSuperview()
        }

        contentStack.snp.makeConstraints { make in
            make.height.equalTo(scrollView.snp.height)
            make.top.bottom.left.right.equalToSuperview()
        }

        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scrollView.snp.bottom)
            make.height.equalTo(24)
        }

        previousCardButton.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(30)
            make.height.width.equalTo(56)
            //make.bottom.greaterThanOrEqualTo(self.view.safeAreaLayoutGuide.snp.bottom)//.inset(30)
        }

        nextCardButton.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(30)
            make.right.equalToSuperview().inset(30)
            make.height.width.equalTo(56)
            //make.bottom.greaterThanOrEqualToSuperview()//greaterThanOrEqualTo(self.view.safeAreaLayoutGuide.snp.bottom)//.inset(30)
        }
    }

}
