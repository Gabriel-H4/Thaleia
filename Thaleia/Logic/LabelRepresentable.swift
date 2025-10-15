//
//  LabelRepresentable.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/29/25.
//

import SwiftUI

public protocol LabelRepresentable {
    var title: LocalizedStringKey { get }
    var icon: String { get }
}
