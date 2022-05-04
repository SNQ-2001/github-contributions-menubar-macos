//
//  ContentView.swift
//  GitHubContributionsMenuBar
//
//  Created by 宮本大新 on 2022/05/05.
//

import SwiftUI

struct ContentView: View {
    @State var username: String = "SNQ-2001"
    @State var setting: Bool = false
    var body: some View {
        Contributions(viewModel: .init(), username: $username)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
