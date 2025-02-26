//
//  TimerViewController.swift
//  MonthlyTasks
//
//  Created by Роман Комаров on 25.02.2025.
//

import UIKit

final class TimerViewController: UIViewController {
    deinit {
        stopTimer()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        configureLayout()

        displayValue(for: timer(value: startTime))

        startTimer()
    }

    private lazy var hoursView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()

    private lazy var hoursLabel = UILabel()

    private lazy var minutesView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()

    private lazy var minutesLabel = UILabel()

    private lazy var secondsView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()

    private lazy var secondsLabel = UILabel()

    private lazy var firstColonLabel: UILabel = {
        let label = UILabel()
        label.text = " : "
        return label
    }()

    private lazy var secondColonLabel: UILabel = {
        let label = UILabel()
        label.text = " : "
        return label
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            hoursView,
            firstColonLabel,
            minutesView,
            secondColonLabel,
            secondsView
        ])
        stackView.axis = .horizontal
        stackView.spacing = 0
        return stackView
    }()

    private var timer: Timer?

    private var startTime = 3606

    private func startTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
        timer?.tolerance = 0.1
        RunLoop.current.add(timer ?? Timer(), forMode: .common)
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func timer(value: Int) -> (hours: String, minutes: String, seconds: String) {
        let hours = value / 3600
        let minutes = (value - hours * 3600) / 60
        let seconds = (value - hours * 3600) % 60
        return (
            String(format: "%02i", hours),
            String(format: "%02i", minutes),
            String(format: "%02i", seconds)
        )
    }

    @objc
    private func updateTimer() {
        guard startTime > 0 else {
            stopTimer()
            return
        }

        let timerValue = timer(value: startTime)

        displayValue(for: timerValue)

        startTime -= 1
    }
}

// MARK: - Layout

private extension TimerViewController {
    func configureLayout() {
        [
            (hoursView, hoursLabel),
            (minutesView, minutesLabel),
            (secondsView, secondsLabel)
        ].forEach { (view, label) in
            view.addSubview(label)

            label.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                view.widthAnchor.constraint(equalToConstant: 40),
                view.heightAnchor.constraint(equalToConstant: 40),
            ])
        }

        view.addSubview(contentStackView)

        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - Display data

private extension TimerViewController {
    func displayValue(for timer: (hours: String, minutes: String, seconds: String)) {
        if hoursLabel.text != timer.hours {
            pushTransition(for: hoursLabel, duration: 0.2)
            hoursLabel.text = timer.hours
        }

        if minutesLabel.text != timer.minutes {
            pushTransition(for: minutesLabel, duration: 0.2)
            minutesLabel.text = timer.minutes
        }

        if secondsLabel.text != timer.seconds {
            pushTransition(for: secondsLabel, duration: 0.2)
            secondsLabel.text = timer.seconds
        }
    }
}

// MARK: - Animation transition

private extension TimerViewController {
    func pushTransition(for view: UIView, duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(
            name: CAMediaTimingFunctionName.easeInEaseOut
        )
        animation.type = CATransitionType.push
        animation.subtype = .fromTop
        animation.duration = duration

        view.layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
}
