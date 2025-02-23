//
//  GradientImageView.swift
//  MonthlyTasks
//
//  Created by Роман Комаров on 16.02.2025.
//

import UIKit

final class GradientImageView: UIImageView {
    init(frame: CGRect, gradientDirection: GradientDirection) {
        self.gradientDirection = gradientDirection
        super.init(frame: frame)

        configureLayer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var percent: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        CATransaction.begin()
        CATransaction.setDisableActions(true)

        gLayer.frame = bounds
        gLayer.locations = [0.0, percent as NSNumber, percent as NSNumber, 1.0]
        gLayer.colors = [
            UIColor.red.cgColor,
            UIColor.red.cgColor,
            UIColor.red.withAlphaComponent(0).cgColor,
            UIColor.red.withAlphaComponent(0).cgColor,
        ]

        CATransaction.commit()
    }

    private let gradientDirection: GradientDirection

    private let gLayer = CAGradientLayer()

    private var startPoint: CGPoint {
        switch gradientDirection {
        case .leftRight:
            return .zero
        case .bottomTop:
            return .init(x: 0.5, y: 1.0)
        }
    }

    private var endPoint: CGPoint {
        switch gradientDirection {
        case .leftRight:
            return .init(x: 1.0, y: 0.0)
        case .bottomTop:
            return .init(x: 0.5, y: 0.0)
        }
    }

    private func configureLayer() -> Void {
        gLayer.startPoint = startPoint
        gLayer.endPoint = endPoint
        layer.mask = gLayer
    }
}

