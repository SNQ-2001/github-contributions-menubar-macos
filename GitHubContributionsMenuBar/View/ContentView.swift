//
//  ContentView.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: AppViewModel

    @ObservedObject var delegate: AppDelegate

    var body: some View {
        VStack(spacing: 8) {
            toolBar()

            switch viewModel.viewState {
            case .success:
                contributionsView()
            case .failure:
                errorLabel()
            case .emptyUserName:
                emptyUserNameLabel()
            case .inProgress:
                progressView()
            }
        }
        .frame(width: 265, height: 115)
        .padding(.all, 12)
    }
}

extension ContentView {
    private func contributionsView() -> some View {
        ContributionsView(viewModel: viewModel)
    }

    private func toolBar() -> some View {
        HStack(spacing: 6) {
            preferencesButton()

            Text(viewModel.username)
                .frame(height: 12)

            Spacer()

            contributionsCountLabel()

            quitButton()
        }
        .captionStyle()
    }

    private func preferencesButton() -> some View {
        Image(systemName: "gearshape")
            .resizable()
            .frame(width: 10, height: 10)
            .unredacted()
            .background(
                Color.primary
                    .opacity(viewModel.hoverPreferencesButton ? 0.3 : 0.0)
                    .frame(width: 15, height: 15)
                    .cornerRadius(10)
            )
            .onHover { hovering in
                viewModel.hoverPreferencesButton = hovering
            }
            .onTapGesture {
                delegate.openPreferences()
            }
    }

    private func quitButton() -> some View {
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

    private func contributionsCountLabel() -> some View {
        let count = viewModel.contributions.count
        return Text("\(count <= 1 ? "\(count) contribution" : "\(count) contributions")")
            .frame(height: 12)
    }

    private func errorLabel() -> some View {
        Text("\(Image(systemName: "exclamationmark.triangle")) Unknown error")
            .fontWeight(.medium)
            .foregroundColor(.blue)
            .frame(maxHeight: .infinity)
            .onTapGesture {
                viewModel.updateContributions()
            }
    }

    private func emptyUserNameLabel() -> some View {
        Text("\(Image(systemName: "info.circle")) Set a GitHub username")
            .fontWeight(.medium)
            .foregroundColor(.blue)
            .frame(maxHeight: .infinity)
            .onTapGesture {
                delegate.openPreferences()
            }
    }

    private func progressView() -> some View {
        ProgressView()
            .progressViewStyle(.circular)
            .scaleEffect(1.3)
            .frame(width: 1.3 * 20, height: 1.3 * 20)
            .frame(maxHeight: .infinity)
    }
}
