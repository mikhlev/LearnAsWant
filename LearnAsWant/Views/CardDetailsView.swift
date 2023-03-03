//
//  CardDetailsView.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.03.2023.
//

import UIKit

final class CardDetailsView: UIView {

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
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
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
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 2
        return label
    }()

    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
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

    private func setupViews() {
        self.addSubview(contentStack)
        contentStack.addArrangedSubview(sourceLanguageNameLabel)
        contentStack.addArrangedSubview(sourceTextLabel)
        contentStack.addArrangedSubview(targetLanguageNameLabel)
        contentStack.addArrangedSubview(targetTextLabel)

        contentStack.setCustomSpacing(20, after: sourceTextLabel)
    }

    private func setupConstraints() {

        contentStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(20)
        }

        sourceLanguageNameLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
        }

        sourceTextLabel.snp.makeConstraints { make in
            make.height.equalTo(100)
        }

        targetLanguageNameLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
        }

        targetTextLabel.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
    }
}
