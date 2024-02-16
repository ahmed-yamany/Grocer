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
        VStack {
            searchView
            
            let categories: [Category] = viewModel.categories
            if categories.isEmpty {
                EmptyView(text: L10n.Store.empty)
            } else {
                categoriesView(categories)
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
    
    @ViewBuilder
    private func categoriesView(_ categories: [Category] ) -> some View {
        ScrollView {
            LazyVStack {
                ForEach(categories, id: \.self) { category in
                    let products: [Product] = viewModel.groupedProductsByCategory[category] ?? []
                    CategoryProductsSection(category: category, products: products)
                }
            }
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
    
    private var searchView: some View {
        HStack(spacing: .Constants.cellSpacing) {
            PrimaryTextField(title: L10n.Store.search, text: $viewModel.searchText) {
                TextField("", text: $viewModel.searchText)
            }

            SearchButton {
                viewModel.search()
            }
        }
        .padding(.horizontal, .Constants.contentPadding)
    }
}

#Preview {
    TabBarView()
}
