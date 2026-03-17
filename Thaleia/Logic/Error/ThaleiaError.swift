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
    private let _errorDescription: String
    private let _recoverySuggestion: String
    private let _failureReason: String
    let isFatal: Bool
    
    var errorDescription: String? {
        return self._errorDescription
    }
    
    var recoverySuggestion: String? {
        return self._recoverySuggestion
    }
    
    var failureReason: String? {
        return self._failureReason
    }

    init(
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        errorDescription: String,
        recoverySuggestion: String,
        failureReason: String,
        isFatal: Bool
    ) {
        self.file = file
        self.function = function
        self.line = line
        self._errorDescription = errorDescription
        self._recoverySuggestion = recoverySuggestion
        self._failureReason = failureReason
        self.isFatal = isFatal
    }

    init(
        using template: ThaleiaErrorTemplate,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        self.file = file
        self.function = function
        self.line = line
        self._errorDescription = template.errorDescription
        self._recoverySuggestion = template.recoverySuggestion
        self._failureReason = template.failureReason
        self.isFatal = template.isFatal
        print(
            "Created a new ThaleiaError! (file: \(file), function: \(function), line: \(line), errorDescription: \(String(describing: template.errorDescription)), recoverySuggestion: \(String(describing: template.recoverySuggestion)), failureReason: \(String(describing: template.failureReason)), isFatal: \(template.isFatal))"
        )
    }
}

extension ThaleiaError: CustomStringConvertible {
    var description: String {
        return
            "ThaleiaError(file: \(file), function: \(function), line: \(line), errorDescription: \(_errorDescription), recoverySuggestion: \(_recoverySuggestion), failureReason: \(_failureReason), isFatal: \(isFatal))"
    }
}
