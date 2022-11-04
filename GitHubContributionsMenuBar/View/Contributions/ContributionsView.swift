//
//  ContributionsView.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SkeletonUI
import SwiftUI

public struct ContributionsView: View {
    @ObservedObject var viewModel: ContributionsViewModel
    @State var hover: Bool = false
    @State var hover1: Bool = false
    @Environment(\.colorScheme) var colorScheme
    public var body: some View {
        VStack {
            HStack {
                HStack(spacing: 6) {
                    createImage()
                        .resizable()
                        .frame(width: viewModel.viewMode ? 10 : 10, height: viewModel.viewMode ? 10 : 10)
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
                if viewModel.viewMode {
                    Text("Quit")
                        .frame(height: 10)
                        .background(
                            Color(
                                red: colorScheme == .dark ? 1 : 0,
                                green: colorScheme == .dark ? 1 : 0,
                                blue: colorScheme == .dark ? 1 : 0
                            )
                            .opacity(hover1 ? 0.3 : 0.0)
                            .frame(width: 30, height: 15)
                            .cornerRadius(5)
                        )
                        .onHover { hovering in
                            hover1 = hovering
                        }
                        .onTapGesture {
                            NSApp.terminate(self)
                        }
                        .padding(.trailing, 3)
                } else {
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
            }
            .captionStyle()
            if viewModel.viewMode {
                SettingsView(viewModel: viewModel)
            } else {
                if color().isEmpty {
                    UXView(viewModel: viewModel)
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
            return viewModel.contributions.levels.map { $0.map(\.green) }
        } else if viewModel.thema == 1 {
            return viewModel.contributions.levels.map { $0.map(\.blue) }
        } else if viewModel.thema == 2 {
            return viewModel.contributions.levels.map { $0.map(\.red) }
        } else if viewModel.thema == 3 {
            return viewModel.contributions.levels.map { $0.map(\.purple) }
        } else {
            return viewModel.contributions.levels.map { $0.map(\.green) }
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
            return Image(systemName: "arrowshape.turn.up.backward.circle")
        } else {
            return Image(systemName: "gearshape")
        }
    }
}
