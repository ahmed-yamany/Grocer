//
//  UnitField.swift
//  Grocer
//
//  Created by Ahmed Yamany on 28/01/2024.
//

import SwiftUI

struct UnitField: View {
    @Binding var unit: String
    let units: [String]
    @ObservedObject var viewModel: AddUnitViewModel
    
    var body: some View {
        PrimaryTextField(title: L10n.Field.unit, text: $unit) {
            HStack {
                PickerTextField(selectedItem: $unit, items: units)
                addUnitButton
            }
        }
    }
    
    private var addUnitButton: some View {
        Button {
            showAddUnit()
        } label: {
            Image(systemName: "plus.app")
                .font(.custom(size: 20, weight: .medium))
        }
    }
    
    private func showAddUnit() {
        let viewController = UIHostingController(rootView: AddUnitView(viewModel: viewModel))
        viewModel.router.presentOverFullScreen(viewController)
    }
}
