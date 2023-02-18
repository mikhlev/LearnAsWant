//
//  LanguagesViewController.swift
//  LearnAsWant
//
//  Created by Aleksey on 02.02.2023.
//
//

import UIKit

final class LanguagesViewController: UIViewController {

    var presenter: LanguagesPresenter!

    private lazy var titleContainer = UIView()
    private lazy var textFieldContainer = UIView()

    private lazy var titleLabel: UILabel = UILabel()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        return button
    }()

    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        return button
    }()

    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
        return textField
    }()

    private lazy var tableView = UITableView()
    private var cellModels: [PTableViewCellAnyModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupDelegates()
        addTargets()
        setupColors()
        setupConstraints()
        presenter.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

// MARK: - Setup screen data.

extension LanguagesViewController {
    func setupTitle(text: String) {
        self.titleLabel.text = text
    }

    func showData(with cellModels: [PTableViewCellAnyModel]) {
        self.cellModels = cellModels
    }
}

// MARK: - Setup UI.
extension LanguagesViewController {

    private func setupColors() {
        titleContainer.backgroundColor = .systemBackground
        textFieldContainer.backgroundColor = .systemBackground
    }

    private func setupViews() {
        self.tableView.register(models: [LanguageCellModel.self])
        self.view.addSubviews(titleContainer, textFieldContainer, tableView)
        self.titleContainer.addSubviews(titleLabel, closeButton)
        self.textFieldContainer.addSubviews(searchButton, searchTextField)

        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.separatorColor = .lightGray
    }

    private func setupDelegates() {
        self.searchTextField.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    private func addTargets() {
        self.closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        self.searchTextField.addTarget(self, action: #selector(updateTableBySearch), for: .editingChanged)
    }

    private func setupConstraints() {

        titleContainer.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50)
        }

        textFieldContainer.snp.makeConstraints { make in
            make.top.equalTo(titleContainer.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }

        searchButton.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.left.top.bottom.equalToSuperview()
        }

        searchTextField.snp.makeConstraints { make in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(searchButton.snp.right)
        }

        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview()
        }

        closeButton.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().inset(10)
            make.left.equalTo(titleLabel.snp.right)
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(textFieldContainer.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
    }
}

// MARK: UITableViewDelegate.

extension LanguagesViewController: UITableViewDelegate {

}

// MARK: UITableViewDataSource.

extension LanguagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withModel: cellModels[indexPath.row], for: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = cellModels[indexPath.row] as? LanguageCellModel else { return }
        presenter.languageSelected(model: model)
    }

}

//MARK: - Actions

extension LanguagesViewController {
    @objc private func closeAction() {
        presenter.closeScreen()
    }

    @objc private func updateTableBySearch() {
        presenter.updateTable(by: searchTextField.text)
    }
}

//MARK: - TextFieldDelegate.

extension LanguagesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}

extension LanguagesViewController {

    func updateVisibleCells() {
        guard let visibleCells = tableView.visibleCells as? [LanguageCell] else { return }
        visibleCells.forEach({ $0.animateAdditionalLabel() })
    }
}
