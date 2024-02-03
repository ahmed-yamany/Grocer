//
//  CartView.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel: CartViewModel
    @State var searchText = ""
    
    var body: some View {
        VStack {
            BarCodeField(barcode: $searchText, router: viewModel.router)
                .padding(.horizontal, 24)
            
            ScrollView {
                VStack {
                    Text("Searching for")
                    
                }
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
        }
        .primaryDesignStyle()
        .toolbarTitle("Cart")
    }
}

#Preview {
    TabBarView()
}
