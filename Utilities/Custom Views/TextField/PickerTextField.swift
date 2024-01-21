//
//  PickerTextField.swift
//  Grocer
//
//  Created by Ahmed Yamany on 08/01/2024.
//

import SwiftUI

/// A SwiftUI representation of a text field with a custom picker as its input view.
struct PickerTextField: UIViewRepresentable {
    /// Binding for the selected item in the picker.
    @Binding var selectedItem: String
    /// Array of items to be displayed in the picker.
    let items: [String]

    func makeUIView(context: Context) -> UITextField {
        let textField = ProtectedTextField()
        textField.inputView = CustomPickerView(items: items, didSelect: { item in
            selectedItem = item
        })
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = selectedItem
    }
}

// Custom TextField with disabling paste action
private class ProtectedTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

/// A custom UIPickerView with a published selected item and specified items and didSelect closure.
private class CustomPickerView: UIPickerView {
    /// Published property for the selected item in the picker.
    @Published var selectedItem: String = ""
    /// Array of items to be displayed in the picker.
    let items: [String]
    /// Closure to be called when an item is selected in the picker.
    let didSelect: (String) -> Void

    /// Initializes the CustomPickerView with the specified items and didSelect closure.
    required public init(items: [String], didSelect: @escaping (String) -> Void) {
        self.items = items
        self.didSelect = didSelect
        super.init(frame: .zero)
        configure()
    }

    /// Required initializer for NSCoder. Not implemented.
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Configures the delegate and data source for the picker.
    private func configure() {
        delegate = self
        dataSource = self
    }
}

/// Extension to conform CustomPickerView to UIPickerViewDataSource.
extension CustomPickerView: UIPickerViewDataSource {
    /// Returns the number of components in the picker (always 1).
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }

    /// Returns the number of rows in the specified component (equal to the number of items).
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        items.count
    }
}

/// Extension to conform CustomPickerView to UIPickerViewDelegate.
extension CustomPickerView: UIPickerViewDelegate {
    /// Returns the title for the specified row and component.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        items[row]
    }

    /// Called when a row is selected in the picker, updating the selected item.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        didSelect(items[row])
    }
}
