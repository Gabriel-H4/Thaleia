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
            HStack {
                Spacer()
                ServerCard(server: dataModel.plexServer)
                Spacer()
                ServerCard(server: dataModel.seerrServer)
                Spacer()
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    HomeView()
}
