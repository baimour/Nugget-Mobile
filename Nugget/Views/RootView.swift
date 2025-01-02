//
//  ContentView.swift
//  Nugget
//
//  Created by lemin on 9/9/24.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("主页", systemImage: "house")
                }
            ToolsView()
                .tabItem {
                    Label("工具", systemImage: "wrench.and.screwdriver.fill")
                }
        }
    }
}
