//
//  FileMetadata.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 7/30/26.
//

import Foundation
import OSLog

struct FileMetadata: Codable, EventLoggable {

    static let logger: Logger = Logger(category: "FileMetadata")

    private(set) var localizedName: String
    private(set) var contentType: String
    private(set) var byteSize: Int
    private(set) var isReadable: Bool
    private(set) var isWritable: Bool

    init(
        localizedName: String = "",
        contentType: String = "",
        byteSize: Int = 0,
        isReadable: Bool = false,
        isWritable: Bool = false
    ) {
        self.localizedName = localizedName
        self.contentType = contentType
        self.byteSize = byteSize
        self.isReadable = isReadable
        self.isWritable = isWritable
    }

    init?(at path: URL) {

        //        guard path.startAccessingSecurityScopedResource() else {
        //            FileMetadata.logger.error("Request to access \(path.absoluteString) failed")
        //            return nil
        //        }

        FileMetadata.logger.trace(
            "\(#function, privacy: .public): Creating new FileMetadata for \(path.path)"
        )

        let resourceKeys: Set<URLResourceKey> = [
            .contentTypeKey,
            .fileSizeKey,
            .isDirectoryKey,
            .isReadableKey,
            .isWritableKey,
            .localizedNameKey,
        ]

        guard
            let resourceValues = try? path.resourceValues(
                forKeys: resourceKeys
            ),
            let contentType = resourceValues.contentType,
            let fileSize = resourceValues.fileSize,
            let isDirectory = resourceValues.isDirectory,
            let isReadable = resourceValues.isReadable,
            let isWritable = resourceValues.isWritable,
            let localizedName = resourceValues.localizedName
        else {
            FileMetadata.logger.error(
                "One or more resourceValues were nil. Returning nil."
            )
            path.stopAccessingSecurityScopedResource()
            return nil
        }

        guard isDirectory else {
            self.localizedName = localizedName
            self.contentType =
                contentType.localizedDescription ?? contentType.identifier
            self.byteSize = fileSize
            self.isReadable = isReadable
            self.isWritable = isWritable
            return
        }

        FileMetadata.logger.trace("Exiting FileMetadata init()")

        path.stopAccessingSecurityScopedResource()
        return nil
    }
}
