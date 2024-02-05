//
//  ProductCell.swift
//  Grocer
//
//  Created by Ahmed Yamany on 02/02/2024.
//

import SwiftUI

struct ProductCell: View {
    let product: Product
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(uiImage: product.firstImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            productDetails
        }
        .frame(width: 140, height: 170)
        .background(.grInputField)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var productDetails: some View {
        ProductCellContent(product: product)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .frame(width: 140, height: 60, alignment: .topLeading)
            .background(.ultraThinMaterial)
    }
}

struct ProductCellContent: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: .Constants.cellPadding) {
            Text(product.name ?? "")
                .font(.medium(weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                ProductCellLabel(imageSystemName: "tag.fill", text: product.priceString + " $")
                ProductCellLabel(imageSystemName: "shippingbox.fill", text: String(product.quantity))
            }
        }
    }
}

struct ProductCellLabel: View {
    let imageSystemName: String
    let text: String
    
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: imageSystemName)
            Text(text)
        }
        .imageScale(.small)
        .font(.small(weight: .medium))
    }
}
