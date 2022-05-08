//
//  ContentView.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContributionsViewModel
    var body: some View {
        ContributionsView(viewModel: viewModel)
            .frame(width: 265, height: 115)
            .padding(.all, 12)
            .onChange(of: viewModel.viewMode) { newValue in
                viewModel.updateContributions()
            }
    }
}
