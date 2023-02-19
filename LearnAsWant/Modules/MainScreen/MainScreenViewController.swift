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

    //MARK: - Top container
    private lazy var topContainer = UIView()

    private lazy var sourceLanguageButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()

    private lazy var targetLanguageButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()

    private lazy var changeLanguageButton = UIButton()

    // MARK: - AddTranslate container.

    private lazy var addTranslateView = AddTranslateView()

    // MARK: - Other UI elements.
    private lazy var tableView = UITableView()
    private lazy var learnButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        return button
    }()

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

        setupTable()
        setupActions()

        setupButtons()
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
        sourceLanguageButton.setTitle(sourceLanguage.name, for: .normal)
        targetLanguageButton.setTitle(targetLanguage.name, for: .normal)
    }
}

// MARK: - Setup UI.
extension MainScreenViewController {

    private func setupButtons() {
        self.changeLanguageButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        self.learnButton.setTitle(Strings.MainScreen.learnButtonButton, for: .normal)
    }

    private func setupTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(models: [TranslatedCardCellModel.self])
        self.tableView.contentInset.bottom = 60
    }

    private func setupViews() {
        self.view.backgroundColor = .systemBackground

        self.view.addSubviews(tableView, learnButton, addTranslateView)
        // must be after adding table view
        setupTopContainerViews()
    }

    private func setupConstraints() {

        setupTopContainerConstraints()

        addTranslateView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topContainer.snp.bottom)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(topContainer.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }

        learnButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(130)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.right.equalToSuperview().inset(30)
        }
    }

    private func setupTopContainerViews() {
        self.view.addSubview(topContainer)
        self.topContainer.addSubviews(sourceLanguageButton,
                                      changeLanguageButton,
                                      targetLanguageButton)
    }

    private func setupTopContainerConstraints() {
        topContainer.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(20)
        }

        sourceLanguageButton.snp.makeConstraints { make in
            make.right.equalTo(changeLanguageButton.snp.left).inset(-4)
            make.top.bottom.left.equalToSuperview()
        }

        changeLanguageButton.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.centerY.equalTo(sourceLanguageButton.snp.centerY)
        }

        targetLanguageButton.snp.makeConstraints { make in
            make.width.equalTo(sourceLanguageButton.snp.width)
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(changeLanguageButton.snp.right).offset(4)
        }
    }
}

// MARK: - Screen action.

extension MainScreenViewController {

    private func setupActions() {
        sourceLanguageButton.addTarget(self, action: #selector(openLanguagesScreenForSourceLanguage), for: .touchUpInside)
        targetLanguageButton.addTarget(self, action: #selector(openLanguagesScreenForTargetLanguage), for: .touchUpInside)

        addTranslateView.updateViewStateButtonTapped = {[weak self] in
            self?.presenter.updateTranslateViewState()
        }
    }

    @objc private func openAddTranslateScreen() {
        presenter.openAddTranslateScreen()
    }

    @objc private func openLanguagesScreenForSourceLanguage() {
        presenter.openLanguagesScreen(forSource: true)
    }

    @objc private func openLanguagesScreenForTargetLanguage() {
        presenter.openLanguagesScreen(forSource: false)
    }

    @objc private func updateTranslateViewState() {
        presenter.updateTranslateViewState()
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
        self.showOnboarding(description: description, viewForCopy: sourceLanguageButton)
    }

    func showOnboardingFortargetLanguage(with description: String) {
        self.showOnboarding(description: description, viewForCopy: targetLanguageButton)
    }

    private func showOnboarding(description: String, viewForCopy: UIView) {
        let helpView = OnboardingView(descriptionText: description, viewForCopy: viewForCopy)
        helpView.show(superviewOfCopied: self.view)
    }
}

//MARK: - Add Translate settings.

extension MainScreenViewController {

    func updateViewState(toShow: Bool) {
        self.addTranslateView.updateViewState(toShow: toShow)
        self.updateTableState(toDisable: toShow)
    }

    private func updateTableState(toDisable: Bool) {

        tableView.alpha = toDisable ? 0.5 : 1
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }

    @objc private func saveText() {
        let model = TranslationModel(sourceLanguage: Singleton.currentLanguageModel.sourceLanguage,
                                     targetLanguage: Singleton.currentLanguageModel.sourceLanguage,
                                     fromText: nil,
                                     toText: nil)
        presenter.saveText(model: model)
    }
}

extension MainScreenViewController: UITextViewDelegate {

}
