//
//  ServerCard.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/4/26.
//

import SwiftUI

struct ServerCard: View {

    let server: Server
    @State private var serverKey: String? = nil

    var body: some View {
        VStack {
            Text("Server Name")
            Text(server.baseURL.absoluteString)
            Text(serverKey ?? "*****")
            Button("Fetch Server Key") {
            }
        }
    }
}
