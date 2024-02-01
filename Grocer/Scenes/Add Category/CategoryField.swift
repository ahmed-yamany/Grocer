//
//  CategoryField.swift
//  Grocer
//
//  Created by Ahmed Yamany on 28/01/2024.
//

import SwiftUI

struct CategoryField: View {
    @Binding var category: String
    @ObservedObject var viewModel: AddCategoryViewModel

    var body: some View {
        PrimaryTextField(title: L10n.Field.category, text: $category) {
            HStack {
                PickerTextField(selectedItem: $category, items: viewModel.categories)
                addCategoryButton
            }
        }
    }
    
    private var addCategoryButton: some View {
        Button {
            viewModel.showAddCategory()
        } label: {
            Image(systemName: "plus.app")
                .font(.custom(size: 20, weight: .medium))
        }
    }
}
