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

    private lazy var addTranslateButton = UIButton()

    private lazy var addTranslateContainer = UIView()

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
        self.addTranslateButton.setImage(UIImage(systemName: "plus.square.fill.on.square.fill"), for: .normal)
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

        self.view.addSubviews(tableView, learnButton)
        // must be after adding table view
        setupTopContainerViews()
        setupAddTranslateViews()
    }

    private func setupConstraints() {

        setupTopContainerConstraints()
        setupAddTranslateConstraints()

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
        addTranslateButton.addTarget(self, action: #selector(updateTranslateViewState), for: .touchUpInside)
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

// MARK: - Add translate view.

extension MainScreenViewController {

    private func setupAddTranslateViews() {
        addTranslateContainer.backgroundColor = .lightGray
        translateArrowButton.setImage(UIImage(systemName: "arrow.down"), for: .normal)

        self.view.addSubviews(addTranslateContainer)

        self.addTranslateContainer.addSubviews(addTranslateButton,
                                               translatedTextView,
                                               translateArrowButton,
                                               sourceTextView,
                                               saveButton)

        [translatedTextView, translateArrowButton, sourceTextView, saveButton].forEach { $0.alpha = 0 }
    }

    private func setupAddTranslateConstraints() {

        addTranslateContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topContainer.snp.bottom)
        }

        addTranslateButton.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.top.equalTo(topContainer.snp.bottom).offset(6)
            make.right.equalToSuperview().inset(10)
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

    func animateUpdateTranslateView(toShow: Bool) {

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
                self.view.layoutIfNeeded()
            })
        }
    }
}
