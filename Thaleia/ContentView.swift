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
                .tag(tab)
            }
            .listStyle(.sidebar)
        } content: {
            Text("\(viewModel.selected_sidebar_tab) content")
        } detail: {
            Text("\(viewModel.selected_sidebar_tab) details")
        }
        .navigationTitle("Thaleia")
    }
}

#Preview {
    ContentView()
}
