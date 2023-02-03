//
//  TranslatedCardCell.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.02.2023.
//

import UIKit

class TranslatedCardCell: UITableViewCell {

    private let topLabel = UILabel()
    private let bottomLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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

    func setupData(text: String, translatedText: String) {
        topLabel.text = text
        bottomLabel.text = translatedText
    }
}

// MARK: - Setup UI.

extension TranslatedCardCell {

    private func setupViews() {
        self.contentView.addSubviews(topLabel, bottomLabel)
    }

    private func setupConstraints() {
        topLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.left.right.equalToSuperview().inset(4)
        }

        bottomLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalTo(topLabel.snp.bottom).offset(4)
            make.bottom.left.right.equalToSuperview().inset(4)
        }
    }
}