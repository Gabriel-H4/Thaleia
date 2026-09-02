//
//  MediaCard.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 7/25/26.
//

import SwiftUI

struct MediaCard: View {

    @State var media: Media

    var body: some View {
        Text(media.fileLocalizedName ?? media.fileURL.absoluteString)
            .padding()
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
            )
            .background(
                .secondary,
                in: RoundedRectangle(cornerRadius: 16, style: .continuous)
            )
            .aspectRatio(9 / 16, contentMode: .fit)
            .padding()
    }
}

#Preview {
    let media = Media(
        at: URL(string: "file:///Users/demo/file/100.mp4")!,
    )
    MediaCard(media: media)
        .containerShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
}
