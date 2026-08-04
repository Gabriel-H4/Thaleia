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
                    Text(media.fileMetadata?.localizedName ?? "Unnamed")
                        .font(.title)
                    Label(media.id.uuidString, systemImage: "tag")
                    Label(media.url.absoluteString, systemImage: "link")
                    Label(media.fileMetadata?.contentType ?? "No Type", systemImage: "document")
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
                        Label("Readable", systemImage: "eye")
                            .symbolVariant(
                                media.fileMetadata?.isReadable ?? false ? .none : .slash
                            )
                        Divider()
                        Label("Writable", systemImage: "pencil")
                            .symbolVariant(
                                media.fileMetadata?.isWritable ?? false ? .none : .slash
                            )
                    }
                } header: {
                    Text("File Metadata")
                }
                
                Section {
                    Text("Empty")
                } header: {
                    
                    Text("AV Metadata")
                }
            }
        } else {
            Text("Select an item")
        }
    }
}
