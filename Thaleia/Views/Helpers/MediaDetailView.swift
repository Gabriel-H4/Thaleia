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
    @State private var tracks: [AVAssetTrack] = []
    private var status: String {
        if let media = media {
            switch media.underlyingAsset.status(of: .tracks) {
                case .loading:
                    return "Loading"
                case .loaded:
                    return "Loaded"
                case .notYetLoaded:
                    return "Not yet loaded"
                case .failed(_):
                    return "Failed :("
            }
        }
        return "Bad media..."
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

//                Section {
//                    Text("MediaDetailView.AVMetadata.noMetadataWarning")
//                    Button {
//                        Task {
//                            await AVMetadata.loadMetadata(at: media.fileURL)
//                        }
//                    } label: {
//                        Label(
//                            "MediaDetailView.AVMetadata.load",
//                            systemImage: "info.circle"
//                        )
//                    }
//                    Label(
//                        "MediaDetailView.AVMetadata.isOptimized",
//                        systemImage: "network"
//                    )
//                    Label(
//                        "MediaDetailView.AVMetadata.dimensions",
//                        systemImage: "aspectratio"
//                    )
//                    Label(
//                        "MediaDetailView.AVMetadata.bitrate",
//                        systemImage: "circle.bottomrighthalf.pattern.checkered"
//                    )
//                    Label(
//                        media.avMetadata?.releaseDate.description ?? "Date",
//                        systemImage: "calendar"
//                    )
//                    Label("Title: nil", systemImage: "person")
//                } header: {
//                    Text("MediaDetailView.AVMetadata.title")
//                }
                
                Section {
                    ForEach(tracks, id: \.self) { track in
                        Label(track.mediaType.rawValue, systemImage: "film")
                    }
                } header: {
                    Text("MediaDetailView.Tracks.title")
                }
            }
            .onAppear {
                refreshTracks()
            }
            .onChange(of: media) {
                refreshTracks()
            }
        } else {
            Text("MediaDetailView.noSelection.text")
        }
    }
    
    private func refreshTracks() {
        if let media = media {
            tracks = []
            Task {
                tracks = try (
                    await media.underlyingAsset.load(.tracks)
                )
                print("Updated Tracks, now: \(tracks.debugDescription)")
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
