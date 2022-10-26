//
//  Contribution.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import Foundation

public extension GitHub {
    struct Contribution {

        /// The date when the contributions ocurred.
        let date: Date

        /// Number of contributions.
        let count: Int

        /// Level of contributions.
        let level: Level

        /// Constants that indicate the amount of contributions:
        /// Level `.zero` means zero contributions.
        enum Level: Int, CaseIterable {
            case zero, first, second, third, fourth
        }

        init(date: Date, count: Int, level: Level) {
            self.date = date
            self.count = count
            self.level = level
        }
    }
}
