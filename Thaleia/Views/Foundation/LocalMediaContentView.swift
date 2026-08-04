//
//  LocalMediaContentView.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 7/22/26.
//

import SwiftUI

struct LocalMediaContentView: View {
    
    @Binding var selectedMediaItem: Media?
    
    @State private var isShowingFilePicker: Bool = false
    @State private var localPath: URL? = nil
    @State private var discoveredMedia: [Media] = []
    
    var body: some View {
        ScrollView {
            if localPath != nil {
                MediaCardGridView(media: $discoveredMedia, selectedMediaItem: $selectedMediaItem)
            }
            else {
                Button("Select a Directory") {
                    self.isShowingFilePicker = true
                }
                .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    if let pathURL = localPath {
                        pathURL.stopAccessingSecurityScopedResource()
                        selectedMediaItem = nil
                        discoveredMedia = []
                    }
                    self.isShowingFilePicker = true
                } label: {
                    Label("Open File Picker", systemImage: "folder.badge.plus")
                }
            }
            ToolbarItem(placement: .secondaryAction) {
                Button {
                    if let pathURL = localPath {
                        selectedMediaItem = nil
                        discoveredMedia = Media.create(from: pathURL)
                    }
                } label: {
                    Label("Re-Analyze", systemImage: "arrow.clockwise")
                }
                .disabled(localPath == nil)
            }
            ToolbarItem(placement: .secondaryAction) {
                Button {
                    print("Filter button clicked")
                } label: {
                    Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                }
                .disabled(localPath == nil)
            }
        }
        .fileImporter(
            isPresented: $isShowingFilePicker,
            allowedContentTypes: [.directory, .folder],
            allowsMultipleSelection: false) { result in
                switch result {
                    case .success(let files):
                        if let firstPath = files.first {
                            localPath = firstPath
                            discoveredMedia = Media.create(from: firstPath)
                        }
                    case .failure(let failure):
                        print("LocalMediaContentView.FileImporter Failure - \(failure.localizedDescription)")
                }
            } onCancellation: {
                print("LocalMediaContentView.FileImporter - User Cancelled.")
            }
    }
}
