//
//  ViewCodable.swift
//  Moneasy
//
//  Created by Isnard Silva on 02/01/21.
//

import Foundation

protocol ViewCodable {
    func setupViews()
    func setupHierarchy()
    func setupConstraints()
    func setupAditionalConfiguration()
}


// MARK: - Helper Implementations
extension ViewCodable {
    func setupViews() {
        setupHierarchy()
        setupConstraints()
        setupAditionalConfiguration()
    }
}
