//
//  CartView.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: CartViewModel
    
    var body: some View {
        VStack(spacing: .Constants.cellSpacing) {
            searchView
            contentView
        }
        .primaryDesignStyle()
        .toolbarTitle(L10n.Cart.title)
        .animation(.easeInOut, value: viewModel.products)
        .onAppear {
            viewModel.onAppear()
        }
        .onIncrementProductCart { product in
            viewModel.increase(product)
        }
        .onDecrementProductCart { product in
            viewModel.decrease(product)
        }
    }
    
    private var searchView: some View {
        HStack(spacing: .Constants.cellSpacing) {
            BarCodeField(barcode: $viewModel.barcode, router: viewModel.router)

            SearchButton {
                viewModel.searchProduct()
            }
        }
        .padding(.horizontal, .Constants.contentPadding)
    }
    
    private var contentView: some View {
        VStack {
            let products = viewModel.getProducts()
            if products.isEmpty {
                EmptyView(text: L10n.Cart.empty)
            } else {
                productsView(products)
            }
        }
    }
    
    @ViewBuilder
    private func productsView(_ products: [Product]) -> some View {
        ScrollView {
            LazyVStack(spacing: .Constants.cellSpacing) {
                ForEach(products) { product in
                    let count = viewModel.getCount(of: product)
                    if count > 0 {
                        ProductCartCell(product: product, count: count)
                    }
                }
                
                checkOutButton
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .padding(.horizontal, .Constants.contentPadding)
        .padding(.bottom, .Constants.tabBarHeight)
    }
    
    @ViewBuilder
    private var checkOutButton: some View {
        Button(L10n.Cart.checkout) {
            viewModel.checkOutButtonTapped()
        }
        .buttonStyle(.primaryButton())
    }
}

#Preview {
    TabBarView()
}
