//
//  GitHubContributionsMenuBarApp.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI

@main
struct GitHubContributionsMenuBarApp: App {
    @StateObject var viewModel = ContributionsViewModel()
    var body: some Scene {
        MenuBarExtra {
            ContentView(viewModel: viewModel)
        } label: {
            Image(nsImage: NSImage(named: Asset.menuBarIcon.name)!)
        }
        .menuBarExtraStyle(.window)
    }
}
