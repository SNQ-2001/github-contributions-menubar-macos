//
//  ViewType.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2023/01/10.
//

import Foundation

enum ViewType {
    case contributions
    case settings
    case emptyUserName
    case error(Error)
    case progress
}

extension ViewType {
    static func == (lhs: ViewType, rhs: ViewType) -> Bool {
        switch (lhs, rhs) {
        case (.contributions, .contributions),
             (.settings, .settings),
             (.emptyUserName, .emptyUserName),
             (.progress, .progress):
            return true
        case let (.error(lhsError), .error(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}
