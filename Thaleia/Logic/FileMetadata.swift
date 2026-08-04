//
//  FileMetadata.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 7/30/26.
//

import Foundation

struct FileMetadata: Codable {
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
//            print(
//                "FileMetadata.init?(at:): Request to access \(path.absoluteString) failed"
//            )
//            return nil
//        }

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
            print(
                "FileMetadata.init?(at:): One of the resourceValues was nil. Skipping \(path.absoluteString)"
            )
            path.stopAccessingSecurityScopedResource()
            return nil
        }

        guard isDirectory else {
            self.localizedName = localizedName
            self.contentType = contentType.localizedDescription ?? contentType.identifier
            self.byteSize = fileSize
            self.isReadable = isReadable
            self.isWritable = isWritable
            return
        }
        
        path.stopAccessingSecurityScopedResource()
        return nil
    }
}
