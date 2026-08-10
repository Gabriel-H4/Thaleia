//
//  MainContentView.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 7/15/26.
//

import SwiftUI

struct MainContentView: View {

    @State private var selectedSidebarTabItem: SidebarDestination = .local
    @State private var selectedMediaItem: Media? = nil

    var body: some View {
        NavigationSplitView {
            List(
                SidebarDestination.allCases,
                selection: $selectedSidebarTabItem,
            ) { sidebarTabItem in
                NavigationLink(sidebarTabItem.title, value: sidebarTabItem)
            }
        } content: {
            switch selectedSidebarTabItem {
            case .local:
                LocalMediaContentView(selectedMediaItem: $selectedMediaItem)
            case .seerr:
                Text("MainContentView.seerr.text")
            }
        } detail: {
            MediaDetailView(media: $selectedMediaItem)
        }
        .onChange(of: selectedSidebarTabItem) {
            selectedMediaItem = nil
        }
    }
}

#Preview {
    MainContentView()
}
