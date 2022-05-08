//
//  NSIndicator.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI
import Lottie
import Foundation

struct UXView: View {
    @ObservedObject var viewModel: ContributionsViewModel
    var body: some View {
        Spacer()
        if viewModel.username.isEmpty {
            HStack {
                Text("\(Image(systemName: "info.circle")) Set a GitHub username")
                    .fontWeight(.medium)
                    .foregroundColor(.blue)
            }
            .onTapGesture {
                withAnimation {
                    viewModel.viewMode.toggle()
                }
            }
        } else {
            IndicatorView()
        }
        Spacer()
    }
}

struct IndicatorView: NSViewRepresentable {
    func makeNSView(context: Context) -> NSProgressIndicator {
        let indicator = NSProgressIndicator()
        indicator.style = .spinning
        indicator.startAnimation(true)
        return indicator
    }
    func updateNSView(_ nsView: NSProgressIndicator, context: Context) {
    }
}
