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
        .toolbarTitle("Cart")
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
            
            DelayButton {
                Image(systemName: "magnifyingglass")
                    .font(.XLarge(weight: .semibold))
            } action: {
                viewModel.searchProduct()
            }
            .buttonStyle(.primaryButton(size: .large))
            .frame(width: ButtonSize.large.height)
        }
        .padding(.horizontal, .Constants.contentPadding)
    }
    
    private var contentView: some View {
        ScrollView {
            LazyVStack(spacing: .Constants.cellSpacing) {
                let products = viewModel.getProducts()
                ForEach(products) { product in
                    let count = viewModel.getCount(of: product)
                    if count > 0 {
                        ProductCartCell(product: product, count: count)
                    }
                }
                
                showCheckOutButton(whenEmpty: products.isEmpty)
            }
            .padding(.horizontal, .Constants.contentPadding)
            .padding(.bottom, .Constants.tabBarHeight)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
    
    @ViewBuilder
    private func showCheckOutButton(whenEmpty isEmpty: Bool) -> some View {
        if !isEmpty {
            Button("Check Out") {
                viewModel.checkOutButtonTapped()
            }
            .buttonStyle(.primaryButton())
        } else {
            // show image
        }
    }
}

#Preview {
    TabBarView()
}
