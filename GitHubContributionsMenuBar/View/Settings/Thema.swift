//
//  Thema.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI

struct Thema: View {
    @ObservedObject var viewModel: ContributionsViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("Thema")
                .font(.system(size: 8))
                .frame(height: 6)
                .padding(.leading, 2)
                .captionStyle()
            Picker("", selection: $viewModel.thema) {
                Text("Green")
                    .tag(0)
                Text("Blue")
                    .tag(1)
                Text("Red")
                    .tag(2)
                Text("Purple")
                    .tag(3)
            }
            .labelsHidden()
        }
    }
}
