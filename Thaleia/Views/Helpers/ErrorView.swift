//
//  ErrorView.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 2/1/26.
//

import SwiftUI

struct ErrorView: View {

    @Environment(DataModel.self) private var model: DataModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        let error = model.error ?? ThaleiaError(using: ThaleiaErrorTemplate.base)
        ContentUnavailableView {
            Label(
                error.errorDescription ?? "",
                systemImage: error.isFatal
                    ? "stethoscope" : "exclamationmark.triangle"
            )
        } description: {
            VStack {
                Text(error.failureReason ?? "")
                    .padding(4)
                Text(error.recoverySuggestion ?? "")
                    .padding(.bottom)
                if error.isFatal {
                    Text("ErrorView.Label.Fatal.Text")
                        .font(.callout)
                        .fontWeight(.bold)
                    HStack {
                        Button {
                            
                        } label: {
                            Label("Share Log", systemImage: "paperplane")
                        }
                        Button {
                            exit(EXIT_FAILURE)
                        } label: {
                            Label("Close App", systemImage: "xmark.circle")
                        }
                    }
                }
            }
        }
        .interactiveDismissDisabled(error.isFatal)
        .toolbar {
            if(!error.isFatal) {
                ToolbarItem(placement: .navigation) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Dismiss", systemImage: "xmark")
                    }
                }
            }
        }
    }
}

#Preview {
    ErrorView()
        .environment(DataModel())
}
