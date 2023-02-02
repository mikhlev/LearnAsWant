//
//  LanguagesViewController.swift
//  LearnAsWant
//
//  Created by Aleksey on 02.02.2023.
//
//

import UIKit
import MLKitTranslate

class LanguagesViewController: UIViewController {

    var presenter: LanguagesPresenter!

    private lazy var tableView = UITableView(frame: .zero, style: .plain)

    private var cellModels: [PTableViewCellAnyModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private lazy var languagesList = Array(TranslateLanguage.allLanguages()).sorted(by: { $0.rawValue > $1.rawValue })


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        setupViews()
        setupConstraints()
        presenter.viewDidLoad()
        // Create an English-German translator:
        let options = TranslatorOptions(sourceLanguage: .english, targetLanguage: .german)
        let englishGermanTranslator = Translator.translator(options: options)
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

// MARK: UITableViewDelegate.

extension LanguagesViewController: UITableViewDelegate {

}

// MARK: UITableViewDataSource.

extension LanguagesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languagesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = languagesList[indexPath.row].rawValue
        return cell
    }
}
