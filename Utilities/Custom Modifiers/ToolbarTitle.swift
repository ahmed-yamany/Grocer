//
//  ToolbarTitle.swift
//  Grocer
//
//  Created by Ahmed Yamany on 08/01/2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    func toolbarTitle(_ title: String) -> some View {
        toolbar {
            ToolbarItem(placement: .principal) {
                Text(title)
                    .font(.h4)
                    .foregroundColor(.grTextSecondary)
            }
        }
    }
}
