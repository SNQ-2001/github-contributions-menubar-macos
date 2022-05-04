//
//  GitHubContributionsMenuBarApp.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI

@main
struct GitHubContributionsMenuBarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        Settings {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, ObservableObject, NSApplicationDelegate {
    @Published var statusItem: NSStatusItem?
    @Published var popover = NSPopover()
    func applicationDidFinishLaunching(_ notification: Notification) {
        setUpMenu()
    }
    func setUpMenu() {
        popover.animates = true
        popover.behavior = .transient

        popover.contentViewController = NSViewController()
        popover.contentViewController?.view = NSHostingView(rootView: ContentView())

        popover.contentViewController?.view.window?.makeKey()

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let menuButton = statusItem?.button {
            menuButton.image = NSImage(named: NSImage.Name("menubar"))
            menuButton.action = #selector(menuButtonAction(sender:))
        }
    }
    @objc func menuButtonAction(sender: AnyObject) {
        if popover.isShown {
            popover.performClose(sender)
        } else {
            if let menuButton = statusItem?.button {
                popover.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: .minY)
            }
        }
    }
}
