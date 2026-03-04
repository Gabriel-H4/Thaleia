//
//  HomeView.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/4/26.
//

import SwiftUI

struct HomeView: View {

    @State private var dataModel = DataModel()

    var body: some View {
        VStack {
            ServerCard(server: dataModel.plexServer)
            ServerCard(server: dataModel.overseerrServer)
        }
    }
}
