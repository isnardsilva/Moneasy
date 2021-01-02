//
//  BalanceValueLittleView.swift
//  Moneasy
//
//  Created by Isnard Silva on 03/01/21.
//

import UIKit

class BalanceValueLittleView: UIView {
    // MARK: - Views
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let valuesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
//        stackView.alignment =
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Despesas"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.text = "R$ 8.500,00"
        label.font = UIFont.boldSystemFont(ofSize: 22)
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
extension BalanceValueLittleView: ViewCodable {
    func setupHierarchy() {
        addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(imageView)
        
        contentStackView.addArrangedSubview(valuesStackView)
        valuesStackView.addArrangedSubview(titleLabel)
        valuesStackView.addArrangedSubview(valueLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: valuesStackView.heightAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .clear
    }
}
