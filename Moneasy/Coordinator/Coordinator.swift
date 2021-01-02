//
//  Coordinator.swift
//  Moneasy
//
//  Created by Isnard Silva on 02/01/21.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
