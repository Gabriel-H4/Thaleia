//
//  StatusCardView.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/29/25.
//

import SwiftUI

struct StatusCardView: View {
    
    var server: ConnectedServerClass
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                AnimatedIcon(isAnimating: server.status == .connecting)
                Text(server.name)
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
        }
        .font(.title2)
        .padding()
        .frame(maxWidth: 150, maxHeight: 80)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .foregroundStyle(.green)
                .opacity(0.75)
        }
        .padding()
    }
}

#Preview {
    
    let server = ConnectedServerClass(baseURL: "", apiKey: "", type: .plex)
    
    StatusCardView(server: server)
}
