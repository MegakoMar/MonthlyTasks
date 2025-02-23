//
//  ViewController.swift
//  MonthlyTasks
//
//  Created by Роман Комаров on 02.02.2025.
//

import UIKit

class StarsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureConstraints()
    }

    private lazy var leftStarView = StarView(frame: .zero, gradientDirection: .leftRight)

    private lazy var rightStarView = StarView(frame: .zero, gradientDirection: .bottomTop)

    private lazy var starsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftStarView, rightStarView])
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()

    private lazy var sliderView: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.addTarget(self, action: #selector(changeSlider), for: .valueChanged)
        return slider
    }()

    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.text = "0 %"
        return label
    }()

    private func configureUI() {
        view.backgroundColor = .white

        [starsStackView, sliderView, percentLabel].forEach {
            view.addSubview($0)
        }
    }

    private func configureConstraints() {
        starsStackView.translatesAutoresizingMaskIntoConstraints = false
        leftStarView.translatesAutoresizingMaskIntoConstraints = false
        rightStarView.translatesAutoresizingMaskIntoConstraints = false
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        percentLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            leftStarView.widthAnchor.constraint(equalToConstant: 100),
            leftStarView.heightAnchor.constraint(equalToConstant: 100),
            rightStarView.widthAnchor.constraint(equalToConstant: 100),
            rightStarView.heightAnchor.constraint(equalToConstant: 100),
            starsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            starsStackView.bottomAnchor.constraint(equalTo: sliderView.topAnchor, constant: -20),
            sliderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            sliderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            sliderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            percentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            percentLabel.topAnchor.constraint(equalTo: sliderView.bottomAnchor, constant: 20)
        ])
    }

    @objc
    private func changeSlider() {
        leftStarView.updatePercent(value: sliderView.value)
        rightStarView.updatePercent(value: sliderView.value)
        percentLabel.text = "\(Int(sliderView.value)) %"
    }
}

