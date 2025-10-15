//
//  AnimatedIcon.swift
//  Thaleia
//
//  Created by Gabriel Hassebrock on 3/31/25.
//

import SwiftUI

struct AnimatedIcon: View {
    
    let systemName: String = "questionmark.diamond"
    var isAnimating: Bool
    
    var body: some View {
        Image(systemName: systemName)
            .modify {
                if #available(macOS 15.0, *) {
                    $0.symbolEffect(
                        .variableColor
                            .cumulative
                            .dimInactiveLayers
                            .reversing,
                        options: .repeat(.continuous),
                        isActive: isAnimating
                    )
                }
                else {
                    $0.symbolEffect(
                        .variableColor
                            .cumulative
                            .dimInactiveLayers
                            .reversing,
                        options: .repeat(nil),
                        isActive: isAnimating
                    )
                }
            }
    }
}

#Preview {
    AnimatedIcon(
        isAnimating: true
    )
}
