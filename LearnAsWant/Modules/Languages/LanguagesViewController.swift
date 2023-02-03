//
//  LanguagesViewController.swift
//  LearnAsWant
//
//  Created by Aleksey on 02.02.2023.
//
//

import UIKit

class LanguagesViewController: UIViewController {

    var presenter: LanguagesPresenter!

    private lazy var tableView = UITableView()
    private var cellModels: [PTableViewCellAnyModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        setupViews()
        setupConstraints()
        tableView.register(models: [LanguageCellModel.self])

        presenter.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

// MARK: Setup UI.
extension LanguagesViewController {

    private func setupViews() {

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}

// MARK: Table data.

extension LanguagesViewController {
    func showData(with cellModels: [PTableViewCellAnyModel]) {
        self.cellModels = cellModels
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
}
