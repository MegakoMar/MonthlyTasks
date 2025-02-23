//
//  StarView.swift
//  MonthlyTasks
//
//  Created by Роман Комаров on 10.02.2025.
//

import UIKit

final class StarView: UIView {
    init(frame: CGRect, gradientDirection: GradientDirection) {
        self.gradientDirection = gradientDirection

        super.init(frame: frame)

        configureUI()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updatePercent(value: Float) {
        starImageBackgroundView.percent = CGFloat(value / 100)
    }

    private let gradientDirection: GradientDirection

    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView(frame: bounds)
        imageView.image = .init(systemName: "star.fill")
        imageView.tintColor = .gray
        return imageView
    }()

    private lazy var starImageBackgroundView: GradientImageView = {
        let imageView = GradientImageView(frame: bounds, gradientDirection: gradientDirection)
        imageView.image = .init(systemName: "star.fill")
        imageView.tintColor = .red
        return imageView
    }()

    private func configureUI() {
        addSubview(starImageView)
        addSubview(starImageBackgroundView)
    }

    private func configureConstraints() {
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        starImageBackgroundView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            starImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            starImageView.topAnchor.constraint(equalTo: topAnchor),
            starImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            starImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            starImageBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            starImageBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            starImageBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            starImageBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
