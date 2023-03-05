//
//  TranslatedCardCell.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.02.2023.
//

import UIKit

class TranslatedCardCell: UITableViewCell {

    private let sourceLanguageNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()

    private lazy var translateArrowButton = UIButton()

    private let targetLanguageNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()

    private let sourceTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupViews()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupData(translationModel: TranslationModel) {
        sourceLanguageNameLabel.text = translationModel.sourceLanguage.name
        sourceTextLabel.text = translationModel.fromText
        targetLanguageNameLabel.text = translationModel.targetLanguage.name
    }
}

// MARK: - Setup UI.

extension TranslatedCardCell {

    private func setupViews() {

        self.translateArrowButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)

        self.contentView.addSubviews(sourceLanguageNameLabel,
                                     translateArrowButton,
                                     targetLanguageNameLabel,
                                     sourceTextLabel)
    }

    private func setupConstraints() {
        sourceLanguageNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }

        translateArrowButton.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.centerY.equalTo(sourceLanguageNameLabel.snp.centerY)
            make.left.equalTo(sourceLanguageNameLabel.snp.right).offset(6)
        }

        targetLanguageNameLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.centerY.equalTo(translateArrowButton.snp.centerY)
            make.left.equalTo(translateArrowButton.snp.right).offset(6)
        }

        sourceTextLabel.snp.makeConstraints { make in
            make.top.equalTo(sourceLanguageNameLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
    }
}
