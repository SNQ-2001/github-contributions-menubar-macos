//
//  ThemaColor.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2023/01/09.
//

import Foundation

enum ThemaColor: Int {
    case green
    case blue
    case red
    case purple

    var colorName: String {
        switch self {
        case .green:
            return "Green"
        case .blue:
            return "Blue"
        case .red:
            return "Red"
        case .purple:
            return "Purple"
        }
    }
}

extension ThemaColor: CaseIterable {}
