//
//  CLDecoratorView.swift
//  MonthlyTasks
//
//  Created by Роман Комаров on 23.02.2025.
//

import UIKit

final class CLDecoratorView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .gray
        layer.cornerRadius = 12
    }
}
