//
//  MediaCardGridView.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 7/30/26.
//

import SwiftUI

struct MediaCardGridView: View {

    @Binding var media: [Media]
    @Binding var selectedMediaItem: Media?

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(media) { mediaItem in
                MediaCard(media: mediaItem)
                    .onTapGesture {
                        selectedMediaItem = mediaItem
                    }
            }
        }
        .padding()
    }
}
