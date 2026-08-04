//
//  Media.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 7/15/26.
//

import Foundation

struct Media: Identifiable {
    let id: UUID
    let url: URL
    
    var fileMetadata: FileMetadata? {
        FileMetadata(at: url)
    }
    
    var avMetadata: AVMetadata? {
        AVMetadata()
    }
    
    init(at path: URL) {
        self.id = UUID()
        self.url = path
    }
}

extension Media {
    static func create(from path: URL) -> [Media] {
        
        var mediaItems: [Media] = []
        
        guard path.startAccessingSecurityScopedResource() else {
            print("Media.create(from:): Could not access path -- returning \(mediaItems.count) items")
            return mediaItems
        }
        
        let resourceKeys: Set<URLResourceKey> = [
            .isDirectoryKey,
        ]
        
        guard
            let directoryEnumerator = FileManager().enumerator(
                at: path,
                includingPropertiesForKeys: Array(resourceKeys),
                options: [.skipsHiddenFiles, .skipsPackageDescendants]
            )
        else {
            print("Media.create(from:): Unable to create enumerator -- returning \(mediaItems.count) items")
            path.stopAccessingSecurityScopedResource()
            return mediaItems
        }
        
        for case let fileURL as URL in directoryEnumerator {
            guard let resourceValues = try? fileURL.resourceValues(forKeys: resourceKeys),
                  let isDirectory = resourceValues.isDirectory
            else {
                print("Media.create(from:): Unable to retrieve resource values and determine if \(fileURL.path) is a directory. Skipping.")
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
