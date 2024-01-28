//
//  PrimaryButton.swift
//  Grocer
//
//  Created by Ahmed Yamany on 25/01/2024.
//

import SwiftUI

enum ButtonSize {
    case large, mediam, small
    
    var height: CGFloat {
        switch self {
            case .large: 60
            case .mediam: 48
            case .small: 38
        }
    }
}

/**
 Custom SwiftUI ButtonStyle for a primary button with a bold font and rounded corners.

 Usage:
 ```swift
 Button("Tap me") {
  // Button action
 }
  .buttonStyle(.primaryButton)
 ```
 */

struct PrimaryButton: ButtonStyle {
    let buttonSize: ButtonSize
    var icon: ImageResource?
    // Accesses the environment value that indicates whether the button is enabled or not
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 8) {
            if let icon {
                Image(icon)
                    .font(.custom(size: 40, weight: .light))
            }
            
            configuration
                .label
        }
        .font(Font.Large(weight: .bold))
        .foregroundStyle(Color.grWhite)
        .frame(maxWidth: .infinity)
        .frame(height: buttonSize.height)
        .background(getBackgroundColor(configuration: configuration))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    // Determines the background color of the button based on its configuration
    private func getBackgroundColor(configuration: Configuration) -> Color {
        if configuration.isPressed {
            return Color.grPrimary.opacity(0.4)
        } else if !isEnabled {
            return Color.grInputLabel
        }
        return Color.grOtherSecondaryToPrimary
    }
}

extension ButtonStyle where Self == PrimaryButton {
    static func primaryButton(size buttonSize: ButtonSize = .large, icon: ImageResource? = nil) -> Self {
        PrimaryButton(buttonSize: buttonSize, icon: icon)
    }
}
