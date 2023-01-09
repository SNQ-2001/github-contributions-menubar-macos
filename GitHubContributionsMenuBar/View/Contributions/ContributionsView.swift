//
//  ContributionsView.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI

public struct ContributionsView: View {
    @ObservedObject var viewModel: ContributionsViewModel
    public var body: some View {
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
}
