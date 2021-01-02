//
//  AlertManager.swift
//  Moneasy
//
//  Created by Isnard Silva on 02/01/21.
//

import UIKit

struct AlertManager {
    // MARK: - Alert Types
    func createDefaultAlert(title: String, message: String, completion: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            completion?()
        }))
        
        return alert
    }
}
