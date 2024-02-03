//
//  Product.swift
//  Grocer
//
//  Created by Ahmed Yamany on 02/02/2024.
//

import Foundation

extension Product {
    var priceString: String {
        String(format: "%.1f", price)
    }
    
    var quantityString: String {
        String(quantity)
    }
}
