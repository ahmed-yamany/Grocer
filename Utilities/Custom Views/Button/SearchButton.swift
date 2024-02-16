//
//  SearchButton.swift
//  Grocer
//
//  Created by Ahmed Yamany on 16/02/2024.
//

import SwiftUI

struct SearchButton: View {
    let action: () -> Void
    
    var body: some View {
        DelayButton {
            Image(systemName: "magnifyingglass")
                .font(.XLarge(weight: .semibold))
        } action: {
            action()
        }
        .buttonStyle(.primaryButton(size: .large))
        .frame(width: ButtonSize.large.height)
    }
}

#Preview {
    SearchButton(action: {})
}
