//
//  CopyableLabel.swift
//  LearnAsWant
//
//  Created by Aleksey on 03.03.2023.
//

import UIKit

class CopyableLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func copy(_ sender: Any?) {
        let board = UIPasteboard.general
        board.string = self.text
        let menu = UIMenuController.shared
        menu.hideMenu(from: self)
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.copy(_:)) {
            return true
        }
        return false
    }

    private func sharedInit() {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(showMenu)))
    }

    @objc private func showMenu(sender: AnyObject?) {
        becomeFirstResponder()
        let menu = UIMenuController.shared
        if !menu.isMenuVisible {
            menu.showMenu(from: self,
                          rect: CGRect(x: self.frame.size.width / 2, y: 0, width: 0, height: 0))
        }
    }
    
}
