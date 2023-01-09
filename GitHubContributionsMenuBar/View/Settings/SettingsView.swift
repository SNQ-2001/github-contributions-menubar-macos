//
//  SettingsView.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: ContributionsViewModel
    var openSourceURL: URL {
        URL(string: "https://github.com/SNQ-2001/github-contributions-menubar-macos")!
    }

    var body: some View {
        GroupBox {
            HStack(spacing: 3) {
                UserName(viewModel: viewModel)
                Thema(viewModel: viewModel)
            }
        }
        GroupBox {
            OpenSource()
        }
        .onTapGesture {
            NSWorkspace.shared.open(openSourceURL)
        }
    }
}
