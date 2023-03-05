//
//  AddTranslateView.swift
//  LearnAsWant
//
//  Created by Aleksey on 19.02.2023.
//

import UIKit

final class AddTranslateView: UIView {

    enum ViewMode {
        case full
        case short
    }

    private lazy var addTranslateButton = UIButton()

    private lazy var sourceTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.text = ""
        textView.backgroundColor = .clear
        return textView
    }()

    private lazy var translatedTextLabel: CopyableLabel = {
        let label = CopyableLabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = " ... "
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    private lazy var translateArrowButton = UIButton()

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.label, for: .normal)
        return button
    }()

    private var viewMode: ViewMode = .short

    private let translateAnimationDuration = 0.1

    private let heightForAddTransalteButton: Double = 40

    private let heightForTextView: Double = 70

    private let heightForArrowButton: Double = 40

    private let heightForSaveButton: Double = 70

    private var offsetForTextView: Double {
        return viewMode == .full ? heightForTextView + 10 : 0
    }

    private var offsetForButtons: Double {
        return viewMode == .full ? heightForArrowButton + 10 : 0
    }
    
    var updateViewStateButtonTapped: (() -> Void)?
    var saveTextButtonTapped: ((String?, String?) -> Void)?
    var sourceTextChanged: ((String?) -> Void)?

    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupTranslatedText(_ text: String) {
        self.translatedTextLabel.text = text
    }

    func clearView() {
        self.sourceTextView.text = ""
        self.translatedTextLabel.text = " ... "
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

    @objc private func saveText() {
        saveTextButtonTapped?(sourceTextView.text, translatedTextLabel.text)
    }

    @objc private func updateTranslateViewState() {
        updateViewStateButtonTapped?()
    }
}

// MARK: - Add translate view UI.

extension AddTranslateView {

    private func setupViews() {

        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.red.cgColor

        self.backgroundColor = .clear//.label.withAlphaComponent(0.2)
        self.sourceTextView.delegate = self

        self.addTranslateButton.setImage(UIImage(systemName: "plus.square.fill.on.square.fill"), for: .normal)
        translateArrowButton.setImage(UIImage(systemName: "arrow.down"), for: .normal)

        // EACH VIEW MUST HAVE THIS POSITION!!!
        self.addSubviews(saveButton,
                         translatedTextLabel,
                         translateArrowButton,
                         sourceTextView,
                         addTranslateButton)

        [translatedTextLabel, translateArrowButton, sourceTextView, saveButton].forEach { $0.alpha = 0 }

        addActions()
    }

    private func setupConstraints() {

        addTranslateButton.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.top.equalToSuperview().inset(5)
            make.right.equalToSuperview().inset(5)
        }

        setupFirstState()
    }

    private func setupFirstState() {

        sourceTextView.snp.makeConstraints { make in
            make.bottom.equalTo(addTranslateButton.snp.bottom).offset(offsetForTextView)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(heightForTextView)
        }

        translateArrowButton.snp.makeConstraints { make in
            make.bottom.equalTo(sourceTextView.snp.bottom).offset(offsetForButtons)
            make.height.width.equalTo(40)
            make.centerX.equalToSuperview()
        }

        translatedTextLabel.snp.makeConstraints { make in
            make.bottom.equalTo(translateArrowButton.snp.bottom).offset(offsetForTextView)
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(heightForTextView)
        }

        saveButton.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
            make.bottom.equalTo(translatedTextLabel.snp.bottom).offset(offsetForButtons)
        }
    }

    // Views animation.
    private func showOrHideSourceTextView() -> UIView {
        sourceTextView.snp.updateConstraints { make in
            make.bottom.equalTo(addTranslateButton.snp.bottom).offset(offsetForTextView)
        }
        return sourceTextView
    }

    private func showOrHideTranslateArrowButton() -> UIView {
        translateArrowButton.snp.updateConstraints { make in
            make.bottom.equalTo(sourceTextView.snp.bottom).offset(offsetForButtons)
        }
        return translateArrowButton
    }

    private func showOrHideTargetTextView() -> UIView {
        translatedTextLabel.snp.updateConstraints { make in
            make.bottom.equalTo(translateArrowButton.snp.bottom).offset(offsetForTextView)
        }
        return translatedTextLabel
    }

    private func showOrHideSaveButton() -> UIView {
        saveButton.snp.updateConstraints { make in
            make.bottom.equalTo(translatedTextLabel.snp.bottom).offset(offsetForButtons)
        }
        return saveButton
    }

    func updateViewState(toShow: Bool) {

        let commonActions = [showOrHideSourceTextView,
                             showOrHideTranslateArrowButton,
                             showOrHideTargetTextView,
                             showOrHideSaveButton]

        viewMode = toShow ? .full : .short

        let actions = viewMode == .full ? commonActions : commonActions.reversed()

        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: {[weak self] in
            guard let self = self else { return }
            self.layer.borderWidth = self.viewMode == .full ? 1 : 0
            self.backgroundColor = self.viewMode == .full ? .systemBackground : .clear
        })

        for index in 0..<actions.count {
            let animateView = actions[index]()

            let duration = translateAnimationDuration
            let delay = translateAnimationDuration * Double((index + 1))

            UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseIn], animations: {[weak self] in
                guard let self = self else { return }
                animateView.alpha = self.viewMode == .full ? 1 : 0
                self.superview?.layoutIfNeeded()
            })
        }

        toShow ? sourceTextView.becomeFirstResponder() : sourceTextView.resignFirstResponder()
    }
}
