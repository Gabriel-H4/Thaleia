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
                    Label(media.id.uuidString, systemImage: "person.title.rectangle")
                    Label(media.fileURL.formatted(.url), systemImage: "folder")
                        .contextMenu {
                            Button {
                                NSWorkspace.shared.activateFileViewerSelecting([media.fileURL])
                            } label: {
                                Label("Open in Finder", systemImage: "finder")
                            }
                        }
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
                            Label(permission.title, systemImage: permission.icon)
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
                                    Toggle("MediaDetailView.Track.isEnabled", isOn: Binding.constant(track.isEnabled))
                                        .toggleStyle(.checkbox)
                                        //.disabled(true)
                                    Label(
                                        "MediaDetailView.Track.isOptimized",
                                        systemImage: "network"
                                    )

                                if track.genericKind == .audio {
                                    Section {
                                        Text("Audio Info")
                                        Label(
                                            "MediaDetailView.Track.bitrate",
                                            systemImage: "circle.bottomrighthalf.pattern.checkered"
                                        )
                                    }
                                }
                                
                                if track.genericKind == .video {
                                    Section {
                                        if let dimensions = track.dimensions {
                                            Label(dimensions.debugDescription,
                                                systemImage: "aspectratio"
                                            )
                                        } else {
                                            Label(
                                                "MediaDetailView.Track.dimensions",
                                                systemImage: "aspectratio"
                                            )
                                        }
                                        Label(
                                            "MediaDetailView.Track.bitrate",
                                            systemImage: "circle.bottomrighthalf.pattern.checkered"
                                        )
                                    }
                                }
                                
                                if track.genericKind == .text {
                                    Section {
                                        Text("Text Info")
                                    }
                                }
                                
                                if track.genericKind == .other {
                                    Section {
                                        Text("Other Info")
                                    }
                                }
                            } label: {
                                Label(track.title, systemImage: track.icon)
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
                self.tracks = await Track.create(from: tracks)
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
