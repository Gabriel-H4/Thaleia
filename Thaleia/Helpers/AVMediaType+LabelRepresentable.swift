//
//  AVMediaType+LabelRepresentable.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 9/10/26.
//

import AVFoundation
import Foundation

extension AVMediaType: LabelRepresentable {
    var title: LocalizedStringResource {
        switch self {
        case .audio:
            "AVMediaType.audio.title"
        case .auxiliaryPicture:
            "AVMediaType.auxiliaryPicture.title"
        case .closedCaption:
            "AVMediaType.closedCaption.title"
        case .subtitle:
            "AVMediaType.subtitle.title"
        case .depthData:
            "AVMediaType.depth.title"
        case .haptic:
            "AVMediaType.haptic.title"
        case .metadata:
            "AVMediaType.metadata.title"
        case .muxed:
            "AVMediaType.muxed.title"
        case .text:
            "AVMediaType.text.title"
        case .timecode:
            "AVMediaType.timecode.title"
        case .video:
            "AVMediaType.video.title"
        default:
            "AVMediaType.unknown.\(self.rawValue).title"
        }
    }

    var icon: SFSymbol {
        switch self {
        case .audio:
            "waveform"
        case .auxiliaryPicture:
            "photo"
        case .closedCaption:
            "captions.bubble"
        case .subtitle:
            "captions.bubble"
        case .depthData:
            "arrow.up.arrow.down"
        case .haptic:
            "water.waves"
        case .metadata:
            "info.bubble"
        case .muxed:
            "arrow.trianglehead.merge"
        case .text:
            "quote.bubble"
        case .timecode:
            "clock"
        case .video:
            "film"
        default:
            "questionmark"
        }
    }
}
