//
//  NetworkExtensions.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI

extension GitHub.Contribution.Level {
    var color: Color {
        switch self {
        case .zero: return .emptyTile
        case .first: return .greenLevel1
        case .second: return .greenLevel2
        case .third: return .greenLevel3
        case .fourth: return .greenLevel4
        }
    }
}
