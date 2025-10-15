//
//  ModifyView.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/31/25.
//

import SwiftUI

extension View {
    func modify<T: View>(@ViewBuilder _ modifier: (Self) -> T) -> some View {
        modifier(self)
    }
}
