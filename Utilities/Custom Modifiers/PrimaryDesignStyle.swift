//
//  PrimaryDesignStyle.swift
//  Grocer
//
//  Created by Ahmed Yamany on 08/01/2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    func primaryDesignStyle() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.grBackground)
            .foregroundStyle(Color.grTextPrimary)
            .foregroundColor(Color.grTextPrimary)
            .font(Font.medium(weight: .regular))
            .tint(Color.grTextSecondary)
            .accentColor(Color.grTextSecondary)
    }
}
