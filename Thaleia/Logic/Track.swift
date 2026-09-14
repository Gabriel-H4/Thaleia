//
//  Track.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 9/4/26.
//

import AVFoundation
import Foundation

struct Track: Identifiable {
    
    let id: UUID = UUID()
    let underlyingAsset: AVAssetTrack
    let trackType: TrackType
    let isEnabled: Bool
    let dimensions: CGSize?
    //let bitrate: Int?
    
    init(from track: AVAssetTrack) async {
        self.underlyingAsset = track
        self.trackType = TrackType(from: track.mediaType)
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
