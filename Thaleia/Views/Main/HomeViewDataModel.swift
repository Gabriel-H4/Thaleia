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
            credential: Keychain.Credential.empty
        )
        var seerrServer = Server(
            kind: .seerr,
            credential: Keychain.Credential(url: ThaleiaURL(string: "http://127.0.0.1:8081/status-overseerr.json"))
        )
    }
}
