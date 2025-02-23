//
//  CLCell.swift
//  MonthlyTasks
//
//  Created by Роман Комаров on 23.02.2025.
//

import UIKit

final class CLCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(with data: CLCellData) {
        contentView.backgroundColor = data.color
    }

    private enum Constants {
        static let cornerRadius: CGFloat = 12
    }

    private func configure() {
        contentView.layer.cornerRadius = Constants.cornerRadius
    }
}
