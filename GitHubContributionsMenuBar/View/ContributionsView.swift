//
//  ContributionsView.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI
import SkeletonUI

public struct ContributionsView: View {
    @Environment(\.redactionReasons) var redactionReasons

    let colors: [[Color]]
    let topLeadingText: String?
    let topTrailingText: String?

    private let tileSpacing: CGFloat = 3.0

    public var body: some View {
        VStack {
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: "gearshape")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .unredacted()
                    Image("GitHubMark")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .unredacted()
                    topLeadingText.map(Text.init)
                        .skeleton(with: colors.isEmpty)
                        .shape(type: .rounded(.radius(5, style: .continuous)))
                        .appearance(type: .solid(
                            color: .white.opacity(0.1),
                            background: .gray.opacity(0.1)
                        ))
                        .multiline(lines: 1, scales: [1: 0.5])
                        .animation(type: .pulse())
                        .frame(height: 12)
                }
                Spacer()
                topTrailingText.map(Text.init)
                    .skeleton(with: colors.isEmpty)
                    .shape(type: .rounded(.radius(5, style: .continuous)))
                    .appearance(type: .solid(
                        color: .white.opacity(0.1),
                        background: .gray.opacity(0.1)
                    ))
                    .multiline(lines: 1, scales: [1: 0.5])
                    .animation(type: .pulse())
                    .frame(height: 12)
            }
            .captionStyle()

            if colors.isEmpty {
                Spacer()
                IndicatorView()
                Spacer()
            } else {
                GridStack(rows: 7, columns: 20, spacing: tileSpacing) { row, column in
                    if let color = colors.element(at: row)?.element(at: column) {
                        color.tileStyle()
                    } else {
                        Color.clear
                    }
                }
            }
        }
    }

    public init(colors: [[Color]], topLeadingText: String? = nil, topTrailingText: String? = nil) {
        self.colors = colors
        self.topLeadingText = topLeadingText
        self.topTrailingText = topTrailingText
    }

}
