//
//  ProductCartCell.swift
//  Grocer
//
//  Created by Ahmed Yamany on 05/02/2024.
//

import SwiftUI

struct ProductCartCell: View {
    let product: Product
    let count: Int
    
    @Environment(\.onIncrementProductCart) private var onIncrementProductCart
    @Environment(\.onDecrementProductCart) private var onDecrementProductCart
    
    var body: some View {
        HStack(alignment: .top, spacing: .Constants.cellSpacing) {
            Image(uiImage: product.firstImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 82, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: .Constants.cornerRadius))
            
            VStack(alignment: .leading, spacing: .Constants.cellPadding) {
                ProductCellContent(product: product)
                Spacer()
                stepperView
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.Constants.cellPadding)
        .background(.grInputField)
        .clipShape(RoundedRectangle(cornerRadius: .Constants.cornerRadius))
    }
    
    var stepperView: some View {
        HStack {
            Text("Count: \(count)")
            
            Spacer()
            
            StepperView(onIncrement: {
                onIncrementProductCart(product)
            }, onDecrement: {
                onDecrementProductCart(product)
            })
        }
    }
}

struct OnIncrementProductCartKey: EnvironmentKey {
    static var defaultValue: (Product) -> Void = {_ in}
}

struct OnDecrementProductCartKey: EnvironmentKey {
    static var defaultValue: (Product) -> Void = {_ in}
}

extension EnvironmentValues {
    var onIncrementProductCart: (Product) -> Void {
        get { self[OnIncrementProductCartKey.self] }
        set { self[OnIncrementProductCartKey.self] = newValue }
    }
    
    var onDecrementProductCart: (Product) -> Void {
        get { self[OnDecrementProductCartKey.self] }
        set { self[OnDecrementProductCartKey.self] = newValue }
    }
}

extension View {
    @ViewBuilder
    func onIncrementProductCart(_ action: @escaping (Product) -> Void) -> some View {
        environment(\.onIncrementProductCart, action)
    }
    
    @ViewBuilder
    func onDecrementProductCart(_ action: @escaping (Product) -> Void) -> some View {
        environment(\.onDecrementProductCart, action)
    }
}
