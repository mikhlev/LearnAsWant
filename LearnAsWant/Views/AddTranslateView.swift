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

    lazy var lineView: DashedView = {
        let view = DashedView()
        view.backgroundColor = .clear
        return view
    }()

    lazy var additionalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .link
        return view
    }()

    lazy var addTranslateButton: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        return button
    }()

    private lazy var sourceTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        textView.text = ""
        textView.backgroundColor = .clear
        return textView
    }()

    private lazy var translatedTextLabel: CopyableLabel = {
        let label = CopyableLabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "..."
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    private lazy var translateArrowButton: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = false
        return button
    }()

    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        return button
    }()

    private var viewMode: ViewMode = .short

    private let translateAnimationDuration = 0.1

    private let heightForAddTransalteButton: Double = 40

    private let heightForTextView: Double = 70

    private let heightForArrowButton: Double = 40

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
        super.init(coder: coder)
        setupViews()
        setupConstraints()
    }

    func updateOnboardingLineState(isHidden: Bool) {
        lineView.isHidden = isHidden
        additionalLineView.isHidden = isHidden
    }

    func setupTranslatedText(_ text: String) {
        self.translatedTextLabel.text = text
    }

    func clearView() {
        self.sourceTextView.text = ""
        self.translatedTextLabel.text = "..."
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
        self.layer.borderColor = UIColor.link.cgColor

        self.backgroundColor = .clear
        self.sourceTextView.delegate = self

        self.addTranslateButton.setImage(UIImage(systemName: "plus.square.fill.on.square.fill"), for: .normal)
        translateArrowButton.setImage(UIImage(systemName: "arrow.down"), for: .normal)

        self.addSubviews(lineView, additionalLineView)

        // EACH VIEW MUST HAVE THIS POSITION!!!

        self.addSubviews(saveButton,
                         translatedTextLabel,
                         translateArrowButton,
                         sourceTextView,
                         addTranslateButton)

        [translatedTextLabel, translateArrowButton, sourceTextView, saveButton].forEach { $0.alpha = 0 }
        lineView.alpha = 1
        additionalLineView.alpha = 1
        addActions()
    }

    private func setupConstraints() {

        lineView.snp.makeConstraints { make in
            make.centerY.equalTo(addTranslateButton.snp.centerY)
            make.left.equalTo(self.snp.centerX)
            make.right.equalTo(addTranslateButton.snp.left).inset(-6)
            make.height.equalTo(1)
        }

        additionalLineView.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.width.equalTo(1)
            make.top.equalTo(lineView.snp.bottom)
            make.centerX.equalTo(self.snp.centerX)
        }

        addTranslateButton.snp.makeConstraints { make in
            make.height.width.equalTo(28)
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
            make.height.equalTo(40)
            make.width.equalTo(40)
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
        self.lineView.alpha = toShow ? 0: 1
        self.additionalLineView.alpha = toShow ? 0: 1

        let actions = toShow ? commonActions : commonActions.reversed()

        let buttonImage = toShow ? UIImage(systemName: "multiply.circle.fill") : UIImage(systemName: "plus.square.fill.on.square.fill")

        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn], animations: {[weak self] in
            guard let self = self else { return }
            self.addTranslateButton.setImage(buttonImage, for: .normal)
            self.layer.borderWidth = toShow ? 2 : 0
            self.backgroundColor = toShow ? .systemBackground : .clear
        })

        for index in 0..<actions.count {
            let animateView = actions[index]()

            let duration = translateAnimationDuration
            let delay = translateAnimationDuration * Double((index + 1))

            UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseIn], animations: {[weak self] in
                guard let self = self else { return }
                animateView.alpha = toShow ? 1 : 0
                self.superview?.layoutIfNeeded()
            })
        }

        toShow ? sourceTextView.becomeFirstResponder() : sourceTextView.resignFirstResponder()
    }
}
