//
//  TransactionCell.swift
//  Moneasy
//
//  Created by Isnard Silva on 03/01/21.
//

import UIKit

final class TransactionCell: UICollectionViewCell {
    // MARK: - Views
    private let leftContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Properties
    var transactionViewModel: TransactionViewModel? {
        didSet {
            setupData()
        }
    }
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup Data
    private func setupData() {
        guard let viewModel = transactionViewModel else { return }
        
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.formattedDate
        valueLabel.text = viewModel.formattedValue
        
        switch viewModel.type {
        case .expense:
            valueLabel.textColor = .red
        case .revenue:
            valueLabel.textColor = .green
        }
    }
}


// MARK: - View Codable
extension TransactionCell: ViewCodable {
    func setupHierarchy() {
        contentView.addSubview(valueLabel)
        
        contentView.addSubview(leftContentStackView)
        leftContentStackView.addArrangedSubview(nameLabel)
        leftContentStackView.addArrangedSubview(dateLabel)
    }
    
    func setupConstraints() {
        valueLabel.setContentHuggingPriority(UILayoutPriority(999), for: .horizontal)
        valueLabel.setContentCompressionResistancePriority(UILayoutPriority(999), for: .horizontal)
        
        NSLayoutConstraint.activate([
            valueLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            leftContentStackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            leftContentStackView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            leftContentStackView.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: -8)
        ])
    }
    
    func setupAditionalConfiguration() {
        contentView.backgroundColor = .clear
    }
}
