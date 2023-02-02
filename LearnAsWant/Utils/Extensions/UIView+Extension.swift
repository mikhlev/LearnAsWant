//
//  UIView+Extension.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.02.2023.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
