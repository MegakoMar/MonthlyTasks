//
//  MainEntities.swift
//  MonthlyTasks
//
//  Created by Роман Комаров on 23.02.2025.
//

import Foundation

enum MainEntities: CaseIterable {
    case februaryEasy
    case februaryMedium
    case februaryHard

    var title: String {
        switch self {
        case .februaryEasy:
            return "Февраль Easy"
        case .februaryMedium:
            return "Февраль Medium"
        case .februaryHard:
            return "Февраль Hard"
        }
    }
}
