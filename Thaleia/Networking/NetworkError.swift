//
//  NetworkError.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/13/26.
//

extension Network {
    enum Error {
        case invalidResponse
        
        var reusableError: ReusableThaleiaError {
            switch self {
                case .invalidResponse:
                    return ReusableThaleiaError(
                        errorDescription: String(localized: "Network.Error.invalidResponse.errorDescription"),
                        recoverySuggestion: String(localized: "Network.Error.invalidResponse.recoverySuggestion"),
                        failureReason: String(localized: "Network.Error.invalidResponse.failureReason"),
                        isFatal: false
                    )
            }
        }
    }
}
