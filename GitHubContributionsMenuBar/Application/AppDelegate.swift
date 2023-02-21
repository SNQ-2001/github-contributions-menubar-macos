//
//  AppDelegate.swift
//  GitHubContributionsMenuBar
//
//  Created by TAISHIN MIYAMOTO on 2023/02/21
//
//

import AppKit

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    private var settingsWindow: NSWindow? {
        NSApp.windows.first(where: { window in
            window.frameAutosaveName == "com_apple_SwiftUI_Settings_window"
        })
    }

    func applicationDidFinishLaunching(_: Notification) {}

    func openPreferences() {
        NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)

        guard let window = settingsWindow else { return }

        if window.canBecomeMain {
            window.orderFrontRegardless()
            window.center()
            NSApp.activate(ignoringOtherApps: true)
        }
    }
}
