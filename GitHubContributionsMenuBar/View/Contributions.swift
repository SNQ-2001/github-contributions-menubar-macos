//
//  Contributions.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI

struct Contributions: View {
    @ObservedObject var viewModel: ContributionsViewModel
    @Binding var username: String
    var body: some View {
        ContributionsView(
            rowsCount: ContributionsViewModel.rowsCount,
            columnsCount: ContributionsViewModel.columnsCount,
            colors: viewModel.contributions.levels.map { $0.map(\.color) },
            topLeadingText: username,
            topTrailingText: createContributionsCount(count: viewModel.contributions.count)
        )
        .frame(width: 265, height: 114)
        .padding(.all, 12)
        .onAppear(perform: getContributions)
    }
    private func getContributions() {
        viewModel.getContributions(username: username)
    }
    private func createContributionsCount(count: Int) -> String {
        return count <= 1 ? "\(count) contribution" : "\(count) contributions"
    }
}
