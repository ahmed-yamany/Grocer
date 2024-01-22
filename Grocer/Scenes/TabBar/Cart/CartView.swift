//
//  CartView.swift
//  Grocer
//
//  Created by Ahmed Yamany on 07/01/2024.
//

import SwiftUI

struct CartView: View {
    let router: Router
    @StateObject private var viewModel = CartViewModel()
    var body: some View {
        ScrollView {
            VStack {
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .primaryDesignStyle()
        .toolbarTitle("Cart")
    }
}

#Preview {
    CartView(router: Router(navigationController: .init()))
}
