//
//  UICollectionReusableView+reuseIdentifier.swift
//  MonthlyTasks
//
//  Created by Роман Комаров on 23.02.2025.
//

import UIKit

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
