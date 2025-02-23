//
//  MainCell.swift
//  MonthlyTasks
//
//  Created by Роман Комаров on 23.02.2025.
//

import UIKit

final class MainCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func update(with data: MainCellData) {
        titleLabel.text = data.title
    }

    private lazy var titleLabel = UILabel()

    private func configureUI() {
        contentView.backgroundColor = .white

        addSubview(titleLabel)
    }

    private func configureConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
