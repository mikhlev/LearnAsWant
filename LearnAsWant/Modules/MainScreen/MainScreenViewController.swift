//
//  MainScreenViewController.swift
//  LearnAsWant
//
//  Created by Aleksey on 01.02.2023.
//
//

import SnapKit
import UIKit

class MainScreenViewController: UIViewController {

    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    private lazy var learnButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    private lazy var languageFromButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()

    private lazy var languageToButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()

    private lazy var changeLanguageButton = UIButton()

    private lazy var tableView = UITableView()

    private var cellModels: [PTableViewCellAnyModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    var presenter: MainScreenPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupStrings()
        presenter.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }
}

extension MainScreenViewController {
    func showData(with cellModels: [PTableViewCellAnyModel]) {
        self.cellModels = cellModels
    }

    func setupData(sourceLanguage: TranslationLanguage, targetLanguage: TranslationLanguage) {
        languageFromButton.setTitle(sourceLanguage.name, for: .normal)
        languageToButton.setTitle(targetLanguage.name, for: .normal)
        changeLanguageButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
    }
}

// MARK: - Setup UI.
extension MainScreenViewController {

    private func setupStrings() {
        self.addButton.setTitle(Strings.MainScreen.addNewButton, for: .normal)
        self.learnButton.setTitle(Strings.MainScreen.learnButtonButton, for: .normal)
    }

    private func setupViews() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubviews(tableView,
                              addButton,
                              learnButton,
                              languageFromButton,
                              changeLanguageButton,
                              languageToButton)
        setupTable()
        setupButtons()
    }

    private func setupTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(models: [TranslatedCardCellModel.self])
        self.tableView.contentInset.bottom = 60
    }

    private func setupButtons() {
        addButton.addTarget(self, action: #selector(openAddTranslateScreen), for: .touchUpInside)

        languageFromButton.addTarget(self, action: #selector(openLanguagesScreenForSourceLanguage), for: .touchUpInside)
        languageToButton.addTarget(self, action: #selector(openLanguagesScreenForTargetLanguage), for: .touchUpInside)
    }

    private func setupConstraints() {

        languageFromButton.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.left.equalToSuperview().inset(16)
            make.right.equalTo(changeLanguageButton.snp.left).offset(10)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(20)
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

        tableView.snp.makeConstraints { make in
            make.top.equalTo(languageFromButton.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }

        addButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(130)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.left.equalToSuperview().inset(30)
        }

        learnButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(130)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.right.equalToSuperview().inset(30)
        }
    }
}

// MARK: - Screen action.

extension MainScreenViewController {
    @objc private func openAddTranslateScreen() {
        presenter.openAddTranslateScreen()
    }

    @objc private func openLanguagesScreenForSourceLanguage() {
        presenter.openLanguagesScreen(forSource: true)
    }

    @objc private func openLanguagesScreenForTargetLanguage() {
        presenter.openLanguagesScreen(forSource: false)
    }
}

// MARK: - UITableViewDelegate

extension MainScreenViewController: UITableViewDelegate {

}


// MARK: - UITableViewDataSource

extension MainScreenViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withModel: cellModels[indexPath.row], for: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openAddTranslateScreenForCell(row: indexPath.row)
    }
}

// MARK: - Onboarding.

extension MainScreenViewController {

    func showOnboardingForsourceLanguage(with description: String) {
        self.showOnboarding(description: description, viewForCopy: languageFromButton)
    }

    func showOnboardingFortargetLanguage(with description: String) {
        self.showOnboarding(description: description, viewForCopy: languageToButton)
    }

    private func showOnboarding(description: String, viewForCopy: UIView) {
        let helpView = OnboardingView(descriptionText: description, viewForCopy: viewForCopy)
        helpView.show(superviewOfCopied: self.view)
    }
}
