//
//  AVMetadata.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 7/30/26.
//

import AVFoundation
import OSLog

@available(macOS, obsoleted: 0.0.1, message: "")
struct AVMetadata: EventLoggable {

    static let logger: Logger = Logger(category: "AVMetadata")

    let id: UUID = UUID()
    let releaseDate: Date = Date.distantFuture
    
    init() {}

    init?(at path: URL) async {
        do {
            AVMetadata.logger.trace(
                "\(#function, privacy: .public) - Loading Metadata for: \(path.absoluteString, privacy: .sensitive)"
            )
            let asset = AVURLAsset(url: path)
            for format in try await asset.load(.availableMetadataFormats) {
                let metadata = try await asset.loadMetadata(for: format)
                AVMetadata.logger.info(
                    "\(#function, privacy: .public) Successfully loaded \(format.rawValue) metadata"
                )
                AVMetadata.logger.info("Metadata: \(metadata)")
                let items = AVMetadataItem.metadataItems(
                    from: metadata,
                    filteredByIdentifier: .iTunesMetadataReleaseDate
                    )
                AVMetadata.logger.info("\(#function, privacy: .public) - Released - \(items)")
            }
        } catch {
            AVMetadata.logger.error("Error: \(error.localizedDescription)")
        }
    }

    static func loadMetadata(at path: URL) async {
        do {
            AVMetadata.logger.trace(
                "\(#function, privacy: .public) - Loading Metadata for: \(path.absoluteString, privacy: .sensitive)"
            )
            let asset = AVURLAsset(url: path)
            for format in try await asset.load(.availableMetadataFormats) {
                switch format {
                    case .hlsMetadata:
                        AVMetadata.logger.debug("Parsing Metadata with Format: hlsMetadata")
                    case .iTunesMetadata:
                        AVMetadata.logger.debug("Parsing Metadata with Format: iTunesMetadata")
                    case .id3Metadata:
                        AVMetadata.logger.debug("Parsing Metadata with Format: id3Metadata")
                    case .isoUserData:
                        AVMetadata.logger.debug("Parsing Metadata with Format: isoUserData")
                    case .quickTimeMetadata:
                        AVMetadata.logger.debug("Parsing Metadata with Format: quickTimeMetadata")
                    case .quickTimeUserData:
                        AVMetadata.logger.debug("Parsing Metadata with Format: quickTimeUserData")
                    default:
                        AVMetadata.logger.debug("Default / Unknown Metadata format encountered")
                }
                let metadata = try await asset.loadMetadata(for: format)
                AVMetadata.logger.info(
                    "Successfully loaded metadata for format: \(format.rawValue)"
                )
                AVMetadata.logger.info("Metadata (\(format.rawValue)):\n\(metadata)")
                let item = AVMetadataItem.metadataItems(
                    from: metadata,
                    filteredByIdentifier: .quickTimeMetadataEncodedBy
                )
                AVMetadata.logger.info("Encoded by: \(item)")
            }
        } catch {
            AVMetadata.logger.error("Error: \(error.localizedDescription)")
        }
    }
}
