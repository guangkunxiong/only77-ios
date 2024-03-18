//
//  TodayButtonStyle.swift
//  Only77
//
//  Created by yukun xie on 2024/2/15.
//

import SwiftUI

struct TodayButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94:1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

