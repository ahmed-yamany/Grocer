//
//  CategoryField.swift
//  Grocer
//
//  Created by Ahmed Yamany on 28/01/2024.
//

import SwiftUI

struct CategoryField: View {
    @Binding var category: String
    let categories: [String]
    @ObservedObject var viewModel: AddCategoryViewModel

    var body: some View {
        PrimaryTextField(title: L10n.Field.category, text: $category) {
            HStack {
                PickerTextField(selectedItem: $category, items: categories)
                addCategoryButton
            }
        }
    }
    
    private var addCategoryButton: some View {
        Button {
           showAddCategory()
        } label: {
            Image(systemName: "plus.app")
                .font(.custom(size: 20, weight: .medium))
        }

    }
    
    private func showAddCategory() {
        let viewController = UIHostingController(rootView: AddCategoryView(viewModel: viewModel))
        viewModel.router.presentOverFullScreen(viewController)
    }
}
