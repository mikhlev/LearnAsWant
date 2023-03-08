//
//  OnboardingCell.swift
//  LearnAsWant
//
//  Created by Aleksey on 08.03.2023.
//

import UIKit

class OnboardingCell: UITableViewCell {

    private lazy var line: DashedView = {
        let view = DashedView()
        view.backgroundColor = .clear
        return view
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.text = "Add first card"
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

    private func setupViews() {
        self.contentView.addSubviews(line, label)
    }

    private func setupConstraints() {
        line.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
        }

        label.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(line.snp.bottom).offset(6)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
