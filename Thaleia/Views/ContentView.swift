//
//  ContentView.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/29/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationSplitView(
            preferredCompactColumn: $viewModel.preferred_tab
        ) {
            List(
                SidebarTab.allCases,
                selection: $viewModel.selected_sidebar_tab
            ) { tab in
                NavigationLink(value: tab) {
                    Label(tab.title, systemImage: tab.icon)
                }
            }
            .listStyle(.sidebar)
        } content: {
            VStack {
                Text("ContentView")
                VStack {
                    StatusCard_HomeView()
                    Text(viewModel.selected_sidebar_tab.title)
                }
            }
        } detail: {
            VStack {
                Text("DetailView")
                Text(viewModel.selected_sidebar_tab.title)
            }
        }
        .navigationTitle("AppName")
    }
}

#Preview {
    ContentView()
}
