//
//  HomeViewDataModel.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/10/26.
//

import SwiftUI

extension HomeView {
    @Observable
    final class DataModel {
        var plexServer = PlexServer(
            credential: Credential(
                url: URL(string: "https://example.com/plex")!
            )
        )
        var overseerrServer = OverseerrServer(
            credential: Credential(
                url: URL(string: "https://example.com/overseerr")!
            )
        )
    }
}
