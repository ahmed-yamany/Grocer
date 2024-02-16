// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Add To Cart
  internal static let addToCart = L10n.tr("Localizable", "addToCart", fallback: "Add To Cart")
  /// Localizable.strings
  ///   Grocer
  /// 
  ///   Created by Ahmed Yamany on 06/01/2024.
  internal static let cancel = L10n.tr("Localizable", "cancel", fallback: "Cancel")
  /// Delete
  internal static let delete = L10n.tr("Localizable", "delete", fallback: "Delete")
  /// Edit
  internal static let edit = L10n.tr("Localizable", "edit", fallback: "Edit")
  /// Save
  internal static let save = L10n.tr("Localizable", "save", fallback: "Save")
  internal enum AddCategory {
    /// New Category
    internal static let title = L10n.tr("Localizable", "addCategory.title", fallback: "New Category")
  }
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
    internal enum Error {
      internal enum Barcode {
        /// Product BarCode: must be greater than 8 characters
        internal static let count = L10n.tr("Localizable", "addProduct.error.barcode.count", fallback: "Product BarCode: must be greater than 8 characters")
        /// Product BarCode: mustn't be empty
        internal static let empty = L10n.tr("Localizable", "addProduct.error.barcode.empty", fallback: "Product BarCode: mustn't be empty")
      }
      internal enum Name {
        /// Name: must be greater than 3 characters
        internal static let count = L10n.tr("Localizable", "addProduct.error.name.count", fallback: "Name: must be greater than 3 characters")
        /// Name: mustn't be empty
        internal static let empty = L10n.tr("Localizable", "addProduct.error.name.empty", fallback: "Name: mustn't be empty")
      }
      internal enum Price {
        /// Product Price: Must be a Decimal Number
        internal static let cast = L10n.tr("Localizable", "addProduct.error.price.cast", fallback: "Product Price: Must be a Decimal Number")
      }
      internal enum Quantity {
        /// Product Quantity: must be an Integer
        internal static let cast = L10n.tr("Localizable", "addProduct.error.quantity.cast", fallback: "Product Quantity: must be an Integer")
      }
    }
  }
  internal enum Alert {
    /// Edited Successfully
    internal static let edited = L10n.tr("Localizable", "alert.edited", fallback: "Edited Successfully")
    /// Error Occurred
    internal static let error = L10n.tr("Localizable", "alert.error", fallback: "Error Occurred")
    /// Saved Successfully
    internal static let saved = L10n.tr("Localizable", "alert.saved", fallback: "Saved Successfully")
    /// Action Required
    internal static let warning = L10n.tr("Localizable", "alert.warning", fallback: "Action Required")
    internal enum Category {
      /// The new category saved successfully
      internal static let saved = L10n.tr("Localizable", "alert.category.saved", fallback: "The new category saved successfully")
    }
    internal enum Product {
      /// deleted Successfully
      internal static let deleted = L10n.tr("Localizable", "alert.product.deleted", fallback: "deleted Successfully")
      /// The new product Edited successfully
      internal static let edit = L10n.tr("Localizable", "alert.product.edit", fallback: "The new product Edited successfully")
      /// The new product saved successfully
      internal static let saved = L10n.tr("Localizable", "alert.product.saved", fallback: "The new product saved successfully")
    }
  }
  internal enum Cart {
    /// Check Out
    internal static let checkout = L10n.tr("Localizable", "cart.checkout", fallback: "Check Out")
    /// Your Cart is Empty, start selling Products by searching for a product using its barcode
    internal static let empty = L10n.tr("Localizable", "cart.empty", fallback: "Your Cart is Empty, start selling Products by searching for a product using its barcode")
    /// Cart
    internal static let title = L10n.tr("Localizable", "cart.title", fallback: "Cart")
    internal enum Error {
      /// barcode is less than 8
      internal static let barcode = L10n.tr("Localizable", "cart.error.barcode", fallback: "barcode is less than 8")
      /// Couldn't find a product with this barcode
      internal static let product = L10n.tr("Localizable", "cart.error.product", fallback: "Couldn't find a product with this barcode")
    }
  }
  internal enum Coredata {
    internal enum Error {
      /// Please select category for the product
      internal static let categoryEmpty = L10n.tr("Localizable", "coredata.error.categoryEmpty", fallback: "Please select category for the product")
      /// Failed To Create
      internal static let createObject = L10n.tr("Localizable", "coredata.error.createObject", fallback: "Failed To Create")
      /// already exits
      internal static let exists = L10n.tr("Localizable", "coredata.error.exists", fallback: "already exits")
      /// Failed to get all objects of type
      internal static let getAll = L10n.tr("Localizable", "coredata.error.getAll", fallback: "Failed to get all objects of type")
      /// Upload at lest one image for the product
      internal static let imagesEmpty = L10n.tr("Localizable", "coredata.error.imagesEmpty", fallback: "Upload at lest one image for the product")
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
  internal enum Store {
    /// Your Store is Empty Start Adding Products by clicking the plus button
    internal static let empty = L10n.tr("Localizable", "store.empty", fallback: "Your Store is Empty Start Adding Products by clicking the plus button")
    /// Search Product Name
    internal static let search = L10n.tr("Localizable", "store.search", fallback: "Search Product Name")
    /// Grocer Store
    internal static let title = L10n.tr("Localizable", "store.title", fallback: "Grocer Store")
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
