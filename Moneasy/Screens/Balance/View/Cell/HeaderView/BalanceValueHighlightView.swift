//
//  BalanceValueView.swift
//  Moneasy
//
//  Created by Isnard Silva on 02/01/21.
//

import UIKit

class BalanceValueHighlightView: UIView {
    // MARK: - Views
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Saldo atual"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.text = "R$ 500,00"
        label.font = UIFont.boldSystemFont(ofSize: 35)
        return label
    }()
    
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - View Codable
extension BalanceValueHighlightView: ViewCodable {
    func setupHierarchy() {
        addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(valueLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .clear
    }
}
