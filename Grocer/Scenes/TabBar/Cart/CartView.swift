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
            BarCodeField(barcode: $viewModel.barcode, router: viewModel.router)
                .padding(.horizontal, .Constants.contentPadding)
            
            ScrollView {
                LazyVStack(spacing: .Constants.cellSpacing) {
                    ForEach(viewModel.getProducts()) { product in
                        let count = viewModel.getCount(of: product)
                        if count > 0 {
                            ProductCartCell(product: product, count: count)
                        }
                    }
                }
                .padding(.horizontal, .Constants.contentPadding)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
        }
        .primaryDesignStyle()
        .toolbarTitle("Cart")
        .onAppear {
            viewModel.onAppear()
        }
    }
}

#Preview {
    TabBarView()
}
