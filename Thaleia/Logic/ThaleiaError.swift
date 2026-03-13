//
//  ThaleiaError.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 11/23/25.
//

import Foundation

struct ThaleiaError: Error, LocalizedError, Equatable {
    let file: String
    let function: String
    let line: Int
    let errorDescription: String?
    let recoverySuggestion: String?
    let failureReason: String?
    let isFatal: Bool

    init(
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        errorDescription: String?,
        recoverySuggestion: String?,
        failureReason: String?,
        isFatal: Bool
    ) {
        self.file = file
        self.function = function
        self.line = line
        self.errorDescription = errorDescription
        self.recoverySuggestion = recoverySuggestion
        self.failureReason = failureReason
        self.isFatal = isFatal
    }

    init(
        using template: ReusableThaleiaError,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        self.file = file
        self.function = function
        self.line = line
        self.errorDescription = template.errorDescription
        self.recoverySuggestion = template.recoverySuggestion
        self.failureReason = template.failureReason
        self.isFatal = template.isFatal
    }
}

extension ThaleiaError: CustomStringConvertible {
    var description: String {
        let errorDescription = self.errorDescription ?? "N/A"
        let recoverySuggestion = self.recoverySuggestion ?? "N/A"
        let failureReason = self.failureReason ?? "N/A"
        
        return "ThaleiaError(file: \(file), function: \(function), line: \(line), errorDescription: \(errorDescription), recoverySuggestion: \(recoverySuggestion), failureReason: \(failureReason), isFatal: \(isFatal))"
    }
}

struct ReusableThaleiaError {
    let errorDescription: String?
    let recoverySuggestion: String?
    let failureReason: String?
    let isFatal: Bool
}
