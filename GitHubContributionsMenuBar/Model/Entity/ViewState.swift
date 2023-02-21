//
//  ViewState.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2023/01/10.
//

import Foundation

enum ViewState {
    case success
    case failure
    case emptyUserName
    case inProgress
}

// extension ViewState {
//    static func == (lhs: ViewType, rhs: ViewType) -> Bool {
//        switch (lhs, rhs) {
//        case (.success, .success),
//             (.emptyUserName, .emptyUserName),
//             (.inProgress, .inProgress):
//            return true
//        case let (.failure(lhsError), .failure(rhsError)):
//            return lhsError.localizedDescription == rhsError.localizedDescription
//        default:
//            return false
//        }
//    }
// }
