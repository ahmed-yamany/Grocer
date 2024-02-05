//
//  PrimaryTextField.swift
//  Grocer
//
//  Created by Ahmed Yamany on 08/01/2024.
//

import SwiftUI

// Environment key for storing and retrieving the text field label
struct TextfieldLabelKey: EnvironmentKey {
    static var defaultValue: String = ""
}

extension EnvironmentValues {
    // Extension to easily access and set the text field label in SwiftUI views
    var textfieldLabel: String {
        get { self[TextfieldLabelKey.self] }
        set { self[TextfieldLabelKey.self] = newValue }
    }
}

extension View {
    @ViewBuilder
    func textfieldLabelText(_ text: String) -> some View {
        environment(\.textfieldLabel, text)
    }
}

// Custom SwiftUI text field with additional features
struct PrimaryTextField<FieldView: View>: View {
    @Environment(\.textfieldState) private var state
    @Environment(\.textfieldLabel) private var label: String
    
    let title: String
    @Binding var text: String
    @ViewBuilder var fieldView: () -> FieldView
    
    var body: some View {
        VStack {
            fieldView()
                .background { prompt }
                .padding(.top, !text.isEmpty ? 12 : 0)
                .padding([.horizontal], 18)
                .frame(height: 56)
                .background(Color.grInputField)
                .clipShape(RoundedRectangle(cornerRadius: .Constants.cornerRadius))
                .background {
                    RoundedRectangle(cornerRadius: .Constants.cornerRadius)
                        .stroke(lineWidth: 2)
                        .fill(state.fillColor)
                }
                .font(.medium(weight: .regular))
                .animation(.interactiveSpring(duration: 0.6), value: text.isEmpty)
            
            if !label.isEmpty {
                Text(label)
                    .font(.small(weight: .medium))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .shadow(radius: 0.5)
        .animation(.smooth, value: label)
    }
    
    var prompt: some View {
        Text(title)
            .foregroundColor(Color.grInputLabel)
            .frame(maxWidth: .infinity, alignment: .leading)
            .offset(y: !text.isEmpty ? -18 : 0)
    }
}

#Preview {
    TabBarView()
}
