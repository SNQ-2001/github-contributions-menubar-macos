//
//  GitHubContributionsMenuBarApp.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI

@main
struct GitHubContributionsMenuBarApp: App {
    @StateObject var viewModel = AppViewModel()

    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        MenuBarExtra {
            ContentView(viewModel: viewModel, delegate: delegate)
        } label: {
            Image(nsImage: NSImage(named: Asset.menuBarIcon.name)!)
        }
        .menuBarExtraStyle(.window)

        Settings {
            PreferencesView(viewModel: viewModel)
        }
    }
}
