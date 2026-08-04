//
//  MediaDetailView.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 8/2/26.
//

import SwiftUI

struct MediaDetailView: View {

    @Binding var media: Media?

    var body: some View {
        if let media = media {
            List {
                Section {
                    Text(
                        media.fileMetadata?.localizedName
                            ?? "MediaDetailView.media.noLocalizedName"
                    )
                    .font(.title)
                    Label(media.id.uuidString, systemImage: "tag")
                    Label(media.url.absoluteString, systemImage: "link")
                    Label(
                        media.fileMetadata?.contentType
                            ?? "MediaDetailView.media.noContentType",
                        systemImage: "document"
                    )
                    Label(
                        ByteCountFormatter
                            .string(
                                fromByteCount: Int64(
                                    media.fileMetadata?.byteSize ?? 0
                                ),
                                countStyle: .file
                            ),
                        systemImage: "externaldrive"
                    )
                    HStack {
                        if let isReadable = media.fileMetadata?.isReadable {
                            Label(
                                isReadable
                                    ? "MediaDetailView.media.isReadable"
                                    : "MediaDetailView.media.isNotReadable",
                                systemImage: "eye"
                            )
                            .symbolVariant(isReadable ? .none : .slash)
                        }
                        Divider()
                        if let isWritable = media.fileMetadata?.isWritable {
                            Label(
                                isWritable
                                ? "MediaDetailView.media.isWritable"
                                : "MediaDetailView.media.isNotWritable",
                                systemImage: "pencil"
                            )
                            .symbolVariant(isWritable ? .none : .slash)
                        }
                    }
                } header: {
                    Text("MediaDetailView.FileMetadata.title")
                }

                Section {
                    Text("MediaDetailView.AVMetadata.noMetadataWarning")
                    Label("MediaDetailView.AVMetadata.isOptimized", systemImage: "network")
                    Label("MediaDetailView.AVMetadata.dimensions", systemImage: "aspectratio")
                    Label("MediaDetailView.AVMetadata.bitrate", systemImage: "circle.bottomrighthalf.pattern.checkered")
                } header: {
                    Text("MediaDetailView.AVMetadata.title")
                }
            }
        } else {
            Text("MediaDetailView.noSelection.text")
        }
    }
}
