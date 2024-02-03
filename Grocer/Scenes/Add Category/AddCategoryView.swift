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
        SheetView(title: L10n.AddCategory.title, router: viewModel.router) {
            VStack(spacing: 48) {
                PrimaryTextField(title: L10n.Field.name, text: $viewModel.category, fieldView: {
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
