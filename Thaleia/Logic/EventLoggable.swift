//
//  EventLoggable.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 8/4/26.
//

import OSLog

protocol EventLoggable {
    static var logger: Logger { get }
}

extension Logger {
    init(category: String) {
        self.init(
            subsystem: Bundle.main.bundleIdentifier
                ?? "com.gabrielhassebrock.Thaleia",
            category: category
        )
    }
}
