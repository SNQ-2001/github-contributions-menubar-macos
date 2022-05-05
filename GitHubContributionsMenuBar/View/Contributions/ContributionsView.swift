//
//  ContributionsView.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI
import SkeletonUI

public struct ContributionsView: View {
    @ObservedObject var viewModel: ContributionsViewModel
    @State var hover: Bool = false
    @Environment(\.colorScheme) var colorScheme
    public var body: some View {
        VStack {
            HStack {
                HStack(spacing: 6) {
                    createImage()
                        .resizable()
                        .frame(width: 10, height: 10)
                        .unredacted()
                        .background(
                            Color(
                                red: colorScheme == .dark ? 1 : 0,
                                green: colorScheme == .dark ? 1 : 0,
                                blue: colorScheme == .dark ? 1 : 0
                            )
                            .opacity(hover ? 0.3 : 0.0)
                            .frame(width: 15, height: 15)
                            .cornerRadius(10)
                        )
                        .onHover { hovering in
                            hover = hovering
                        }
                        .onTapGesture {
                            withAnimation {
                                viewModel.viewMode.toggle()
                            }
                        }
                    Text(viewModel.username)
                        .skeleton(with: color().isEmpty)
                        .shape(type: .rounded(.radius(5, style: .continuous)))
                        .appearance(type: .solid(
                            color: .white.opacity(0.1),
                            background: .gray.opacity(0.1)
                        ))
                        .multiline(lines: 1, scales: [1: 0.5])
                        .animation(type: .pulse())
                        .frame(height: 12)
                }
                Spacer()
                Text(createContributionsCount(count: viewModel.contributions.count))
                    .skeleton(with: skeletonFlag())
                    .shape(type: .rounded(.radius(5, style: .continuous)))
                    .appearance(type: .solid(
                        color: .white.opacity(0.1),
                        background: .gray.opacity(0.1)
                    ))
                    .multiline(lines: 1, scales: [1: 0.5])
                    .animation(type: .pulse())
                    .frame(height: 12)
            }
            .captionStyle()
            if viewModel.viewMode {
                SettingsView(viewModel: viewModel)
            } else {
                if color().isEmpty {
                    Spacer()
                    IndicatorView()
                    Spacer()
                } else {
                    GridStack(rows: 7, columns: 20, spacing: 3.0) { row, column in
                        if let color = color().element(at: row)?.element(at: column) {
                            color.tileStyle()
                        } else {
                            Color.clear
                        }
                    }
                }
            }
        }
    }
    private func color() -> [[Color]] {
        if viewModel.thema == 0 {
            return viewModel.contributions.levels.map { $0.map(\.Green) }
        } else if viewModel.thema == 1 {
            return viewModel.contributions.levels.map { $0.map(\.Blue) }
        } else if viewModel.thema == 2 {
            return viewModel.contributions.levels.map { $0.map(\.Red) }
        } else if viewModel.thema == 3 {
            return viewModel.contributions.levels.map { $0.map(\.Purple) }
        } else {
            return viewModel.contributions.levels.map { $0.map(\.Green) }
        }
    }
    private func skeletonFlag() -> Bool {
        if viewModel.viewMode {
            return true
        } else if color().isEmpty {
            return true
        } else {
            return false
        }
    }
    private func createContributionsCount(count: Int) -> String {
        return count <= 1 ? "\(count) contribution" : "\(count) contributions"
    }
    private func createImage() -> Image {
        if viewModel.viewMode {
            return Image("GitHubMark")
        } else {
            return Image(systemName: "gearshape")
        }
    }
}
