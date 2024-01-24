//
//  XButton.swift
//  Grocer
//
//  Created by Ahmed Yamany on 24/01/2024.
//

import SwiftUI

struct XButton: View {
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Image(.iconX)
                .resizable()
                .frame(width: 20, height: 20)
                .padding(2)
                .background(.ultraThinMaterial)
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(8)
    }
}
