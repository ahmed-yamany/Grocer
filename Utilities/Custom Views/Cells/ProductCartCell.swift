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
    
    @State var value = 1
    
    var body: some View {
        HStack(alignment: .top, spacing: .Constants.cellSpacing) {
            Image(uiImage: product.firstImage())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 82, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: .Constants.cornerRadius))
            
            VStack(alignment: .leading, spacing: .Constants.cellPadding) {
                ProductCellContent(product: product)
                
                stepperView
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.Constants.cellPadding)
        .background(.grInputField)
        .clipShape(RoundedRectangle(cornerRadius: .Constants.cornerRadius))
        .onAppear {
            value = count
        }
    }
    
    var stepperView: some View {
        Text("\(value)")
    }
    
}
