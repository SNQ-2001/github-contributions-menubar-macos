//
//  ContributionsView.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI

public struct ContributionsView: View {
    @ObservedObject var viewModel: ContributionsViewModel
    @State var hover: Bool = false
    @State var hover1: Bool = false
    @Environment(\.colorScheme) var colorScheme
    public var body: some View {
        VStack {
            HStack(spacing: 6) {
                createImage()
                    .resizable()
                    .frame(width: 10, height: 10)
                    .unredacted()
                    .background(
                        Color(colorScheme == .dark ? .white : .black)
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
                    .frame(height: 12)
                Spacer()
                if viewModel.viewMode {
                    Text("Quit")
                        .frame(height: 10)
                        .background(
                            Color(colorScheme == .dark ? .white : .black)
                                .opacity(hover1 ? 0.3 : 0.0)
                                .frame(width: 30, height: 15)
                                .cornerRadius(5)
                        )
                        .onHover { hovering in
                            hover1 = hovering
                        }
                        .onTapGesture {
                            NSApplication.shared.terminate(nil)
                        }
                        .padding(.trailing, 3)
                } else {
                    Text(createContributionsCount(count: viewModel.contributions.count))
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
        switch viewModel.thema {
        case .green:
            return viewModel.contributions.levels.map { $0.map(\.green) }
        case .blue:
            return viewModel.contributions.levels.map { $0.map(\.blue) }
        case .red:
            return viewModel.contributions.levels.map { $0.map(\.red) }
        case .purple:
            return viewModel.contributions.levels.map { $0.map(\.purple) }
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
