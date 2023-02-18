//
//  LanguageCell.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.02.2023.
//

import UIKit

class LanguageCell: UITableViewCell {

    private let titleLabel = UILabel()

    private let labelForAutoDetectCell: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()

    private var isAutoDetectCell: Bool = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.isAutoDetectCell = false
        self.labelForAutoDetectCell.text = nil
    }

    func setupData(title: String, isAutoDetectCell: Bool) {
        self.isAutoDetectCell = isAutoDetectCell
        titleLabel.text = title


        if isAutoDetectCell {
            animateAdditionalLabel()
        }
    }

    func animateAdditionalLabel() {

        if self.isAutoDetectCell {

            UIView.transition(with: labelForAutoDetectCell, duration: 0.4, options: .transitionFlipFromTop) {[weak self] in
                self?.labelForAutoDetectCell.text = TranslationService.shared.supportedLanguages.randomElement()?.name ?? ""
            }
        }

    }

    private func setupViews() {
        self.contentView.addSubviews(titleLabel, labelForAutoDetectCell)
        labelForAutoDetectCell.fadeTransition(0.5)

    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }

        labelForAutoDetectCell.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().inset(16)
            make.left.equalTo(titleLabel.snp.right).offset(4)
        }
    }
}

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}
