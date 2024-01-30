//
//  AddCategoryView.swift
//  Grocer
//
//  Created by Ahmed Yamany on 28/01/2024.
//

import SwiftUI

struct AddCategoryView: View {
    @ObservedObject var viewModel: AddCategoryViewModel
    
    var body: some View {
        SheetView(title: "New Category", router: viewModel.router) {
            VStack(spacing: 48) {
                PrimaryTextField(title: "Name", text: $viewModel.category, fieldView: {
                    TextField("", text: $viewModel.category)
                })
                .keyboardType(.default)
                
                Button(L10n.save) {
                    viewModel.saveCategory()
                }
                .buttonStyle(.primaryButton(size: .mediam))
            }
        }
    }
}
