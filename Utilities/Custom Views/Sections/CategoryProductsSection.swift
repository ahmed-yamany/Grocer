//
//  CategoryProductsSection.swift
//  Grocer
//
//  Created by Ahmed Yamany on 02/02/2024.
//

import SwiftUI

struct OnDeleteProductActionKey: EnvironmentKey {
    static var defaultValue: (Product) -> Void = {_ in}
}

struct OnEditProductActionKey: EnvironmentKey {
    static var defaultValue: (Product) -> Void = {_ in}
}

struct OnAddProductToCartActionKey: EnvironmentKey {
    static var defaultValue: (Product) -> Void = {_ in}
}

extension EnvironmentValues {
    var onDeleteProduct: (Product) -> Void {
        get { self[OnDeleteProductActionKey.self] }
        set { self[OnDeleteProductActionKey.self] = newValue}
    }
    
    var onEditProduct: (Product) -> Void {
        get { self[OnEditProductActionKey.self] }
        set { self[OnEditProductActionKey.self] = newValue}
    }
    
    var onAddProductToCart: (Product) -> Void {
        get { self[OnAddProductToCartActionKey.self] }
        set { self[OnAddProductToCartActionKey.self] = newValue}
    }
}

extension View {
    @ViewBuilder
    func onDeleteProduct(_ action: @escaping (Product) -> Void) -> some View {
        environment(\.onDeleteProduct, action)
    }
    
    @ViewBuilder
    func onEditProduct(_ action: @escaping (Product) -> Void) -> some View {
        environment(\.onEditProduct, action)
    }
    
    @ViewBuilder
    func onAddProductToCart(_ action: @escaping (Product) -> Void) -> some View {
        environment(\.onAddProductToCart, action)
    }
}

struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.Large(weight: .bold))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, .Constants.contentPadding)
    }
}

struct CategoryProductsSection: View {
    let category: Category
    let products: [Product]
        
    @Environment(\.onDeleteProduct) var onDelete
    @Environment(\.onEditProduct) var onEdit
    @Environment(\.onAddProductToCart) var onAddToCart
    
    var body: some View {
        VStack {
            SectionHeader(title: category.name ?? "")
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: .Constants.cellSpacing) {
                    ForEach(products) { product in
                        ProductCell(product: product)
                            .contextMenu {
                                Button(L10n.addToCart) {
                                    onAddToCart(product)
                                }
                                
                                Button(L10n.edit) {
                                    onEdit(product)
                                }
                                
                                Button(L10n.delete, role: .destructive) {
                                    onDelete(product)
                                }
                            }
                    }
                }
                .padding(.horizontal, .Constants.contentPadding)
            }
            .frame(height: 170)
        }
    }
}
