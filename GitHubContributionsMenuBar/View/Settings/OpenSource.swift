//
//  OpenSource.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI

struct OpenSource: View {
    var body: some View {
        Label {
            VStack(alignment: .leading, spacing: 3) {
                Text("Open Source")
                    .font(.body)
                    .foregroundColor(.primary)

                Text("Feel free to contribute!")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .tint(.secondary)
            }
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
}
