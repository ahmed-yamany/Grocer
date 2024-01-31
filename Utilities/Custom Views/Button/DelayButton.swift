//
//  DelayButton.swift
//  Grocer
//
//  Created by Ahmed Yamany on 31/01/2024.
//

import SwiftUI

struct DelayButton<Content: View>: View {
    var time: TimeInterval
    let label: () -> Content
    let action: () -> Void
    
    init(for time: TimeInterval = 1, _ label: @escaping () -> Content, action: @escaping () -> Void) {
        self.time = time
        self.label = label
        self.action = action
    }
    @State private var enableButton = true

    var body: some View {
        Button {
            enableButton = false
            action()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.enableButton = true
            }
        } label: {
            label()
        }
        .disabled(!enableButton)
    }
}
