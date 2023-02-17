//
//  AddTranslateViewController.swift
//  LearnAsWant
//
//  Created by Aleksey on 02.02.2023.
//
//

import UIKit

class AddTranslateViewController: UIViewController {

    var presenter: AddTranslatePresenter!

    private lazy var fromTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.red.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 10
        return textView
    }()

    private lazy var toTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.red.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 10
        return textView
    }()

    private lazy var languageFromButton = UIButton()
    private lazy var languageToButton = UIButton()
    private lazy var changeLanguageButton = UIButton()
    private lazy var saveButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        presenter.viewDidLoad()
        self.view.backgroundColor = .blue
    }

    func setupData(translationModel: TranslationModel) {

        changeLanguageButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)

        fromTextView.text = translationModel.fromText
        toTextView.text = translationModel.toText

        languageFromButton.setTitle(translationModel.fromLanguage.rawValue, for: .normal)
        languageToButton.setTitle(translationModel.toLanguage.rawValue, for: .normal)
    }

    func setupTranslatedData(text: String) {
        self.toTextView.text = text
    }

    func setupSourceLanguage(_ name: String) {
        self.languageFromButton.setTitle(name, for: .normal)
    }
}

// MARK: - UITextViewDelegate.

extension AddTranslateViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {

        switch textView {
        case fromTextView:
            presenter.translate(text: textView.text, fromSourceLanguage: true)
        case toTextView:
            presenter.translate(text: toTextView.text, fromSourceLanguage: false)
        default:
            break
        }
    }
}

// MARK: - Setup UI.

extension AddTranslateViewController {

    private func setupViews() {

        self.fromTextView.delegate = self
        self.toTextView.delegate = self

        self.view.addSubviews(fromTextView,
                              toTextView,
                              languageFromButton,
                              languageToButton,
                              changeLanguageButton,
                              saveButton)

        self.saveButton.setTitle("save", for: .normal)
        self.saveButton.addTarget(self, action: #selector(saveText), for: .touchUpInside)
    }

    private func setupConstraints() {
        fromTextView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.left.right.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(30)
        }

        languageFromButton.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.left.equalToSuperview().inset(16)
            make.right.equalTo(changeLanguageButton.snp.left).offset(10)
            make.top.equalTo(fromTextView.snp.bottom).offset(30)
        }

        changeLanguageButton.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.equalTo(48)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(languageFromButton.snp.centerY)
        }

        languageToButton.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.right.equalToSuperview().inset(16)
            make.left.equalTo(changeLanguageButton.snp.right).offset(10)
            make.centerY.equalTo(languageFromButton.snp.centerY)
        }

        toTextView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(languageFromButton.snp.bottom).offset(30)
        }

        saveButton.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.greaterThanOrEqualTo(toTextView.snp.bottom).offset(30)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
    }
}

// MARK: - Actions.

extension AddTranslateViewController {

    @objc private func saveText() {
        presenter.saveText()
    }
}
