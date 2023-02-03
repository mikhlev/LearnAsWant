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

    private lazy var addButton = UIButton()
    private lazy var languagesButton = UIButton()

    var presenter: MainScreenPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view

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

// MARK: Setup UI.
extension MainScreenViewController {
    private func setupViews() {

        self.view.addSubviews(addButton, languagesButton)

        addButton.addTarget(self, action: #selector(openAddTranslateScreen), for: .touchUpInside)
        languagesButton.addTarget(self, action: #selector(openLanguagesScreen), for: .touchUpInside)

        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        languagesButton.setImage(UIImage(systemName: "globe"), for: .normal)
    }

    private func setupConstraints() {
        addButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
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


