//
//  NotificationService.swift
//  LearnAsWant
//
//  Created by Aleksey on 04.02.2023.
//

import UIKit

enum GlobalNotification: String {
    case newCardAdded
    case languageChanged
}

final class NotificationService {

    static func addObserver(vc: Any, selector: Selector, for key: GlobalNotification) {
        let nc = NotificationCenter.default
        nc.addObserver(vc, selector: selector, name: Notification.Name(key.rawValue), object: nil)
    }

    static func postMessage(for key: GlobalNotification) {
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name(key.rawValue), object: nil)
    }
}
