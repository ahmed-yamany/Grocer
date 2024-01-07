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
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .primaryDesignStyle()
    }
}

#Preview {
    CartView(router: ModalRouter())
}
