//
//  NSIndicator.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI

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
