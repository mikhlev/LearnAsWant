//
//  CardViewController.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.03.2023.
//
//

import UIKit

class CardViewController: UIViewController {

    var presenter: CardPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view

       presenter.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
