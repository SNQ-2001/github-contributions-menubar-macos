//
//  ContributionsViewModel.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import Combine
import SwiftUI

final class ContributionsViewModel: ObservableObject {
    struct Contributions {
        var levels: [[GitHub.Contribution.Level]] = []
        var count: Int = .zero
    }

    @Published var contributions: Contributions = .init()
    @Published var username: String = ""
    @Published var thema: Int = 0
    @Published var viewMode: Bool = false

    private let queue = DispatchQueue(label: "com.andergoig.GitHubContributions.network")

    func getContributions() {
        guard contributions.levels.isEmpty else { return }
        GitHub.getContributions(for: username, queue: queue)
            .subscribe(on: queue)
            .replaceError(with: [])
            .map(Self.mapContributions)
            .receive(on: DispatchQueue.main)
            .assign(to: &$contributions)
    }

    func updateContributions() {
        contributions = .init()
        username = UserDefaults.standard.string(forKey: "username") ?? ""
        thema = UserDefaults.standard.integer(forKey: "thema")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.getContributions()
        }
    }

    func setUsename() {
        UserDefaults.standard.set(username, forKey: "username")
    }

    func setThema() {
        UserDefaults.standard.set(thema, forKey: "thema")
    }

    private static func mapContributions(_ contributions: [GitHub.Contribution]) -> Contributions {
        guard let lastDate = contributions.last?.date else { return .init() }
        let tilesCount = 7 * 20 - (7 - Calendar.current.component(.weekday, from: lastDate))
        let levels = contributions.suffix(tilesCount).map(\.level).chunked(into: 7)
        let count = contributions.reduce(0) { $0 + $1.count }
        return Contributions(levels: levels, count: count)
    }
}
