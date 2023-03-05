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
        control.pageIndicatorTintColor = .systemGray3
        control.currentPageIndicatorTintColor = .systemGray
        control.isUserInteractionEnabled = false
        return control
    }()

    private lazy var previousCardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left.circle"), for: .normal)
        button.tintColor = .link
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        return button
    }()

    private lazy var nextCardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right.circle"), for: .normal)
        button.tintColor = .link

        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        return button
    }()

    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.tintColor = .link
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.showsMenuAsPrimaryAction = true
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
        self.closeButton.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
    }

    @objc private func showNextCard() {
        presenter.showNextCard()
    }

    @objc private func showPreviousCard() {
        presenter.showPreviousCard()
    }

    @objc private func closeScreen() {
        presenter.closeScreen()
    }

    func scrollView(to page: Int) {
        self.scrollView.scrollTo(horizontalPage: page)
        self.scrollView.layoutIfNeeded()
    }

    private func deleteCurrentItem() {
        presenter.deleteCurrentItem()
    }

    func removeCard(index: Int) {
        let subviewForRemove = contentStack.arrangedSubviews[index]
        contentStack.removeArrangedSubview(subviewForRemove)
        subviewForRemove.removeFromSuperview()
    }


}

//MARK: - Menu button.

extension CardViewController {
    private func createMenuButton() {

        let delete = UIAction(title: "Remove",
                              image: UIImage(systemName: "trash"),
                              attributes: .destructive) {[weak self] _ in
            self?.deleteCurrentItem()
        }


        let menu = UIMenu(children: [delete])

        self.settingsButton.menu = menu
    }
}

//MARK: - Page control.

extension CardViewController {

    func updatePageControl(with page: Int) {
        self.pageControl.currentPage = page
    }

    func setPageControlNumberOfPages(_ number: Int) {
        pageControl.numberOfPages = number
    }
}

// MARK: - Setup UI.

extension CardViewController {
    private func setupViews() {

        setupActions()
        createMenuButton()

        self.view.addSubviews(closeButton,
                              scrollView,
                              settingsButton,
                              pageControl,
                              previousCardButton,
                              nextCardButton)

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

        settingsButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(scrollView.snp.bottom)
        }

        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scrollView.snp.bottom)
            make.height.equalTo(24)
        }

        previousCardButton.snp.makeConstraints { make in
            //make.top.equalTo(pageControl.snp.bottom).offset(40)
            make.left.equalToSuperview().inset(30)
            make.height.width.equalTo(56)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }

        nextCardButton.snp.makeConstraints { make in
            //make.top.equalTo(pageControl.snp.bottom).offset(40)
            make.right.equalToSuperview().inset(30)
            make.height.width.equalTo(56)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
    }
}
