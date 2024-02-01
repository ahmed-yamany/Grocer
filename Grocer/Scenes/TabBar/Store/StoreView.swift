//
//  StoreView.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI

struct StoreView: View {
    @ObservedObject private var viewModel: StoreViewModel
    
    init(router: Router) {
        self.viewModel = StoreViewModel(router: router)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.products) { product in
                    Text(product.name ?? "no name")
                }
            }
        }
        .primaryDesignStyle()
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
            viewModel.showAddProducts()
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
