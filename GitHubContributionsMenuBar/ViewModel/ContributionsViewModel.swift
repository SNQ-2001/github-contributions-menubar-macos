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
    @Published var viewMode: Bool = false

    @AppStorage("username") var username: String = ""
    @AppStorage("thema") var thema: Int = 0

    let themaColor = ["Green", "Blue", "Red", "Purple"]

    private let queue = DispatchQueue(label: "com.andergoig.GitHubContributions.network")

    private var cancellable = Set<AnyCancellable>()

    init() {
        NotificationCenter.default.publisher(for: NSWindow.didBecomeKeyNotification)
            .sink { [weak self] _ in
                guard let self else { return }
                self.updateContributions()
            }
            .store(in: &cancellable)
    }

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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.getContributions()
        }
    }

    private static func mapContributions(_ contributions: [GitHub.Contribution]) -> Contributions {
        guard let lastDate = contributions.last?.date else { return .init() }
        let tilesCount = 7 * 20 - (7 - Calendar.current.component(.weekday, from: lastDate))
        let levels = contributions.suffix(tilesCount).map(\.level).chunked(into: 7)
        let count = contributions.reduce(0) { $0 + $1.count }
        return Contributions(levels: levels, count: count)
    }
}
