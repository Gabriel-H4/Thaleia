//
//  MediaDetailView.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 8/2/26.
//

import AVFoundation
import SwiftUI

struct MediaDetailView: View {

    @Binding var media: Media?
    
    @State private var tracks: [Track] = []
    
    private var status: String {
        if let media = media {
            switch media.underlyingAsset.status(of: .tracks) {
                case .loading:
                    return String(localized: "MediaDetailView.status.loading")
                case .loaded:
                    return String(localized: "MediaDetailView.status.loaded")
                case .notYetLoaded:
                    return String(localized: "MediaDetailView.status.notYetLoaded")
                case .failed(_):
                    return String(localized: "MediaDetailView.status.failed")
            }
        }
        return String(localized: "MediaDetailView.status.nilMedia")
    }

    var body: some View {
        if let media = media {
            List {
                Text(
                    media.fileLocalizedName
                    ?? "MediaDetailView.media.noLocalizedName"
                )
                .font(.title)
                Text(status)
                    .bold()
                
                Section {
                    Label(media.id.uuidString, systemImage: "person.text.rectangle")
                    Label(media.fileURL.absoluteString, systemImage: "folder")
                    Label(
                        media.fileContentType
                            ?? "MediaDetailView.media.noContentType",
                        systemImage: "document"
                    )
                    Label(
                        ByteCountFormatter
                            .string(
                                fromByteCount: Int64(
                                    media.fileByteSize ?? 0
                                ),
                                countStyle: .file
                            ),
                        systemImage: "externaldrive"
                    )
                    HStack {
                        ForEach(media.filePermissions) { permission in
                            Label(permission.label, systemImage: permission.icon)
                                .symbolVariant(permission.iconVariant)
                            if media.filePermissions.firstIndex(of: permission) ?? 0 < media.filePermissions.count - 1 {
                                Divider()
                            }
                        }
                    }
                } header: {
                    Text("MediaDetailView.FileMetadata.title")
                }
                
                if !tracks.isEmpty {
                    Section {
                        Text("MediaDetailView.Tracks.noMetadataWarning")
                        ForEach(tracks) { track in
                            DisclosureGroup {
                                Label(
                                    "MediaDetailView.Track.isOptimized",
                                    systemImage: "network"
                                )
                                Label(
                                    "MediaDetailView.Track.dimensions",
                                    systemImage: "aspectratio"
                                )
                                Label(
                                    "MediaDetailView.Track.bitrate",
                                    systemImage: "circle.bottomrighthalf.pattern.checkered"
                                )
                            } label: {
                                Label(track.text, systemImage: track.icon)
                            }

                        }
                    } header: {
                        Text("MediaDetailView.Tracks.title")
                    }
                }
            }
            .onAppear {
                refreshTracks()
            }
            .onChange(of: media) {
                refreshTracks()
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        refreshTracks()
                    } label: {
                        Label("Refresh", systemImage: "arrow.clockwise.circle.fill")
                    }
                }
            }
        } else {
            Text("MediaDetailView.noSelection.text")
        }
    }
    
    private func refreshTracks() {
        if let media = self.media {
            self.tracks = []
            Task {
                let tracks = try (
                    await media.underlyingAsset.load(.tracks)
                )
                self.tracks = Track.create(from: tracks)
            }
        } else {
            print("Binding<Media> was nil for refreshTracks()")
        }
    }
}

#Preview {
    let media = Media(
        at: URL(string: "file:///Users/demo/file/100.mp4")!,
    )
    MediaDetailView(media: Binding.constant(media))
}
