//
//  CardDetailsView.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.03.2023.
//

import UIKit

final class CardDetailsView: UIView {

    enum ViewMode {
        case screen
        case cell
    }

    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()

    private let sourceLanguageNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()

    private let sourceTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 2
        return label
    }()

    private let targetLanguageNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()

    private let targetTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 2
        return label
    }()

    init(mode: ViewMode) {
        super.init(frame: .zero)
        setupViews(mode: mode)
        setupConstraints(mode: mode)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupData(model: TranslationModel) {
        sourceLanguageNameLabel.text = model.sourceLanguage.name
        sourceTextLabel.text = model.fromText
        targetLanguageNameLabel.text = model.targetLanguage.name
        targetTextLabel.text = model.toText
    }

    private func setupFont(mode: ViewMode) {
        self.sourceTextLabel.font = UIFont.systemFont(ofSize: mode == .screen ? 24 : 18, weight: .bold)
    }

    private func setupViews(mode: ViewMode) {
        self.addSubview(contentStack)
        contentStack.addArrangedSubview(sourceLanguageNameLabel)
        contentStack.addArrangedSubview(sourceTextLabel)

        if mode == .screen {
            contentStack.addArrangedSubview(targetLanguageNameLabel)
            contentStack.addArrangedSubview(targetTextLabel)
        } else {
            self.contentStack.layer.cornerRadius = 10
            self.contentStack.backgroundColor = .red
        }

        contentStack.setCustomSpacing(20, after: sourceTextLabel)
    }

    private func setupConstraints(mode: ViewMode) {

        contentStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(mode == .screen ? 30 : 16)
            make.top.equalToSuperview().inset(mode == .screen ? 40 : 10)
            make.bottom.equalToSuperview().inset(mode == .screen ? 20 : 10)
        }

        sourceLanguageNameLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
        }

        sourceTextLabel.snp.makeConstraints { make in
            make.height.equalTo(mode == .screen ? 100 : 80)
        }

        targetLanguageNameLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
        }

        targetTextLabel.snp.makeConstraints { make in
            make.height.equalTo(mode == .screen ? 100 : 80)
        }
    }
}
