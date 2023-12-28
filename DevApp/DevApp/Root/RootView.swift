//
//  ContentView.swift
//  DevApp
//
//  Created by Kojiro Ito on 2023/12/26.
//

import SwiftUI

struct RootView: View {
    @StateObject var viewModel = RootViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selectTabIndex) {
            RequirementSettingView()
                .tabItem {
                    Image(systemName: "house")
                    Text("ホーム")
                }.tag(0)
            SettingView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("設定")
                }.tag(1)
        }
    }
}

#Preview {
    RootView()
}

