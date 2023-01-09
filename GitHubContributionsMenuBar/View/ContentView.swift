//
//  ContentView.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContributionsViewModel
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack(spacing: 8) {
            toolBar

            if viewModel.viewMode {
                settings
            } else {
                contributions
            }
        }
        .frame(width: 265, height: 115)
        .padding(.all, 12)
        .onChange(of: viewModel.viewMode) { _ in
            viewModel.updateContributions()
        }
    }
}

extension ContentView {
    private var contributions: some View {
        ContributionsView(viewModel: viewModel)
    }

    private var settings: some View {
        SettingsView(viewModel: viewModel)
    }

    private var toolBar: some View {
        HStack(spacing: 6) {
            switchingButton

            Text(viewModel.username)
                .frame(height: 12)

            Spacer()

            if viewModel.viewMode {
                quitButton
            } else {
                contributionsCountLabel
            }
        }
        .captionStyle()
    }

    private var switchingButton: some View {
        Image(systemName: viewModel.viewMode ? "arrowshape.turn.up.backward.circle" : "gearshape")
            .resizable()
            .frame(width: 10, height: 10)
            .unredacted()
            .background(
                Color.primary
                    .opacity(viewModel.hoverSwitchingButton ? 0.3 : 0.0)
                    .frame(width: 15, height: 15)
                    .cornerRadius(10)
            )
            .onHover { hovering in
                viewModel.hoverSwitchingButton = hovering
            }
            .onTapGesture {
                withAnimation {
                    viewModel.viewMode.toggle()
                }
            }
    }

    private var quitButton: some View {
        Text("Quit")
            .frame(height: 10)
            .background(
                Color.primary
                    .opacity(viewModel.hoverQuitButton ? 0.3 : 0.0)
                    .frame(width: 30, height: 15)
                    .cornerRadius(5)
            )
            .onHover { hovering in
                viewModel.hoverQuitButton = hovering
            }
            .onTapGesture {
                NSApplication.shared.terminate(nil)
            }
            .padding(.trailing, 3)
    }

    private var contributionsCountLabel: some View {
        let count = viewModel.contributions.count
        return Text("\(count <= 1 ? "\(count) contribution" : "\(count) contributions")")
            .frame(height: 12)
    }
}
