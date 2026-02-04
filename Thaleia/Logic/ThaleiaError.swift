//
//  ThaleiaError.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 11/23/25.
//

import Foundation

struct ThaleiaError: LocalizedError, Equatable {
    let file: String = #file
    let function: String = #function
    let line: Int = #line
    let errorDescription: String?
    let recoverySuggestion: String?
    let failureReason: String?
    let isFatal: Bool
}

