//
//  AddUnitView.swift
//  Grocer
//
//  Created by Ahmed Yamany on 28/01/2024.
//

import SwiftUI

struct AddUnitView: View {
    @ObservedObject var viewModel: AddUnitViewModel
  
    var body: some View {
        SheetView(title: "New Unit", router: viewModel.router) {
            VStack(spacing: 48) {
                PrimaryTextField(title: "Name", text: $viewModel.unit, fieldView: {
                    TextField("", text: $viewModel.unit)
                })
                .keyboardType(.default)
                
                Button(L10n.save) {
                    viewModel.saveUnit()
                }
                .buttonStyle(.primaryButton(size: .mediam))
            }
        }
    }
}
