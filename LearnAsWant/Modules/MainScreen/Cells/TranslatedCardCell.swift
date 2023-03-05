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

    func setupData(fromText: String?, toText: String?) {
        topLabel.text = fromText
        bottomLabel.text = toText
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
            make.top.equalToSuperview().inset(4)
            make.left.right.equalToSuperview().inset(16)
        }

        bottomLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalTo(topLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().inset(4)
            make.left.right.equalToSuperview().inset(16)
        }
    }
}
