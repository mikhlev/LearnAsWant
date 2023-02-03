//
//  MainScreenViewController.swift
//  LearnAsWant
//
//  Created by Aleksey on 01.02.2023.
//
//

import SnapKit
import UIKit
import MLKitTranslate

class MainScreenViewController: UIViewController {

    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.backgroundColor = .link
        button.setTitle("Add new", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    private lazy var learnButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.backgroundColor = .link
        button.setTitle("Learn", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    private lazy var languagesButton = UIButton()
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
        presenter.viewDidLoad()
        downLoad()

        self.view.backgroundColor = .green
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func downLoad() {

        let model = TranslateRemoteModel.translateRemoteModel(language: .russian)

        if !ModelManager.modelManager().isModelDownloaded(model) {
            ModelManager.modelManager().download(
                model,
                conditions: ModelDownloadConditions(
                    allowsCellularAccess: true,
                    allowsBackgroundDownloading: true
                )
            )
        }
    }
}

// MARK: - Table data.

extension MainScreenViewController {
    func showData(with cellModels: [PTableViewCellAnyModel]) {
        self.cellModels = cellModels
    }
}

// MARK: - Setup UI.
extension MainScreenViewController {
    private func setupViews() {

        self.view.addSubviews(tableView, addButton, learnButton, languagesButton)

        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.register(models: [TranslatedCardCellModel.self])
        self.tableView.contentInset.bottom = 60

        addButton.addTarget(self, action: #selector(openAddTranslateScreen), for: .touchUpInside)
        languagesButton.addTarget(self, action: #selector(openLanguagesScreen), for: .touchUpInside)
        languagesButton.setImage(UIImage(systemName: "globe"), for: .normal)
    }

    private func setupConstraints() {

        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
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

        languagesButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(30)
        }
    }
}

// MARK: Screen action.

extension MainScreenViewController {
    @objc private func openAddTranslateScreen() {
        presenter.openAddTranslateScreen()
    }

    @objc private func openLanguagesScreen() {
        presenter.openLanguagesScreen()
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
}
