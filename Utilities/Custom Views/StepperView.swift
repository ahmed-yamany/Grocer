//
//  StepperView.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/02/2024.
//

import SwiftUI

struct StepperView: View {
    let onIncrement: () -> Void
    let onDecrement: () -> Void
    
    var body: some View {
        HStack {
            button(systemName: "minus") {
                onDecrement()
            }
            
            Spacer()
            Divider()
            Spacer()
            button(systemName: "plus") {
                onIncrement()
            }
        }
        .padding(.Constants.cellPadding)
        .frame(width: 80, height: 32)
        .background(.grBackground)
        .clipShape(RoundedRectangle(cornerRadius: .Constants.cornerRadius))
    }
    
    @ViewBuilder
    private func button(systemName: String, _ action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: systemName)
                .font(.Large(weight: .medium))
        }
    }
}
