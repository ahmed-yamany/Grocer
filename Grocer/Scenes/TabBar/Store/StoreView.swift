//
//  StoreView.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI

struct StoreView: View {
    @ObservedObject var viewModel: StoreViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack {
                let categories: [Category] = Array(viewModel.groupedProductsByCategory.keys)
                ForEach(categories, id: \.self) { category in
                    let products: [Product] = viewModel.groupedProductsByCategory[category] ?? []
                    CategoryProductsSection(category: category, products: products)
                }
            }
        }
        .primaryDesignStyle()
        .toolbarTitle(L10n.Store.title)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                trailingToolBarItem
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .onDeleteProduct { product in
            viewModel.delete(product)
        }
        .onEditProduct { product in
            viewModel.edit(product)
        }
        .onAddProductToCart { product in
            viewModel.addToCart(product)
        }
    }
    
    private var trailingToolBarItem: some View {
        Button {
            viewModel.addProduct()
        } label: {
            Image(.iconAddProduct)
                .resizable()
                .frame(width: 25, height: 25)
        }
    }
}

#Preview {
    TabBarView()
}
