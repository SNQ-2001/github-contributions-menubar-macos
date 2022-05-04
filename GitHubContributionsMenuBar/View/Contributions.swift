//
//  Contributions.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI

struct Contributions: View {
    @ObservedObject var viewModel: ContributionsViewModel
    var body: some View {
        ContributionsView(
            colors: viewModel.contributions.levels.map { $0.map(\.color) },
            topLeadingText: viewModel.username,
            topTrailingText: createContributionsCount(count: viewModel.contributions.count)
        )
        .frame(width: 265, height: 115)
        .padding(.all, 12)
        .onAppear(perform: getContributions)
    }
    private func getContributions() {
        viewModel.getContributions(username: viewModel.username)
    }
    private func createContributionsCount(count: Int) -> String {
        return count <= 1 ? "\(count) contribution" : "\(count) contributions"
    }
}
