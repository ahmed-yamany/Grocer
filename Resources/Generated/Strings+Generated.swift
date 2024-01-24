// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Localizable.strings
  ///   Grocer
  /// 
  ///   Created by Ahmed Yamany on 06/01/2024.
  internal static let cancel = L10n.tr("Localizable", "cancel", fallback: "Cancel")
  internal enum AddProduct {
    /// Add Product
    internal static let title = L10n.tr("Localizable", "addProduct.title", fallback: "Add Product")
    internal enum AddImage {
      /// Add Product Image
      internal static let title = L10n.tr("Localizable", "addProduct.addImage.title", fallback: "Add Product Image")
      internal enum Picker {
        /// Open Camera
        internal static let camera = L10n.tr("Localizable", "addProduct.addImage.picker.camera", fallback: "Open Camera")
        /// Choose from image Library
        internal static let image = L10n.tr("Localizable", "addProduct.addImage.picker.image", fallback: "Choose from image Library")
      }
    }
  }
  internal enum Field {
    /// Bar Code
    internal static let barCode = L10n.tr("Localizable", "field.barCode", fallback: "Bar Code")
    /// Category
    internal static let category = L10n.tr("Localizable", "field.category", fallback: "Category")
    /// Name
    internal static let name = L10n.tr("Localizable", "field.name", fallback: "Name")
    /// Price
    internal static let price = L10n.tr("Localizable", "field.price", fallback: "Price")
    /// Quantity
    internal static let quantity = L10n.tr("Localizable", "field.quantity", fallback: "Quantity")
    /// Unit
    internal static let unit = L10n.tr("Localizable", "field.unit", fallback: "Unit")
  }
  internal enum TabBar {
    /// Cart
    internal static let cart = L10n.tr("Localizable", "tabBar.cart", fallback: "Cart")
    /// Home
    internal static let home = L10n.tr("Localizable", "tabBar.home", fallback: "Home")
    /// Store
    internal static let store = L10n.tr("Localizable", "tabBar.store", fallback: "Store")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
