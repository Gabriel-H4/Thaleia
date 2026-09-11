//
//  LabelRepresentable.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 9/11/26.
//

import Foundation

protocol LabelRepresentable {
    typealias SFSymbol = String
    var title: LocalizedStringResource { get }
    var icon: SFSymbol { get }
}
