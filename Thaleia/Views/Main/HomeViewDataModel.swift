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
        var plexServer = Server(
            kind: .plex,
            credential: Credential.empty
        )
        var seerrServer = Server(
            kind: .seerr,
            credential: Credential.empty
        )
    }
}

