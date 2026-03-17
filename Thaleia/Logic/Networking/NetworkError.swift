//
//  NetworkError.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/13/26.
//

extension Network {
    enum Error {
        case invalidResponse
        case responseParsingFailure
        case other

        var template: ThaleiaErrorTemplate {
            switch self {
            case .invalidResponse:
                return ThaleiaErrorTemplate(
                    errorDescription: String(
                        localized:
                            "Network.Error.invalidResponse.errorDescription"
                    ),
                    recoverySuggestion: String(
                        localized:
                            "Network.Error.invalidResponse.recoverySuggestion"
                    ),
                    failureReason: String(
                        localized: "Network.Error.invalidResponse.failureReason"
                    ),
                    isFatal: false
                )
            case .responseParsingFailure:
                return ThaleiaErrorTemplate(
                    errorDescription: String(
                        localized:
                            "Network.Error.responseParsingFailure.errorDescription"
                    ),
                    recoverySuggestion: String(
                        localized:
                            "Network.Error.responseParsingFailure.recoverySuggestion"
                    ),
                    failureReason: String(
                        localized:
                            "Network.Error.responseParsingFailure.failureReason"
                    ),
                    isFatal: false
                )
            case .other:
                return ThaleiaErrorTemplate(
                    errorDescription: String(
                        localized: "Network.Error.other.errorDescription"
                    ),
                    recoverySuggestion: String(
                        localized: "Network.Error.other.recoverySuggestion"
                    ),
                    failureReason: String(
                        localized: "Network.Error.other.failureReason"
                    ),
                    isFatal: false
                )
            }
        }
    }
}
