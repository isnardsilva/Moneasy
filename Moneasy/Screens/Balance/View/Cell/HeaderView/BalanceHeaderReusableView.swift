//
//  TransactionHeaderReusableView.swift
//  Moneasy
//
//  Created by Isnard Silva on 02/01/21.
//

import UIKit

final class BalanceHeaderReusableView: UICollectionReusableView {
    // MARK: - Views
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.backgroundColor = UIColor(named: Identifier.Color.balanceHeaderBackground)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let balanceValueView = BalanceValueHighlightView()
    
    private let balanceDetailItensStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    let revenueValueView: BalanceValueLittleView = {
        let balanceValueView = BalanceValueLittleView()
        balanceValueView.imageView.image = UIImage(systemName: "arrow.up.circle.fill")
        balanceValueView.imageView.tintColor = .green
        balanceValueView.titleLabel.text = "Receitas"
        balanceValueView.valueLabel.textColor = .green
        return balanceValueView
    }()
    
    let expenseValueView: BalanceValueLittleView = {
        let balanceValueView = BalanceValueLittleView()
        balanceValueView.imageView.image = UIImage(systemName: "arrow.down.circle.fill")
        balanceValueView.imageView.tintColor = .red
        balanceValueView.titleLabel.text = "Despesas"
        balanceValueView.valueLabel.textColor = .red
        return balanceValueView
    }()
    
    
    let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lançamentos"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Properties
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - View Codable
extension BalanceHeaderReusableView: ViewCodable {
    func setupHierarchy() {
        addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(balanceValueView)
        
        contentStackView.addArrangedSubview(balanceDetailItensStackView)
        balanceDetailItensStackView.addArrangedSubview(revenueValueView)
        balanceDetailItensStackView.addArrangedSubview(expenseValueView)
        
        
        addSubview(sectionTitleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            contentStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.85)
        ])
        
        NSLayoutConstraint.activate([
            sectionTitleLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            sectionTitleLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            sectionTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .clear
    }
}
