//
//  Contribution.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import Foundation

extension GitHub {
    public struct Contribution {

        /// The date when the contributions ocurred.
        public let date: Date

        /// Number of contributions.
        public let count: Int

        /// Level of contributions.
        public let level: Level

        /// Constants that indicate the amount of contributions:
        /// Level `.zero` means zero contributions.
        public enum Level: Int, CaseIterable {
            case zero, first, second, third, fourth
        }

        public init(date: Date, count: Int, level: Level) {
            self.date = date
            self.count = count
            self.level = level
        }
    }
}
