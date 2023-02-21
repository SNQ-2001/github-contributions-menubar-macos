//
//  PreferencesView.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI

struct PreferencesView: View {
    @ObservedObject var viewModel: AppViewModel

    @FocusState var focusState: Bool

    private var openSourceURL: URL {
        URL(string: "https://github.com/SNQ-2001/github-contributions-menubar-macos")!
    }

    var body: some View {
        VStack(spacing: 5) {
            GroupBox {
                HStack(spacing: 3) {
                    username()

                    thema()
                }
            }

            GroupBox {
                openSource()
            }
            .onTapGesture {
                NSWorkspace.shared.open(openSourceURL)
            }
        }
        .padding(15)
        .frame(minWidth: 300)
    }

    private func username() -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("User Name")
                .font(.system(size: 8))
                .frame(height: 6)
                .padding(.leading, 2)
                .captionStyle()
            TextField("User Name", text: $viewModel.username)
                .focused($focusState)
                .disableAutocorrection(true)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.horizontal, 5)
                .padding(.vertical, 2.3)
                .background(focusState ? .quaternary : .tertiary)
                .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 0.5).cornerRadius(6))
                .cornerRadius(6)
        }
    }

    private func thema() -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Thema")
                .font(.system(size: 8))
                .frame(height: 6)
                .padding(.leading, 2)
                .captionStyle()
            Picker("", selection: $viewModel.thema) {
                ForEach(0 ..< ThemaColor.allCases.count, id: \.self) { index in
                    Text(ThemaColor.allCases[index].colorName).tag(ThemaColor.allCases[index])
                }
            }
            .labelsHidden()
        }
    }

    private func openSource() -> some View {
        Label {
            openSourceLabel()
        } icon: {
            Image(systemName: "swift")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 17, height: 17)
                .padding(6)
                .background(Color.orange)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
        }
        .labelStyle(.settings)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 2.5)
        .padding(.leading, 4.5)
        .lineLimit(1)
    }

    private func openSourceLabel() -> some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Open Source")
                .font(.body)
                .foregroundColor(.primary)

            Text("Feel free to contribute!")
                .font(.footnote)
                .foregroundColor(.secondary)
                .tint(.secondary)
        }
    }
}
