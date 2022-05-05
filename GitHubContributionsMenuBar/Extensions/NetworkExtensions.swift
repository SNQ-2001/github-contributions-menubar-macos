//
//  NetworkExtensions.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI

extension GitHub.Contribution.Level {
    var Green: Color {
        switch self {
        case .zero: return .emptyTile
        case .first: return .greenLevel1
        case .second: return .greenLevel2
        case .third: return .greenLevel3
        case .fourth: return .greenLevel4
        }
    }
    var Blue: Color {
        switch self {
        case .zero: return .emptyTile
        case .first: return .blueLevel1
        case .second: return .blueLevel2
        case .third: return .blueLevel3
        case .fourth: return .blueLevel4
        }
    }
    var Red: Color {
        switch self {
        case .zero: return .emptyTile
        case .first: return .redLevel1
        case .second: return .redLevel2
        case .third: return .redLevel3
        case .fourth: return .redLevel4
        }
    }
    var Purple: Color {
        switch self {
        case .zero: return .emptyTile
        case .first: return .purpleLevel1
        case .second: return .purpleLevel2
        case .third: return .purpleLevel3
        case .fourth: return .purpleLevel4
        }
    }
}
