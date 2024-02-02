//
//  CategoryProductsSection.swift
//  Grocer
//
//  Created by Ahmed Yamany on 02/02/2024.
//

import SwiftUI

struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.Large(weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
    }
}

struct CategoryProductsSection: View {
    let category: Category
    let products: [Product]
    
    var body: some View {
        LazyVStack {
            SectionHeader(title: category.name ?? "")
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(products) { product in
                        ProductCell(product: product)
                    }
                }
                .padding(.horizontal, 24)
            }
            .frame(height: 170)
        }
    }
}
