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

        languageFromButton.setTitle("Language 1", for: .normal)
        languageToButton.setTitle("Language 1", for: .normal)
        saveButton.setTitle("save", for: .normal)
        changeLanguageButton.setImage(UIImage(systemName: "arrow.left.arrow.right"), for: .normal)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    private func setupViews() {
        self.view.addSubviews(fromTextView,
                              toTextView,
                              languageFromButton,
                              languageToButton,
                              changeLanguageButton,
                              saveButton)
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


extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
