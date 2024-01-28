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
    let router: Router
    
    var body: some View {
        PrimaryTextField(title: L10n.Field.unit, text: $unit) {
            HStack {
                PickerTextField(selectedItem: $unit, items: units)
                
                Button {
                    
                } label: {
                    Image(systemName: "plus.app")
                        .font(.custom(size: 20, weight: .semibold))
                }
            }
        }
    }
}
