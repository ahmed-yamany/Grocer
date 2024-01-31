//
//  UIFont+Style.swift
//  Grocer
//
//  Created by Ahmed Yamany on 30/01/2024.
//

import UIKit

// swiftlint: disable all
// An extension to provide custom font styles using the Cairo and Poppins font families.
public extension UIFont {

    static var h1: UIFont {
        return .custom(size: 48, weight: .bold)
    }

    static var h2: UIFont {
        return .custom(size: 40, weight: .bold)
    }

    static var h3: UIFont {
        return .custom(size: 32, weight: .bold)
    }
    
    static var h4: UIFont {
        return .custom(size: 24, weight: .bold)
    }
    
    static var h5: UIFont {
        return .custom(size: 20, weight: .bold)
    }
    
    static var h6: UIFont {
        return .custom(size: 18, weight: .bold)
    }
    
    static func XLarge(weight: UIFont.Weight) -> UIFont {
        .custom(size: 18, weight: weight)
    }
    
    static func Large(weight: UIFont.Weight) -> UIFont {
        .custom(size: 16, weight: weight)
    }
    
    static func medium(weight: UIFont.Weight) -> UIFont {
        .custom(size: 14, weight: weight)
    }
    
    static func small(weight: UIFont.Weight) -> UIFont {
        .custom(size: 12, weight: weight)
    }
    
    static func XSmall(weight: UIFont.Weight) -> UIFont {
        .custom(size: 10, weight: weight)
    }
    
    /// Returns a custom font with the specified size and weight.
    ///
    /// - Parameters:
    ///   - size: The size of the font in points.
    ///   - weight: The weight of the font.
    /// - Returns: A custom font with the given size and weight.
    static func custom(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let fontName = self.fontName(forWeight: weight)
        // Attempt to create a font with the specified name and size
        guard let font = UIFont(name: fontName, size: size) else {
            assertionFailure("Unable to get a font with name: \(fontName)")
            return UIFont.systemFont(ofSize: size, weight: weight)
        }
        return font
    }
    
    /// Returns the appropriate font name based on the specified weight.
    ///
    /// - Parameter weight: The weight of the font.
    /// - Returns: The font name associated with the specified weight.
    static private func fontName(forWeight weight: UIFont.Weight) -> String {
        switch weight {
        case .regular: return "SFProDisplay-Regular"
        case .medium: return "SFProDisplay-Medium"
        case .semibold: return "SFProDisplay-Semibold"
        case .bold: return "SFProDisplay-Bold"
        default: return "SFProDisplay-Regular"
        }
    }
}
// swiftlint: enable all
