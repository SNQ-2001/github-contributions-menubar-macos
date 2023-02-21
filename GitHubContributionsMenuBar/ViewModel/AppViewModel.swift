//
//  AppViewModel.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import Combine
import SwiftUI

final class AppViewModel: ObservableObject {
    @Published var contributions: Contributions = .init()
    @Published var viewType: ViewType = .contributions
    @Published var hoverSwitchingButton: Bool = false
    @Published var hoverQuitButton: Bool = false

    @AppStorage("username") var username: String = ""
    @AppStorage("thema") var thema: ThemaColor = .init(rawValue: 0) ?? .green

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
        withAnimation { self.viewType = .progress }
        if username == "" { viewType = .emptyUserName; return }
        GitHub.getContributions(for: username, queue: queue)
            .subscribe(on: queue)
            .map(Self.mapContributions)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    return
                case let .failure(error):
                    withAnimation { self.viewType = .error(error) }
                }
            } receiveValue: { [weak self] contributions in
                guard let self else { return }
                self.contributions = contributions
                withAnimation { self.viewType = .contributions }
            }
            .store(in: &cancellable)
    }

    func updateContributions() {
        contributions = .init()
        getContributions()
    }

    private static func mapContributions(_ contributions: [GitHub.Contribution]) -> Contributions {
        guard let lastDate = contributions.last?.date else { return .init() }
        let tilesCount = 7 * 20 - (7 - Calendar.current.component(.weekday, from: lastDate))
        let levels = contributions.suffix(tilesCount).map(\.level).chunked(into: 7)
        let count = contributions.reduce(0) { $0 + $1.count }
        return Contributions(levels: levels, count: count)
    }
}
