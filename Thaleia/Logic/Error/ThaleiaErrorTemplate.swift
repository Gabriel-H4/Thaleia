//
//  ThaleiaErrorTemplate.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/15/26.
//

struct ThaleiaErrorTemplate {
    let errorDescription: String
    let recoverySuggestion: String
    let failureReason: String
    let isFatal: Bool
    
    static let base = ThaleiaErrorTemplate(
        errorDescription: String(localized: "ThaleiaErrorTemplate.base.errorDescription"),
        recoverySuggestion: String(localized: "ThaleiaErrorTemplate.base.recoverySuggestion"),
        failureReason: String(localized: "ThaleiaErrorTemplate.base.failureReason"),
        isFatal: true
    )
}
