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
    
    init(error: ThaleiaError?) {
        self.error = error ?? ThaleiaError(using: ThaleiaErrorTemplate.base)
    }

    var body: some View {
        ContentUnavailableView {
            Label(
                error.errorDescription ?? "",
                systemImage: error.isFatal
                    ? "stethoscope" : "exclamationmark.triangle"
            )
        } description: {
            Text(error.failureReason ?? "")
            Text(error.recoverySuggestion ?? "")
            if error.isFatal {
                Text("ErrorView.Label.Fatal.Text")
                    .font(.callout)
                    .fontWeight(.bold)
            }
        }
        .interactiveDismissDisabled(error.isFatal)
    }
}

#Preview {
    ErrorView(error: nil)
}
