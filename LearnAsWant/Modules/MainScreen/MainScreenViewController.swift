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

    private lazy var testLabel = UILabel()

    private lazy var addButton = UIButton()

    var presenter: MainScreenPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view

        setupViews()
        setupConstraints()
        presenter.viewDidLoad()
        self.view.backgroundColor = .green
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addButton.addTarget(self, action: #selector(openAddTranslateScreen), for: .touchUpInside)

    }
}

// MARK: Setup UI.
extension MainScreenViewController {
    private func setupViews() {
        self.view.addSubview(addButton)
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
    }

    private func setupConstraints() {
        addButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}


// MARK: Screen action.

extension MainScreenViewController {
    @objc private func openAddTranslateScreen() {
        presenter.openAddTranslateScreen()
    }
}
