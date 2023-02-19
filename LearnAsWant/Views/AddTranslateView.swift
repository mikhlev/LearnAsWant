//
//  AddTranslateView.swift
//  LearnAsWant
//
//  Created by Aleksey on 19.02.2023.
//

import UIKit

final class AddTranslateView: UIView {

    private lazy var addTranslateButton = UIButton()

//    private lazy var addTranslateContainer = UIView()

    private lazy var sourceTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.red.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 10
        return textView
    }()

    private lazy var translatedTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.red.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 10
        return textView
    }()

    private lazy var translateArrowButton = UIButton()

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        return button
    }()

    private let translateAnimationDuration = 0.1

    var updateViewStateButtonTapped: (() -> Void)?
    var saveTextButtonTapped: (() -> Void)?
    var sourceTextChanged: ((String?) -> Void)?

    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupTranslatedtext(text: String) {
        self.translatedTextView.text = text
    }
}

extension AddTranslateView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {

        switch textView {
        case sourceTextView:
            sourceTextChanged?(textView.text)
        default:
            break
        }
    }
}

extension AddTranslateView {

    private func addActions() {
        addTranslateButton.addTarget(self, action: #selector(updateTranslateViewState), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveText), for: .touchUpInside)
    }

    @objc private func sourceTextUpdated() {
        saveTextButtonTapped?()
    }

    @objc private func saveText() {
        saveTextButtonTapped?()
    }

    @objc private func updateTranslateViewState() {
        updateViewStateButtonTapped?()
    }
}

// MARK: - Add translate view UI.

extension AddTranslateView {

    private func setupViews() {

        self.backgroundColor = .lightGray

        self.sourceTextView.delegate = self

        self.addTranslateButton.setImage(UIImage(systemName: "plus.square.fill.on.square.fill"), for: .normal)
        translateArrowButton.setImage(UIImage(systemName: "arrow.down"), for: .normal)

        // EACH VIEW MUST HAVE THIS POSITION!!!
        self.addSubviews(saveButton,
                         translatedTextView,
                         translateArrowButton,
                         sourceTextView,
                         addTranslateButton)

        [translatedTextView, translateArrowButton, sourceTextView, saveButton].forEach { $0.alpha = 0 }

        addActions()
    }

    private func setupConstraints() {

        addTranslateButton.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.top.right.equalToSuperview().inset(10)
        }

        setupFirstState()
    }

    private func setupFirstState() {

        sourceTextView.snp.makeConstraints { make in
            make.bottom.equalTo(addTranslateButton.snp.bottom).offset(0)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }

        translateArrowButton.snp.makeConstraints { make in
            make.bottom.equalTo(sourceTextView.snp.bottom).offset(0)
            make.height.width.equalTo(40)
            make.centerX.equalToSuperview()
        }

        translatedTextView.snp.makeConstraints { make in
            make.bottom.equalTo(translateArrowButton.snp.bottom).offset(0)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }

        saveButton.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
            make.bottom.equalTo(translatedTextView.snp.bottom).offset(0)
        }
    }

    // Views animation.
    private func showOrHideSourceTextView(toShow: Bool) -> UIView {
        sourceTextView.snp.updateConstraints { make in
            make.bottom.equalTo(addTranslateButton.snp.bottom).offset(toShow ? 50 : 0)
        }
        return sourceTextView
    }

    private func showOrHideTranslateArrowButton(toShow: Bool) -> UIView {
        translateArrowButton.snp.updateConstraints { make in
            make.bottom.equalTo(sourceTextView.snp.bottom).offset(toShow ? 50 : 0)
        }
        return translateArrowButton
    }

    private func showOrHideTargetTextView(toShow: Bool) -> UIView {
        translatedTextView.snp.updateConstraints { make in
            make.bottom.equalTo(translateArrowButton.snp.bottom).offset(toShow ? 50 : 0)
        }
        return translatedTextView
    }

    private func showOrHideSaveButton(toShow: Bool) -> UIView {
        saveButton.snp.updateConstraints { make in
            make.bottom.equalTo(translatedTextView.snp.bottom).offset(toShow ? 50 : 0)
        }
        return saveButton
    }

    func updateViewState(toShow: Bool) {

        let commonActions = [showOrHideSourceTextView,
                             showOrHideTranslateArrowButton,
                             showOrHideTargetTextView,
                             showOrHideSaveButton]

        let actions = toShow ? commonActions : commonActions.reversed()

        for index in 0..<actions.count {
            let animateView = actions[index](toShow)

            let duration = translateAnimationDuration
            let delay = translateAnimationDuration * Double((index + 1))

            UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseIn], animations: {[weak self] in
                guard let self = self else { return }
                animateView.alpha = toShow ? 1 : 0
                self.superview?.layoutIfNeeded()
            })
        }
    }
}
