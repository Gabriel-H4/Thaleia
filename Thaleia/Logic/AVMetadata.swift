//
//  AVMetadata.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 7/30/26.
//

import AVFoundation
import OSLog

struct AVMetadata: EventLoggable {

    static let logger: Logger = Logger(category: "AVMetadata")

    let id: UUID = UUID()

    static func loadMetadata(at path: URL) async {
        do {
            AVMetadata.logger.trace(
                "\(#function, privacy: .public) - Loading Metadata for: \(path.absoluteString, privacy: .sensitive)"
            )
            let asset = AVURLAsset(url: path)
            for format in try await asset.load(.availableMetadataFormats) {
                let metadata = try await asset.loadMetadata(for: format)
                AVMetadata.logger.info(
                    "Successfully loaded \(format.rawValue) metadata"
                )
                AVMetadata.logger.info("Metadata: \(metadata.description)")
            }
        } catch {
            AVMetadata.logger.error("Error: \(error.localizedDescription)")
        }
    }
}
