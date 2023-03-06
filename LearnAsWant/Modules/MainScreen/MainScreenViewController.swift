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

    private lazy var changeLanguageButton: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = false
        return button
    }()

    // MARK: - AddTranslate container.

    private lazy var addTranslateView = AddTranslateView()

    // MARK: - Other UI elements.
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.contentInset.top = 60
        tableView.separatorStyle = .none
        return tableView
    }()

    private lazy var learnButton: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 25
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
        self.learnButton.setImage(UIImage(systemName: "book.closed.circle"), for: .normal)
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
            
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(topContainer.snp.bottom).offset(5)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(topContainer.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }

        learnButton.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(16)
            make.right.equalToSuperview().inset(16)
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

        learnButton.addTarget(self, action: #selector(openCardsScreen), for: .touchUpInside)
        
        addTranslateView.updateViewStateButtonTapped = {[weak self] in
            self?.presenter.updateTranslateViewState()
        }

        addTranslateView.sourceTextChanged = {[weak self] text in
            self?.presenter.translate(text: text, fromSourceLanguage: true)
        }

        addTranslateView.saveTextButtonTapped = {[weak self] sourceText, translatedText in
            self?.saveText(sourceText: sourceText, translatedText: translatedText)
        }
    }

    @objc private func openCardsScreen() {
        presenter.openAllCardsScreen()
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
        presenter.openCardScreen(index: indexPath.row)
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

        tableView.alpha = toDisable ? 0.1 : 1
        tableView.isUserInteractionEnabled = !toDisable
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }

    func setupTranslatedText(_ text: String) {
        self.addTranslateView.setupTranslatedText(text)
    }

    func clearTranslateView() {
        self.addTranslateView.clearView()
    }

    private func saveText(sourceText: String?, translatedText: String?) {
        presenter.saveText(sourceText: sourceText, translatedText: translatedText)
    }
}
