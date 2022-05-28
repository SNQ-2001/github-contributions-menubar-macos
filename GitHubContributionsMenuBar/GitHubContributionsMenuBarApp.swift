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
        Settings {}
    }
}


class AppDelegate: NSObject, NSApplicationDelegate {
    @ObservedObject var viewModel = ContributionsViewModel()
    var statusBarItem: NSStatusItem!
    var popover = NSPopover()
    func applicationDidFinishLaunching(_ notification: Notification) {
        setUpMenu()
    }
    func setUpMenu() {
        // 旧
//        popover.animates = true
//        popover.behavior = .transient
//
//        popover.contentViewController = NSViewController()
//        popover.contentViewController?.view = NSHostingView(rootView: ContentView(viewModel: viewModel))
//
//        popover.contentViewController?.view.window?.makeKey()
//
//        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
//
//        guard let button = self.statusBarItem.button else { return }
//        button.image = NSImage(named: NSImage.Name("menubar"))
//        button.action = #selector(menuButtonAction(sender:))

        // 新
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: ContentView(viewModel: viewModel))
        self.statusBarItem = NSStatusBar.system.statusItem(withLength: CGFloat(NSStatusItem.variableLength))
        guard let button = self.statusBarItem.button else { return }
        button.image = NSImage(named: NSImage.Name("menubar"))
        button.action = #selector(menuButtonAction(sender:))
        // 右クリック
        button.sendAction(on: [.leftMouseUp, .rightMouseUp])
    }

    @objc func menuButtonAction(sender: AnyObject) {
        // 右クリック
        rightClick()
        // 左クリック
        leftClick(sender: sender)
    }

    func rightClick() {
        guard let event = NSApp.currentEvent else { return }
        if event.type == NSEvent.EventType.rightMouseUp {
            let menu = NSMenu()
            menu.addItem(
                withTitle: NSLocalizedString("Quit", comment: "Quit app"),
                action: #selector(quit),
                keyEquivalent: ""
            )
            statusBarItem.menu = menu
            statusBarItem.button?.performClick(nil)
            statusBarItem.menu = nil
            return
        }
    }

    func leftClick(sender: AnyObject) {
        guard let button = self.statusBarItem.button else { return }
        if self.popover.isShown {
            self.popover.performClose(sender)
        } else {
            viewModel.updateContributions()
//            NSApp.activate(ignoringOtherApps: true) // 2回目以降閉じなくなる
            self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            self.popover.contentViewController?.view.window?.makeKey()
        }
    }

    @objc func quit() {
        NSApp.terminate(self)
    }
}
