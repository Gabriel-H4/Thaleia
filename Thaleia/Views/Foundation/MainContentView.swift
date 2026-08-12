//
//  MainContentView.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 7/15/26.
//

import SwiftUI

struct MainContentView: View {
    
    @State private var selectedSidebarItem: SidebarItem =
    SidebarCategory.main.items.first ?? SidebarItem.localAnalyze
    @State private var selectedMediaItem: Media? = nil

    var body: some View {
        NavigationSplitView {
            List(
                selection: $selectedSidebarItem,
            ) {
                ForEach(SidebarCategory.allCases) { category in
                    Section(category.title) {
                        ForEach(category.items) { item in
                            NavigationLink(value: item) {
                                Label(item.title, systemImage: item.icon)
                            }
                        }
                    }
                }
            }
        } content: {
            switch selectedSidebarItem {
                case .localAnalyze:
                    LocalMediaContentView(
                        selectedMediaItem: $selectedMediaItem
                    )
                case .seerrIssues:
                    Text("Seerr Issues")
                case .seeerrRequests:
                    Text("Seerr Requests")
            }
        } detail: {
            MediaDetailView(media: $selectedMediaItem)
        }
        .onChange(of: selectedSidebarItem) {
            selectedMediaItem = nil
        }
    }
}

#Preview {
    MainContentView()
}
