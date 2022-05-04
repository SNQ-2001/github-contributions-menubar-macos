//
//  ContentView.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContributionsViewModel(username: "SNQ-2001")
    var body: some View {
        Contributions(viewModel: viewModel)
    }
}
