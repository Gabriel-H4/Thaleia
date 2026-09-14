//
//  TrackType.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 9/10/26.
//

import AVFoundation
import Foundation

struct TrackType: LabelRepresentable {
    
    let underlyingValue: AVMediaType
    let title: LocalizedStringResource
    let icon: SFSymbol
    let isSupported: Bool
    
    init(from mediaType: AVMediaType) {
        self.underlyingValue = mediaType
        switch mediaType {
            case .audio:
                self.title = "TrackType.audio.title"
                self.icon = "waveform"
                self.isSupported = true
            case .auxiliaryPicture:
                self.title = "TrackType.auxiliaryPicture.title"
                self.icon = "photo"
                self.isSupported = true
            case .closedCaption:
                self.title = "TrackType.closedCaption.title"
                self.icon = "captions.bubble"
                self.isSupported = true
            case .subtitle:
                self.title = "TrackType.subtitle.title"
                self.icon = "captions.bubble"
                self.isSupported = true
            case .depthData:
                self.title = "TrackType.depth.title"
                self.icon = "arrow.up.arrow.down"
                self.isSupported = false
            case .haptic:
                self.title = "TrackType.haptic.title"
                self.icon = "water.waves"
                self.isSupported = false
            case .metadata:
                self.title = "TrackType.metadata.title"
                self.icon = "info.bubble"
                self.isSupported = true
            case .muxed:
                self.title = "TrackType.muxed.title"
                self.icon = "arrow.trianglehead.merge"
                self.isSupported = false
            case .text:
                self.title = "TrackType.text.title"
                self.icon = "quote.bubble"
                self.isSupported = true
            case .timecode:
                self.title = "TrackType.timecode.title"
                self.icon = "clock"
                self.isSupported = false
            case .video:
                self.title = "TrackType.video.title"
                self.icon = "film"
                self.isSupported = true
            default:
                self.title = "TrackType.unknown.\(mediaType.rawValue).title"
                self.icon = "questionmark"
                self.isSupported = false
        }
    }
}
