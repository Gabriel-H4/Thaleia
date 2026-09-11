//
//  Track.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 9/4/26.
//

import AVFoundation
import Foundation

struct Track: Identifiable, LabelRepresentable {
    
    let id: UUID = UUID()
    let underlyingAsset: AVAssetTrack
    let genericKind: TrackGenericKind
    let title: LocalizedStringResource
    let icon: SFSymbol
    let isEnabled: Bool
    let dimensions: CGSize?
    //let bitrate: Int?
    
    init(from track: AVAssetTrack) async {
        self.underlyingAsset = track
        switch track.mediaType {
            case .audio:
                self.genericKind = .audio
                self.icon = "waveform"
                self.title = "Audio"
            case .auxiliaryPicture:
                self.genericKind = .other
                self.icon = "photo"
                self.title = "Auxiliary Picture"
            case .closedCaption:
                self.genericKind = .text
                self.icon = "captions.bubble"
                self.title = "Closed Caption"
            case .subtitle:
                self.genericKind = .text
                self.icon = "captions.bubble"
                self.title = "Subtitle"
            case .depthData:
                self.genericKind = .other
                self.icon = "arrow.up.arrow.down"
                self.title = "Depth"
            case .haptic:
                self.genericKind = .other
                self.icon = "water.waves"
                self.title = "Haptic"
            case .metadata:
                self.genericKind = .other
                self.icon = "info.bubble"
                self.title = "Metadata"
            case .muxed:
                self.genericKind = .other
                self.icon = "arrow.trianglehead.merge"
                self.title = "Muxed"
            case .text:
                self.genericKind = .text
                self.icon = "quote.bubble"
                self.title = "Text"
            case .timecode:
                self.genericKind = .other
                self.icon = "clock"
                self.title = "Timecode"
            case .video:
                self.genericKind = .video
                self.icon = "film"
                self.title = "Video"
            default:
                self.genericKind = .other
                self.icon = "questionmark"
                self.title = "Unsupported Type: \(track.mediaType.rawValue)"
        }
        
        self.isEnabled = (try? await track.load(.isEnabled)) ?? false
        
        self.dimensions = (try? await track.load(.naturalSize))
        
    }
    
    static func create(from tracks: [AVAssetTrack]) async -> [Track] {
        var result: [Track] = []
        for track in tracks {
            result.append(await Track(from: track))
        }
        return result
    }
}
