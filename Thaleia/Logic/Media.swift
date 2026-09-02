    //
    //  Media.swift
    //  Thaleia
    //
    //  Created by Gabriel Hassebrock on 7/15/26.
    //

import AVFoundation
import Foundation
import OSLog

struct Media: Equatable, EventLoggable, Identifiable {

    static let logger: Logger = Logger(category: "Media")

    let id: UUID
    let fileURL: URL

    let fileLocalizedName: String?
    let fileContentType: String?
    let fileByteSize: Int?
    let filePermissions: [FilePermission]
    
    let underlyingAsset: AVAsset

    init(at path: URL) {
        self.id = UUID()
        self.fileURL = path
        self.underlyingAsset = AVURLAsset(url: path)
        
        var fileLocalizedName: String? = nil
        var fileContentType: String? = nil
        var fileByteSize: Int? = nil
        var filePermissions: [FilePermission] = FilePermission.create()

        let resourceKeys: Set<URLResourceKey> = [
            .contentTypeKey,
            .fileSizeKey,
            .isDirectoryKey,
            .isExecutableKey,
            .isReadableKey,
            .isWritableKey,
            .localizedNameKey,
        ]

        if let resourceValues = try? path.resourceValues(forKeys: resourceKeys),
           let isDirectory = resourceValues.isDirectory
        {
            if !isDirectory {
                fileLocalizedName = resourceValues.localizedName
                fileContentType =
                resourceValues.contentType?.localizedDescription
                ?? resourceValues.contentType?.identifier
                fileByteSize = resourceValues.fileSize
                filePermissions.removeAll()
                filePermissions = FilePermission
                    .create(
                        readable: resourceValues.isReadable ?? false,
                        writable: resourceValues.isWritable ?? false,
                        executable: resourceValues.isExecutable ?? false
                    )
            }
        }
        
        self.fileLocalizedName = fileLocalizedName
        self.fileContentType = fileContentType
        self.fileByteSize = fileByteSize
        self.filePermissions = filePermissions
        
        path.stopAccessingSecurityScopedResource()
    }
}

extension Media {
    static func create(from path: URL) -> [Media] {

        var mediaItems: [Media] = []

        guard path.startAccessingSecurityScopedResource() else {
            Media.logger
                .warning(
                    "Could not access media at path \(path.absoluteString) - returning \(mediaItems.count, privacy: .public) items"
                )
            return mediaItems
        }

        let resourceKeys: Set<URLResourceKey> = [
            .isDirectoryKey
        ]

        guard
            let directoryEnumerator = FileManager().enumerator(
                at: path,
                includingPropertiesForKeys: Array(resourceKeys),
                options: [.skipsHiddenFiles, .skipsPackageDescendants]
            )
        else {
            Media.logger.error(
                "\(#function) - Unable to create enumerator, returning \(mediaItems.count) items"
            )
            path.stopAccessingSecurityScopedResource()
            return mediaItems
        }

        for case let fileURL as URL in directoryEnumerator {
            guard
                let resourceValues = try? fileURL.resourceValues(
                    forKeys: resourceKeys
                ),
                let isDirectory = resourceValues.isDirectory
            else {
                Media.logger.warning(
                    "\(#function) - Unable to retrieve resource values and determine if \(fileURL.path) is a directory. Skipping file."
                )
                continue
            }

            if isDirectory {
                continue
            } else {
                mediaItems.append(Media(at: fileURL))
            }
        }

        return mediaItems

    }
}
