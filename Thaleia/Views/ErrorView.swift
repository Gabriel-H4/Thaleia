//
//  ErrorView.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/1/26.
//

import SwiftUI

struct ErrorView: View {
    
    @Environment(\.dismiss) private var dismiss
    let error: ThaleiaError
    
    var body: some View {
        ContentUnavailableView {
            Label(error.errorDescription ?? "", systemImage: error.isFatal ? "stethoscope" : "exclamationmark.triangle")
        } description: {
            Text(error.failureReason ?? "")
            Text(error.recoverySuggestion ?? "")
            if(error.isFatal) {
                Text("ErrorView.Label.Fatal.Text")
                    .font(.callout)
                    .fontWeight(.bold)
            }
        }
        .interactiveDismissDisabled(error.isFatal)
    }
}

#Preview {
    let error = ThaleiaError(
        errorDescription: String(localized: "Unable to Fetch Information"),
        recoverySuggestion: String(localized: "Try again in a few minutes, and send session data to email@example.com."),
        failureReason: String(localized: "The server returned a 418 status code."),
        isFatal: false
    )
    ErrorView(error: error)
}
