//
//  ViewExtensions.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI

// MARK: - TextCaption
struct TextCaption: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption2)
            .foregroundColor(.secondary)
            .textCase(.uppercase)
            .lineLimit(1)
    }
}
extension View {
    func captionStyle() -> some View {
        modifier(TextCaption())
    }
}

// MARK: - Tile
struct Tile: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(RoundedRectangle(cornerRadius: 2, style: .continuous).stroke(Color.tileBorder, lineWidth: 1))
            .cornerRadius(2)
    }

}
extension View {
    func tileStyle() -> some View {
        modifier(Tile())
    }
}
