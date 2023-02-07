//
//  OnboardingView.swift
//  LearnAsWant
//
//  Created by Aleksey on 06.02.2023.
//

import UIKit

final class OnboardingView: UIView {

    private let blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.75
        return view
    }()

    private let labelsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()

    private let descriptionLabel = UILabel()
    private let copiedView: UIView

    init(descriptionText: String, viewForCopy: UIView) {

        self.copiedView = viewForCopy.copyView()

        super.init(frame: .zero)

        descriptionLabel.text = descriptionText
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        descriptionLabel.textColor = .white

        self.addSubviews(blackView, labelsStack)
        self.blackView.addSubview(copiedView)
        labelsStack.addArrangedSubview(descriptionLabel)
    }

    private func setupConstraints() {
        blackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let frame = copiedView.frame

        copiedView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(frame.origin.y)
            make.leading.equalToSuperview().inset(frame.origin.x)
            make.height.equalTo(frame.height)
            make.width.equalTo(frame.width)
        }

        labelsStack.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show(superviewOfCopied: UIView) {
        self.alpha = 0
        superviewOfCopied.addSubview(self)

        self.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        } completion: { value in
            if value {
                UIView.animate(withDuration: 1, delay: 2) {
                    self.alpha = 0
                } completion: { value in
                    if value {
                        self.removeFromSuperview()
                    }
                }
            }
        }
    }
}
