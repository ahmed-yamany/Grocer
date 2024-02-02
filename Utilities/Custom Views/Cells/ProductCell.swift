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
            Image(uiImage: getFirstImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            productDetails
        }
        .frame(width: 140, height: 170)
        .background(.grInputField)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var productDetails: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(product.name ?? "")
                .font(.medium(weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                label(imageSystemName: "tag.fill", text: product.priceString)
                label(imageSystemName: "shippingbox.fill", text: String(product.quantity))
            }
        }
        .imageScale(.small)
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
        .frame(width: 140, height: 60, alignment: .topLeading)
        .background(.ultraThinMaterial)
    }
    
    private func getFirstImage() -> UIImage {
        guard let image = product.images?.toUIImages().first as? UIImage else {
            return UIImage()
        }
        
        return image
    }
    
    @ViewBuilder
    private func label(imageSystemName: String, text: String) -> some View {
        HStack(spacing: 2) {
            Image(systemName: imageSystemName)
            Text(text)
        }
        .imageScale(.small)
        .font(.small(weight: .medium))
    }
}
