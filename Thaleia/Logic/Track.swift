//
//  Track.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 9/4/26.
//

import AVFoundation
import Foundation

struct Track: Hashable, Identifiable {
    
    let id: UUID = UUID()
    let underlyingAsset: AVAssetTrack
    let icon: String
    let text: String
    
    init(from track: AVAssetTrack) {
        self.underlyingAsset = track
        self.icon = switch track.mediaType {
            case .audio:
                "waveform"
            case .auxiliaryPicture:
                "photo"
            case .closedCaption, .subtitle:
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
        self.text = switch track.mediaType {
            case .audio:
                "Audio"
            case .auxiliaryPicture:
                "Auxiliary Picture"
            case .closedCaption:
                "Closed Caption"
            case .subtitle:
                "Subtitle"
            case .depthData:
                "Depth"
            case .haptic:
                "Haptic"
            case .metadata:
                "Metadata"
            case .muxed:
                "Muxed"
            case .text:
                "Text"
            case .timecode:
                "Timecode"
            case .video:
                "Video"
            default:
                "Unsupported Type"
        }
    }
    
    static func create(from tracks: [AVAssetTrack]) -> [Track] {
        var result: [Track] = []
        for track in tracks {
            result.append(Track(from: track))
        }
        return result
    }
}
