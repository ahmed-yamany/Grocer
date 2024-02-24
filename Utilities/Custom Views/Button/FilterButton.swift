//
//  FilterButton.swift
//  Grocer
//
//  Created by Ahmed Yamany on 23/02/2024.
//

import SwiftUI

struct FilterButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(.filter)
                .resizable()
                .frame(width: 24, height: 24)
        }
        .buttonStyle(.primaryButton(size: .large))
        .frame(width: ButtonSize.large.height)
    }
}

#Preview {
    FilterButton(action: {})
}
