//
//  UserName.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI

struct UserName: View {
    @ObservedObject var viewModel: ContributionsViewModel
    @FocusState var focusState: Bool
    var body: some View {
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
                .onChange(of: viewModel.username) { _ in
                    viewModel.setUsename()
                }
        }
    }
}
